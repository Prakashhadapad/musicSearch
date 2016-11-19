//
//  MSStatusCode.h
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/18/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSStatusCode : NSObject

@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong) NSString *statusMessage;

@end
