//
//  VSAMainController.m
//  VSAEDai
//
//  Created by alvin on 15/9/17.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "VSAMainController.h"
#import "VSAMainTabBar.h"

@interface VSAMainController ()

@end

@implementation VSAMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    VSAMainTabBar *tabBar = [[VSAMainTabBar alloc] init];
    tabBar.height = 44;
    tabBar.width = self.view.width;
    tabBar.y = self.view.height - tabBar.height;
    
    [self.view addSubview:tabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
