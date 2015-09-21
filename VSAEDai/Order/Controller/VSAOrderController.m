//
//  VSAOrderController.m
//  VSAEDai
//
//  Created by alvin on 15/9/18.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "VSAOrderController.h"

@interface VSAOrderController ()

@end

@implementation VSAOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VSAMainBackgroundColor;
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] init];
    [segmentedControl insertSegmentWithTitle:@"服务中" atIndex:0 animated:NO];
//    segmentedControl.tintColor = [UIColor whiteColor];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blueColor];
    [segmentedControl setTitleTextAttributes:dict forState:UIControlStateSelected];
    [segmentedControl insertSegmentWithTitle:@"已完成" atIndex:1 animated:NO];
    
    [self.navigationController.navigationBar addSubview:segmentedControl];
    segmentedControl.width = self.view.width / 2;
    segmentedControl.height = self.navigationController.navigationBar.height - 20;
    segmentedControl.centerX = self.view.width / 2;
    segmentedControl.centerY = self.navigationController.navigationBar.height / 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
