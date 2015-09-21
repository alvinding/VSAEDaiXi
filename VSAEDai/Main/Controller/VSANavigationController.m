//
//  VSANavigationController.m
//  VSAEDai
//
//  Created by alvin on 15/9/17.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "VSANavigationController.h"

@interface VSANavigationController ()

@end

@implementation VSANavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setTitle:(NSString *)title {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationBar setTitleTextAttributes:dic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *vc = [super popViewControllerAnimated:YES];
    NSUInteger count = vc.navigationController.viewControllers.count;
    if (count <= 1) {
        [VSANotificationCenter postNotificationName:VSAMainTabBarShowNotification object:nil];
    }
    NSLog(@"pop count -- %ld", count);
    return vc;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //在push之前，把系统默认的back 替换掉
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [backBtnItem setTitleTextAttributes:textDict forState:UIControlStateNormal];
    backBtnItem.title = @"返回";
    viewController.navigationItem.backBarButtonItem = backBtnItem;
    
    if (self.viewControllers.count > 0) {
        [self setNaviBarItemsWithVC:viewController];
    }
    [super pushViewController:viewController animated:animated];
    
    //发通知，隐藏tabBar
    [VSANotificationCenter postNotificationName:VSAMainTabBarHideNotification object:nil];
}

- (void)setNaviBarItemsWithVC:(UIViewController *)viewController {
    
//    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"add_address_back" highlightImage:nil];
//    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    /*
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.width = 50;
    backBtn.height = 40;
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
     */
//    [viewController.navigationItem.backBarButtonItem setTitle:@"返回"];
    self.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)backClick {
    [self popViewControllerAnimated:YES];
}

@end
