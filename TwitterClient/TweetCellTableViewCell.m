//
//  TweetCellTableViewCell.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/9/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "TweetCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"
#import "User.h"

@implementation TweetCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweetCell:(Tweet *) tweet {
    _tweet = tweet;
    self.usernameLabel.text =tweet.user.name;
    
    //convert date to string
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm:ss a"];
    NSString *dateString = [dateFormatter stringFromDate:tweet.createdAt];
    self.postDateLabel.text = dateString;
    
    
    self.tweetTextLabel.text = tweet.text;
    [self.profileImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    
    
}

@end
