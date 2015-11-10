//
//  TweetCellTableViewCell.h
//  TwitterClient
//
//  Created by Aswani Nerella on 11/9/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (nonatomic, strong) Tweet *tweet;
- (void)setTweetCell: (Tweet *)tweet;
@end
