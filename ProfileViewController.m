//
//  ProfileViewController.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/15/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "ProfileViewController.h"
#import "User.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *tweets;
@property (weak, nonatomic) IBOutlet UILabel *followers;
@property (weak, nonatomic) IBOutlet UILabel *following;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setProfileDetails];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProfileDetails {
    self.userName.text = self.user.name;
    self.tweets.text = [NSString stringWithFormat:@"%@ Tweets",self.user.numOfTweets];
    self.followers.text = [NSString stringWithFormat:@"%@ Followers",self.user.numOfFollowers];
    self.following.text = [NSString stringWithFormat:@"%@ Following",self.user.numOfFriends];
    
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
