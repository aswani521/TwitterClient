//
//  MenuViewController.h
//  TwitterClient
//
//  Created by Aswani Nerella on 11/16/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewControllerDelegate <NSObject>

- (void)menuViewController:(MenuViewController *)menuViewController selectedViewController:(UIViewController *) viewController;

@end

@interface MenuViewController : UIViewController

@property (strong, nonatomic) UINavigationController *nvc;
@property (nonatomic, weak)id<MenuViewControllerDelegate> delegate;

@end
