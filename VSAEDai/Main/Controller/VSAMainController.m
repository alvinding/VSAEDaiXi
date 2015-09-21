//
//  VSAMainController.m
//  VSAEDai
//
//  Created by alvin on 15/9/17.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "VSAMainController.h"
#import "VSAMainTabBar.h"
#import "WashController.h"
#import "VSANavigationController.h"
#import "VSAOrderController.h"
#import "VSAMineController.h"

@interface VSAMainController () <VSAMainTabBarDelegate, UIScrollViewDelegate>
@property (nonatomic, weak) VSAMainTabBar *mainTabBar;
@property (nonatomic, weak) VSANavigationController *currentNaviVC;
@end

@implementation VSAMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //显示VC
    WashController *washVC = [[WashController alloc] init];
    VSANavigationController *naviVC = [[VSANavigationController alloc] initWithRootViewController:washVC];
    [self addChildViewController:naviVC];
    [self.view addSubview:naviVC.view];
    self.currentNaviVC = naviVC;
    
    VSAOrderController *orderVC = [[VSAOrderController alloc] init];
    VSANavigationController *orderNaviVC = [[VSANavigationController alloc] initWithRootViewController:orderVC];
    [self addChildViewController:orderNaviVC];
    
    VSAMineController *mineVC = [[VSAMineController alloc] init];
    VSANavigationController *mineNaviVC = [[VSANavigationController alloc] initWithRootViewController:mineVC];
    [self addChildViewController:mineNaviVC];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    VSAMainTabBar *tabBar = [[VSAMainTabBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.height = 49;
    tabBar.width = self.view.width;
    tabBar.y = self.view.height - tabBar.height;
    
    self.mainTabBar = tabBar;
    tabBar.delegate = self;
    [self.view addSubview:tabBar];
    
    
    //通知
    [VSANotificationCenter addObserver:self selector:@selector(hideTabBar) name:VSAMainTabBarHideNotification object:nil];
    [VSANotificationCenter addObserver:self selector:@selector(showTabBar:) name:VSAMainTabBarShowNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 监听事件
- (void)hideTabBar {
    NSLog(@"隐藏tabBar");
    [UIView animateWithDuration:1 animations:^{
        self.mainTabBar.transform = CGAffineTransformMakeTranslation(0, self.view.height);
    } completion:^(BOOL finished) {
//        [self.mainTabBar removeFromSuperview];
    }];
}

- (void)showTabBar:(NSNotification *)notification {
//    UINavigationController *naviVC = notification.userInfo[@"naviVC"];
//    NSUInteger count = naviVC.viewControllers.count;
//    if(count <= 2) {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.mainTabBar.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            //        [self.view addSubview:self.mainTabBar];
//        }];
//    }
    [UIView animateWithDuration:0.25 animations:^{
        self.mainTabBar.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //        [self.view addSubview:self.mainTabBar];
    }];

}

#pragma mark - VSAMainTabBarDelegate
- (void)changeViewControllerFrom:(VSAMainTabBarButtonType)fromType to:(VSAMainTabBarButtonType)toType {
    NSLog(@"%ld -- %ld", fromType, toType);
    VSANavigationController *oldNaviVC = self.childViewControllers[fromType];
    [oldNaviVC.view removeFromSuperview];
    VSANavigationController *newNaviVC = self.childViewControllers[toType];
    [self.view insertSubview:newNaviVC.view belowSubview:self.mainTabBar];
    self.currentNaviVC = newNaviVC;
}

@end
