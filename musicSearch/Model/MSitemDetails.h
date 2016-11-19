//
//  MSitemDetails.h
//  musicSearch
//
//  Created by Hadapad, Prakash on 11/18/16.
//  Copyright © 2016 vzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSitemDetails : NSObject

@property (nonatomic, strong) NSString *trackNames;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, strong) NSString *albumImageUrl;
@property (nonatomic, strong) NSString *albumLargeImageUrl;

@end
