//
//  MSSearchResult.h
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/18/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MSStatusCode.h"

@interface MSSearchResult : NSObject

@property (nonatomic, strong) NSMutableArray *resultArray;
/**
 * This method is used request for music search for along with user entered key
 * @param searchString  url pointing to the lyrics to be downloaded
 * @param completionBlock will be callbacked in the case of success data retrival
 */

- (void) retrieveMusicSearchForKey:(NSString *)searchString andCompletionBlock:(void(^)(MSStatusCode *))completionBlock;

/**
 * This method is used request for image download from server
 * @param imageUrl  url pointing to the image to be downloaded
 * @param completionBlock will be callbacked in the case of success data retrival
 */
- (void) getImageForUrl:(NSString *)imageUrl andCompletionBlock:(void(^)(UIImage *))completionBlock;

@end
