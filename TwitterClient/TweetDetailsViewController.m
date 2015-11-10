//
//  TweetDetailsViewController.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/9/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"

@interface TweetDetailsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *favouriteCountLabel;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setTweetDetails];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTweetDetails {
    
    
    self.nameLabel.text = self.tweet.user.name;
    NSLog(@"\n\nTweet username: %@ nameLabel text: %@",self.tweet.user.name,self.nameLabel.text);
    self.screenNameLabel.text = self.tweet.user.screenName;
    self.tweetTextLabel.text = self.tweet.text;
    
    //convert date to string
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm:ss a"];
    NSString *dateString = [dateFormatter stringFromDate:self.tweet.createdAt];
    self.dateLabel.text = dateString;
    
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    
    //dateLabel;
    //self.retweetCountLabel = ;
    //favouriteCountLabel = tweet.;
    //profileImage;
    
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
