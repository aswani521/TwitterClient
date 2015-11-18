//
//  HamburgerViewController.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/17/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "HamburgerViewController.h"
#import "MenuViewController.h"
#import "TweetsViewController.h"
#import "ProfileViewController.h"
#import "User.h"

@interface HamburgerViewController ()

//Two view properties
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong,nonatomic) UIViewController *contentController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;
@property (nonatomic, assign) CGFloat originalLeftMargin;

- (IBAction)onPan:(UIPanGestureRecognizer *)sender;
@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Load Tweets View controller by default
//    ProfileViewController *tvc = [[ProfileViewController alloc]init];
//    tvc.user = [User currentUser];
//    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tvc];
//    [self addChildViewController:nvc];
//    nvc.view.frame = self.view.frame;
//    
//    [self.contentView addSubview:nvc.view];
//    [nvc didMoveToParentViewController:self];
    
    [self setupMenuController];
    [self setupContentController];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeContentView {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.leftMarginConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
    
    // Absolute (x,y) coordinates in parentView
    CGPoint translatedLocation = [sender translationInView:self.view];
    CGPoint velocityInView = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalLeftMargin = self.leftMarginConstraint.constant;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.leftMarginConstraint.constant = self.originalLeftMargin + translatedLocation.x;
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            if (velocityInView.x > 0) {
                self.leftMarginConstraint.constant = self.view.frame.size.width - 250;
            }else{
                self.leftMarginConstraint.constant = 0;
            }
            [self.view layoutIfNeeded];
        }];
    }
}

-(void)setupMenuController {
    
    _menuViewController = [[MenuViewController alloc] init];
    _menuViewController.hvc = self;
    [self.menuView addSubview:_menuViewController.view];
    [self.view layoutIfNeeded];
}

- (void) setupContentController {
    UIViewController *tweetsVC = [[TweetsViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tweetsVC];
    [self hideCurrentContentController];
    [self displayContentController:nvc];
}

-(void) setMenuController:(MenuViewController *)vc {
    _menuViewController = vc;
    _menuViewController.hvc = self;
    [self.menuView addSubview:vc.view];
}

- (void)setUpContentViewController: (UIViewController *)contentViewController {
    [self.view layoutIfNeeded];
    [self.contentView addSubview:contentViewController.view];
    [self closeContentView];
    
}


-(void) displayContentController:(UIViewController *)content {
    [self addChildViewController:content];
    content.view.frame = self.view.frame;
    
    [self.contentView addSubview: content.view];
    [content didMoveToParentViewController:self];
    self.contentController = content;
}

-(void) hideCurrentContentController {
    UIViewController *content = self.contentController;
    [content willMoveToParentViewController: nil];
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}

@end
