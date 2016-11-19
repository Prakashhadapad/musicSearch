//
//  MSWebServiceManager.h
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/18/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSWebServiceManager : NSObject
/**
 * This method is used GET data from server
 * @param urlString  url pointing to the data to be downloaded
 * @param successBlock will be callbacked in the case of success data retrival
* @param failureBlock  will be callbacked in the case of failure
 */
- (void) getDataFromUrl:(NSString *)urlString withSuccessCallBack:(void(^) (id))successBlock andFailureCallBack:(void(^) (NSError *))failureBlock;

/**
 * This method is used download image data from server
 * @param imageUrl  url pointing to the image to be downloaded
 * @param successBlock will be callbacked in the case of success data retrival
 * @param failureBlock  will be callbacked in the case of failure
 */
- (void) downloadImage:(NSString *)imageUrl withSuccessCallBack:(void(^) (NSURL *))successBlock andFailureCallBack:(void(^) (NSError *))failureBlock;

/**
 * This method is used GET lyrics data from server
 * @param url  url pointing to the lyrics to be downloaded
 * @param successBlock will be callbacked in the case of success data retrival
 * @param failureBlock  will be callbacked in the case of failure
 */
- (void)getSongLyrics:(NSString *)url withSuccessCallBack:( void (^) (id))successBlock andFailureCallBack:(void(^) (NSError *))failureBlock;

@end
