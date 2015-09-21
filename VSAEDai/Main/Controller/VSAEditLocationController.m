//
//  VSAEditLocationController.m
//  VSAEDai
//
//  Created by alvin on 15/9/18.
//  Copyright © 2015年 alvin. All rights reserved.
//

#import "VSAEditLocationController.h"
#import "VSALocationTool.h"

@interface VSAEditLocationController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UITextField *name;
@property (nonatomic, weak) UITextField *phone;
@property (nonatomic, weak) UITextField *addr;
@end

@implementation VSAEditLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    UIButton *button = [[UIButton alloc] init];
//    [button setTitle:@"添加" forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor greenColor];
//    button.frame = CGRectMake(100, 100, 100, 30);
//    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    //初始化tableView
    [self setupTableView];
}

#pragma mark - 初始化
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = self.view.bounds;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
//    
//    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
//    textDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    [rightItem setTitleTextAttributes:textDict forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClick {
    
}

- (void)saveBtnClick {
    VSALog(@"save location ok -- %@, %@, %@", self.name.text, self.phone.text, self.addr.text);
    VSALocation *location = [[VSALocation alloc] init];
    location.name = self.name.text;
    location.phone = self.phone.text;
    location.location = self.addr.text;
    [VSALocationTool saveLocation:location];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"editAddrCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UITextField *textField = [[UITextField alloc] init];
    textField.height = cell.height;
    textField.width = cell.width - 10;
    textField.x = 5;
    switch (indexPath.row) {
        case 0: {
            textField.placeholder = @"您的姓名";
            self.name = textField;
            break;
        }
        case 1: {
            textField.placeholder = @"手机号码";
            textField.keyboardType = UIKeyboardTypeNumberPad;
            self.phone = textField;
            break;
        }
        case 2: {
            textField.placeholder = @"详细地址";
            self.addr = textField;
            break;
        }
        default:
            break;
    }
    [cell addSubview:textField];
    return cell;
}

@end
