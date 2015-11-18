//
//  HamburgerViewController.h
//  TwitterClient
//
//  Created by Aswani Nerella on 11/17/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@class MenuViewController;

@interface HamburgerViewController : UIViewController

//View controllers in the container controller
@property (strong,nonatomic) MenuViewController *menuViewController;
@property (strong,nonatomic) UIViewController *contentViewController;
- (void)hideCurrentContentController;
- (void)displayContentController:(UIViewController *)content;
- (void)closeContentView;

@end
