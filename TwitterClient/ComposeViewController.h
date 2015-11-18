//
//  ComposeViewController.h
//  TwitterClient
//
//  Created by Aswani Nerella on 11/9/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Tweet.h"

@interface ComposeViewController : UIViewController
@property (strong,nonatomic) User *user;
@property (strong,nonatomic) Tweet *tweet;
@end
