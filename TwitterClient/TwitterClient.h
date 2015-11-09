//
//  TwitterClient.h
//  TwitterClient
//
//  Created by Aswani Nerella on 11/8/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

//#import <BDBOAuth1Manager/BDBOAuth1Manager.h>
#import <BDBOAuth1Manager/BDBOAuth1RequestOperationManager.h>
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) sharedInstance;

- (void) loginWithCompletion:(void (^)(User *user, NSError *error)) completion;
- (void) openURL:(NSURL *) url;
@end
