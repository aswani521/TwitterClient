//
//  Tweet.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/8/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "Tweet.h"
#import "User.h"
@implementation Tweet

- (id) initWithDictionary:(NSDictionary *) dictionary{
    self = [super init];
    if (self) {
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.selectedUserRetweet = dictionary[@"current_user_retweet"];
        
        self.text = dictionary[@"text"];
        NSString *createAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        
        self.createdAt = [formatter dateFromString:createAtString];
        
    }
    return self;
    
}

+ (NSArray *) tweetsWithArray:(NSArray *)array{
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary * dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    return tweets;

}

@end
