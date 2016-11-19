//
//  MSWebServiceManager.m
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/18/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import "MSWebServiceManager.h"
#import "Reachability.h"
#import "MSConstants.h"

@implementation MSWebServiceManager


- (void) getDataFromUrl:(NSString *)urlString withSuccessCallBack:(void(^) (id))successBlock andFailureCallBack:(void(^) (NSError *))failureBlock{

    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable ) {
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error) {
                
                failureBlock (error);
                
            } else {
                
                NSError *jsonError;
                id jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                
                successBlock(jsonResponse);
                
            }
            
        }];
        
        [dataTask resume];
    } else {
        
        NSError *error = [NSError errorWithDomain:errorDomian code:noNetworkErrorCode userInfo:@{@"errorMessage" : noNetworkErrorMessage}];
        
        failureBlock(error);
    }
    
    
    
}

- (void) downloadImage:(NSString *)imageUrl withSuccessCallBack:(void(^) (NSURL *))successBlock andFailureCallBack:(void(^) (NSError *))failureBlock {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable ) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageUrl]];
        
        NSURLSessionTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            if (error) {
                
                failureBlock (error);
                
            } else {
                
                successBlock(location);
                
            }
            
        }];
        
        [downloadTask resume];
        
    } else {
        
        NSError *error = [NSError errorWithDomain:errorDomian code:noNetworkErrorCode userInfo:@{@"errorMessage" : noNetworkErrorMessage}];
        
        failureBlock(error);
    }
    
}

-(void)getSongLyrics:(NSString *)url withSuccessCallBack:(void (^)(id))successBlock andFailureCallBack:(void (^)(NSError *))failureBlock{
    
     if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable ) {
         
         NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
         NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
         
         NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
         NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
             
             if (error) {
                 failureBlock (error);
             } else {
                 successBlock(data);
                 
             }
             
         }];
         
        [dataTask resume];
         
     } else {
         
         NSError *error = [NSError errorWithDomain:errorDomian code:noNetworkErrorCode userInfo:@{@"errorMessage" : noNetworkErrorMessage}];
         
         failureBlock(error);
     }

}


@end
