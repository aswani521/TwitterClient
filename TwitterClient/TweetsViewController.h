//
//  TweetsViewController.h
//  TwitterClient
//
//  Created by Aswani Nerella on 11/9/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetsViewController : UIViewController

@property (strong,nonatomic) NSArray *tweets;
- (void)onUserLogout;
@end
