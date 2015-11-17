//
//  TweetsViewController.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/9/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetCellTableViewCell.h"
#import "TweetDetailsViewController.h"
#import "ComposeViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"

@interface TweetsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Add bar button items: "Search" on the right and "Cancel" on the left
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onUserLogout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onCompose)];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib: [UINib nibWithNibName:@"TweetCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"tweetCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 400;
    
    [self fetchTweets];
    [self setUpRefreshControl];
    
    
    
}

- (void) setUpRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchTweets {
    //if (self.fetchTimeline) {
        [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            for(Tweet *tweet in tweets){
                NSLog(@"text %@", tweet.text);
            }
            self.tweets = tweets;
            [self.tableView reloadData];
        }];
    //}else{
//        [[TwitterClient sharedInstance] mentionsWithParams:nil completion:^(NSArray *tweets, NSError *error) {
//            for(Tweet *tweet in tweets){
//                NSLog(@"text %@", tweet.text);
//            }
//            self.tweets = tweets;
//            [self.tableView reloadData];
//        }];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table views
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    [cell setTweetCell:self.tweets[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get destination view
    NSLog(@"Row selected: %ld",indexPath.row);
    TweetDetailsViewController *vc = [[TweetDetailsViewController alloc]init];
    vc.tweet = self.tweets[indexPath.row];
    //[vc setTweetDetails:self.tweets[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[self navigationController]pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) onUserLogout{
    [self dismissViewControllerAnimated:YES completion:nil];
    [User logout];

}

- (void) onCompose{
    ComposeViewController *vc = [[ComposeViewController alloc]init];
    vc.user = [User currentUser];
    [[self navigationController]pushViewController:vc animated:YES];
    
}

- (void)onRefresh {
    [self fetchTweets];
    [self.refreshControl endRefreshing];
}

@end
