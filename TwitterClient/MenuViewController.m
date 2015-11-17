//
//  MenuViewController.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/16/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "TweetsViewController.h"
#import "ProfileViewController.h"
#import "User.h"

@interface MenuViewController ()

- (IBAction)onProfile:(id)sender;

- (IBAction)onHome:(id)sender;

- (IBAction)onMentions:(id)sender;


@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nvc = [[UINavigationController alloc]init];
    self.title = @"Menu";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onProfile:(id)sender {
    ProfileViewController *pvc = [[ProfileViewController alloc]init];
    pvc.user = [User currentUser];
    [self.delegate menuViewController:self selectedViewController:pvc];
    
}

- (IBAction)onHome:(id)sender {
    TweetsViewController *tvc = [[TweetsViewController alloc]init];
    tvc.fetchTimeline = YES;
    [self.delegate menuViewController:self selectedViewController:tvc];
}

- (IBAction)onMentions:(id)sender {
    TweetsViewController *tvc = [[TweetsViewController alloc]init];
    tvc.fetchTimeline = NO;
    [self.delegate menuViewController:self selectedViewController:tvc];
}
@end
