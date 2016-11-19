//
//  MSSearchLyrics.h
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/19/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSSearchLyrics : NSObject

/**
 * This method is used request for lyrics search for along with artics name and trackname
 * @param successBlock  url pointing to the lyrics to be downloaded
 * @param failureBlock will be callbacked in the case of success data retrival
 */

- (void ) getLyricsFor:(NSString *)articsName withTrackName:(NSString*)trackName withSuccessCallBack:(void (^) (id))successBlock withFailureCallBack:(void (^) (NSError *)) failureBlock;

@end
