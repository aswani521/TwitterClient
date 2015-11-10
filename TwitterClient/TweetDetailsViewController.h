//
//  TweetDetailsViewController.h
//  TwitterClient
//
//  Created by Aswani Nerella on 11/9/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetailsViewController : UIViewController
@property (strong,nonatomic) Tweet* tweet;
//- (void)setTweetDetails: (Tweet *)tweet;
@end
