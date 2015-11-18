//
//  TwitterClient.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/8/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"
NSString * const kTwitterConsumerKey = @"z7OtqPXe0m1AZ7FLmZv6GqmBc";
NSString * const kTwitterConsumerSecret = @"DyhphHGF1tbIQd72c9oYhyBdjEHdWappVZJ4Nb6HKm4xDkgGC1";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()
@property(nonatomic,strong) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if(instance == nil){
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    
    
    return instance;
}

- (void) loginWithCompletion:(void (^)(User *user, NSError *error)) completion{
    
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken){
        NSLog(@"got the request token!!");
        
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        
        [[UIApplication sharedApplication] openURL:authURL];
    } failure:^(NSError *error){
        NSLog(@"failed to get access token");
        self.loginCompletion(nil, error);
    }];
}

- (void) openURL:(NSURL *)url{
    
    [[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"got the access token!!!");
        
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            //            NSLog(@"current user: %@", responseObject);
            User *user = [[User alloc] initWithDictionary:responseObject];
            NSLog(@"current user: %@", user.name);
            [User setCurrentUser:user];
            self.loginCompletion(user, nil);
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"failed to get current user");
            self.loginCompletion(nil, error);
        }];
        
//        [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//            //            NSLog(@"tweets: %@ ", responseObject);
//            NSArray *tweets = [Tweet tweetsWithArray:responseObject];
//            for (Tweet *tweet in tweets) {
//                NSLog(@"tweet: %@, created: %@", tweet.text, tweet.createdAt);
//            }
//        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//            NSLog(@"failed to get tweets");
//        }];
        
    } failure:^(NSError *error) {
        NSLog(@"failed to get the access token");
        self.loginCompletion(nil, error);
    }];


}


- (void) homeTimelineWithParams:(NSDictionary *) params completion:(void (^)(NSArray *tweets, NSError *error)) completion{
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void) mentionsTimelineWithParams:(NSDictionary *) params completion:(void (^)(NSArray *tweets, NSError *error)) completion{
    [self GET:@"1.1/statuses/mentions_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

-(void)sendTweet:(Tweet *)tweet withCompletion:(void (^)(Tweet *, NSError *))completion {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = tweet.text;
    
    [self POST:@"1.1/statuses/update.json" parameters:
       params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
           Tweet *tweet = [[Tweet alloc]initWithDictionary:responseObject];
           completion(tweet,nil);
       } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
           completion(nil,error);
       }];
}
@end
