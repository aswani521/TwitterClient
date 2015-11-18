//
//  MenuViewController.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/15/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//


#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "ProfileViewController.h"
#import "TweetsViewController.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *viewControllers;

@end



@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    ProfileViewController *pvc = [[ProfileViewController alloc]init];
    pvc.user = [User currentUser];
    
    TweetsViewController *tvc = [[TweetsViewController alloc]init];
    TweetsViewController *mvc = [[TweetsViewController alloc]init];

    [mvc setFetchHomeTimeline:NO];
    
    self.viewControllers = [NSMutableArray arrayWithArray:@[pvc,tvc,mvc]];
    
    //Add all view controllers to viewControllers array
//    [viewControllers addObject:pvc];
//    [viewControllers addObject:tvc];
//    [viewControllers addObject:tvc];
    
    //Add table view initialization
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib: [UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"menuCell"];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    switch(indexPath.row) {
        case 0:cell.itemLabel.text = @"Profile"; break;
        case 1:cell.itemLabel.text = @"Home Timeline";break;
        case 2:cell.itemLabel.text = @"Mentions";break;
        default: break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
    
    [self.hvc hideCurrentContentController];
    [self.hvc displayContentController:self.viewControllers[indexPath.row]];
    [self.hvc closeContentView];
    
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
