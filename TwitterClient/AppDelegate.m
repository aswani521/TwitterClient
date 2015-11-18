//
//  AppDelegate.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/6/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HamburgerViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
    //Setup login screen depending on whether the user is logged in or not
    [self setLoginScreen];
    return YES;
}

- (void) setLoginScreen {
    User *currentUser = [User currentUser];
    if (currentUser != nil) {
        NSLog(@"Welcome to %@", currentUser.name);
        UIViewController *hvc = [[HamburgerViewController alloc] init];
        //UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:hvc];
        
        self.window.rootViewController = hvc;
    } else {
        NSLog(@"User not logged in");
        self.window.rootViewController = [[LoginViewController alloc] init];
    }
    
    
    [self.window makeKeyAndVisible];
    
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [[TwitterClient sharedInstance] openURL:url];
    
    return YES;

}
@end
