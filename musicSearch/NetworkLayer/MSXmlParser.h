//
//  MSXmlParser.h
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/19/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MSXmlParser : NSObject

@property (nonatomic,strong) void (^callBack)(NSString*);
- (NSString *)getvalueForLyrics:(NSData *)parse;
@end
