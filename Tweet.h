//
//  Tweet.h
//  TwitterClient
//
//  Created by Aswani Nerella on 11/8/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Tweet : NSObject

@property(strong, nonatomic) NSString *text;
@property(strong, nonatomic) NSDate *createdAt;
@property(strong, nonatomic) User *user;

- (id) initWithDictionary:(NSDictionary *) dictionary;
+ (NSArray *) tweetsWithArray:(NSArray *) array;
@end
