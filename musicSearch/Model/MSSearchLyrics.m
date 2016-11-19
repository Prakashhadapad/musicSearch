//
//  MSSearchLyrics.m
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/19/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import "MSSearchLyrics.h"
#import "MSWebServiceManager.h"
#import "MSStatusCode.h"
#import "MSWebServiceManager.h"
#import "MSXmlParser.h"

@implementation MSSearchLyrics

- (void ) getLyricsFor:(NSString *)articsName withTrackName:(NSString*)trackName withSuccessCallBack:(void (^) (id))successBlock withFailureCallBack:(void (^) (NSError *)) failureBlock {
    
    NSString *urlString = [NSString stringWithFormat:@"http://lyrics.wikia.com/api.php?func=getSong&artist=%@&song=%@&fmt=xml",articsName,trackName];
    
    MSWebServiceManager *serviceManager = [[MSWebServiceManager alloc] init];
    
    [serviceManager getSongLyrics:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] withSuccessCallBack:^(id response) {
        
        if (response!=nil) {
            
            MSXmlParser *xmlparser = [[MSXmlParser alloc] init];
            xmlparser.callBack = ^(NSString *parsedXmldata) {
                
                successBlock(parsedXmldata);
            };
            [xmlparser getvalueForLyrics:response];
           
            
        } else {
            successBlock(@"Lyrics Not found");
        }
        
        
    } andFailureCallBack:^(NSError *error) {
        failureBlock(error);
    }];
    
}


@end
