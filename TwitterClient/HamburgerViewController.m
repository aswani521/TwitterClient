//
//  HamburgerViewController.m
//  TwitterClient
//
//  Created by Aswani Nerella on 11/16/15.
//  Copyright © 2015 Aswani Nerella. All rights reserved.
//

#import "HamburgerViewController.h"
#import "MenuViewController.h"

@interface HamburgerViewController ()<MenuViewControllerDelegate>
@property (nonatomic,strong) UIViewController *contentViewController;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;

@property (nonatomic, assign) CGFloat originalLeftMargin;
@property (nonatomic) BOOL menuIsOpen;



@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"Menu";
    TweetsViewController *twc = [[TweetsViewController alloc]init];
    twc.fetchTimeline = YES;
    
    self.contentViewController = twc;
    //[self setUpContentViewShadow];
    [self setUpMenuViewController];
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    if (self.contentViewController) {
        [self closeMenu];
    }
    
    if (self.contentViewController) {
        [self removeContentViewController];
    }
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:contentViewController];
    contentViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                                              style:UIBarButtonItemStylePlain
                                                                                             target:self
                                                                                             action:@selector(openMenu)];
    [nvc willMoveToParentViewController:self];
    [self addChildViewController:nvc];
    [self.contentView addSubview:nvc.view];
    nvc.view.frame = self.contentView.frame;
    [nvc didMoveToParentViewController:self];
    
    _contentViewController = nvc;
}

- (void)closeMenu {
    self.menuIsOpen = NO;
}

- (void)openMenu {
    self.menuIsOpen = YES;
}

- (void)removeContentViewController {
    [self.contentViewController willMoveToParentViewController:nil];
    [self.contentViewController removeFromParentViewController];
    [self.contentViewController.view removeFromSuperview];
    [self.contentViewController didMoveToParentViewController:nil];
}

- (void)setMenuIsOpen:(BOOL)menuIsOpen {
    _menuIsOpen = menuIsOpen;
    //self.tapGestureRecognizer.enabled = menuIsOpen;
    self.contentViewController.view.userInteractionEnabled = !menuIsOpen;
    
    [UIView animateWithDuration:0.35 animations:^{
        self.leftMarginConstraint.constant = menuIsOpen ? 80 : 0;
        [self.view layoutIfNeeded];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setMenuViewController:(MenuViewController *)menuViewController {
    _menuViewController = menuViewController;
    [self.view layoutIfNeeded];
    [self.menuView addSubview:menuViewController.view];
}

- (void)setContentView {
    [self.contentView addSubview:self.contentViewController.view];
    
}

#pragma mark - MenuViewController delegate

- (void)setUpMenuViewController {
    MenuViewController *vc = [[MenuViewController alloc] init];
    [vc willMoveToParentViewController:self];
    [self addChildViewController:vc];
    [self.menuView addSubview:vc.view];
    vc.view.frame = self.menuView.frame;
    vc.delegate = self;
    [vc didMoveToParentViewController:self];
}

- (void) setUpContentViewController {
    TweetsViewController *tvc = [[TweetsViewController alloc]init];
    tvc.fetchTimeline = YES;
    
    //UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:tvc];
    [self hideCurrentViewController];
    [self displayContentController:tvc];
    
}

- (void)hideMenuView {
    self.leftMarginConstraint.constant = 0;
    
}

- (void)showMenuView {
    self.leftMarginConstraint.constant = self.view.frame.size.width-50;
}

- (void)menuViewController:(MenuViewController *)menuViewController selectedViewController:(UIViewController *) viewController {
    
    [self hideCurrentViewController];
    [self displayContentController:viewController];
    [self hideMenuView];
}

- (void)displayContentController:(UIViewController *)viewController {
    //display content controller
    [self addChildViewController:viewController];
    viewController.view.frame = self.view.frame;
    [self.contentView addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    self.contentViewController = viewController;
}

- (void)hideCurrentViewController {
    //hide current controller
    UIViewController *currentController = self.contentViewController;
    [currentController willMoveToParentViewController:nil];
    [currentController.view removeFromSuperview];
    [currentController removeFromParentViewController];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
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
                self.leftMarginConstraint.constant = self.view.frame.size.width - 50;
            }else{
                self.leftMarginConstraint.constant = 0;
            }
            [self.view layoutIfNeeded];
        }];
    }
}
@end
