//
//  MSSearchResult.m
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/18/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import "MSSearchResult.h"
#import "MSWebServiceManager.h"
#import "MSStatusCode.h"
#import "MSConstants.h"
#import "MSitemDetails.h"


@interface MSSearchResult ()

@property (nonatomic, strong) MSWebServiceManager *serviceManager;

@end

@implementation MSSearchResult

-(id) init {
    
    self = [super init];
    self.resultArray = [[NSMutableArray alloc] init];
    
    if (self) {
        self.serviceManager = [[MSWebServiceManager alloc] init];
    }
    
    return self;
}


- (void) retrieveMusicSearchForKey:(NSString *)searchString andCompletionBlock:(void(^)(MSStatusCode *))completionBlock {
    
    NSString *urlString = [NSString stringWithFormat:@"%@=%@", iTunesBaseURL, searchString];
    
    MSStatusCode *status = [[MSStatusCode alloc] init];
    
    [self.serviceManager getDataFromUrl:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] withSuccessCallBack:^(id response) {
        
        NSError *parseError = [self parseProductListResponse:response];
        
        if (parseError) {
            status.statusCode = parseError.code;
            status.statusMessage = [self getErrorMessageForErrorCode:parseError.code];
        } else {
            status.statusCode = 0;
        }
        
        completionBlock (status);
        
    } andFailureCallBack:^(NSError *error) {
        
    }];

}

- (void) getImageForUrl:(NSString *)imageUrl andCompletionBlock:(void(^)(UIImage *))completionBlock {
    
    [self.serviceManager downloadImage:imageUrl withSuccessCallBack:^(NSURL* location) {
        
        UIImage *downloadedImage = [UIImage imageWithData:
                                    [NSData dataWithContentsOfURL:location]];
        completionBlock(downloadedImage);
        
    } andFailureCallBack:^(NSError *error) {
        completionBlock(nil);
    }];
}

- (NSError*) parseProductListResponse:(id)response {
    
    [self.resultArray removeAllObjects];
    
    NSError *error = nil;
    
    if([response isKindOfClass:[NSDictionary class]] &&
       [response[@"resultCount"] intValue] > 0 ) {
        
        
        NSArray *searchList = response[@"results"];
        
        for(NSDictionary *eachSeachItem in searchList) {
            MSitemDetails *searchItem = [[MSitemDetails alloc] init];

            searchItem.trackNames = [eachSeachItem valueForKey:TRACKNAME];
#warning NEED TO FIX IT Response doesnt not contain Album name
            
            if ([eachSeachItem valueForKey:ALBUMNAME]) {
                searchItem.albumName  = [eachSeachItem valueForKey:ALBUMNAME];
            }else{
                searchItem.albumName = @"Album name not available";
            }
        
            searchItem.artistName = [eachSeachItem valueForKey:ARTISTNAME];
            searchItem.albumImageUrl = [eachSeachItem valueForKey:ALBUMIMAGE];
            searchItem.albumLargeImageUrl = [eachSeachItem valueForKey:ALBUMLARGEIMAGE];
            
            [self.resultArray addObject:searchItem];
        }
        
    } else {
        error = [NSError errorWithDomain:errorDomian code:noDataErrorCode userInfo:@{@"errorMessage" : noDataErrorMessage}];
    }
    
    return error;
}

- (NSString *)getErrorMessageForErrorCode:(NSInteger)errorCode {
    
    NSString *errorMessage = defaultErrorMessage;
    
    switch (errorCode) {
        case noDataErrorCode:
            errorMessage = noDataErrorMessage;
            break;
        case noNetworkErrorCode:
            errorMessage = noNetworkErrorMessage;
            break;
            
        default:
            errorMessage = defaultErrorMessage;
            
            break;
    }
    
    return errorMessage;
}

@end
