//
//  VSALocationListController.m
//  VSAEDai
//
//  Created by alvin on 15/9/18.
//  Copyright © 2015年 alvin. All rights reserved.
//

#import "VSALocationListController.h"
#import "VSALocationTool.h"
#import "VSAAddressListCell.h"
#import "VSAEditLocationController.h"

@interface VSALocationListController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *locations;
@end

@implementation VSALocationListController

#pragma mark - 懒加载
- (NSMutableArray *)locations {
    if (!_locations) {
        _locations = (NSMutableArray *)[VSALocationTool locations];
    }
    
    return _locations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = self.view.bounds;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addBtnClick)];
//    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
//    textDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [rightItem setTitleTextAttributes:textDict forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"list vc will appear");
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 监听事件
- (void)addBtnClick {
    //push一个view,编辑地址信息
    VSAEditLocationController *editVC = [[VSAEditLocationController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locations.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VSALocation *location = self.locations[indexPath.row];
    
    static NSString *identifier = @"addressListCell";
    VSAAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [VSAAddressListCell addressListCell];
        cell.location = location;
    }
    
    return cell;
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
