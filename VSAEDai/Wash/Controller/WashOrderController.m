//
//  WashOrderController.m
//  VSAEDai
//
//  Created by alvin on 15/9/17.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "WashOrderController.h"
#import "VSAAddressListController.h"
#import "VSALocationListController.h"

@interface WashOrderController () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) NSArray *weekDates;
@property (nonatomic, strong) NSArray *hourDates;
@end

@implementation WashOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.view.backgroundColor = VSAMainBackgroundColor;
   
    //初始化scrollView
    [self setupScrollView];
}

#pragma mark - 初始化
- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = scrollView.bounds;
//    tableView.y = 66;
    tableView.height = scrollView.height - 300;
    [scrollView addSubview:tableView];
    
    //下单按钮
    UIButton *orderBtn = [[UIButton alloc] init];
    [orderBtn setTitle:@"下单" forState:UIControlStateNormal];
//    [orderBtn setBackgroundImage:[UIImage imageNamed:@"e_my_btn_recharge"] forState:UIControlStateNormal];
    [orderBtn setBackgroundColor:[UIColor grayColor]];
//    orderBtn.centerX = self.view.centerX;
    NSLog(@"%f,  %f", orderBtn.x, orderBtn.centerX);
    orderBtn.width = self.view.width - 80;
    orderBtn.height = 31;
    orderBtn.y = tableView.height + 100;
    orderBtn.x = self.view.centerX - orderBtn.width / 2;
    [orderBtn setEnabled:NO];
    [scrollView addSubview:orderBtn];
}

-(NSArray *)hourDates {
    if (!_hourDates) {
        NSMutableArray *hourArray = [NSMutableArray array];
        NSDate *timeDate = [NSDate date];
        NSCalendar  *cal = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitHour;
        NSDateComponents *components = [cal components:unitFlags fromDate:timeDate];
        NSInteger hour = [components hour];
        
        //格式化时间
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"HH:00"];
        NSString *locationString = [dateformatter stringFromDate:timeDate];
        
        NSUInteger count = (24 - hour) / 2;
        VSALog(@"%ld", count);
    }
    
    return _hourDates;
}

- (NSArray *)weekDates {
    if (!_weekDates) {
        
        NSMutableArray *dateArray = [NSMutableArray array];
        
        NSDate *timeDate = [NSDate date];
        NSCalendar  *cal = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitWeekday;
        
        
        for (int i = 0; i < 7; i++) {
            NSDateComponents *component = [[NSDateComponents alloc] init];
            [component setDay:i];
            [component setYear:0];
            [component setMonth:0];
            NSDate *newdate = [cal dateByAddingComponents:component toDate:timeDate options:0];
            component = [cal components:unitFlags fromDate:newdate];
            
            NSInteger month=[component month];
            NSInteger day = [component day];
            /*
             1--星期日
             2--星期一
             。。。
             */
            NSInteger weak = [component weekday];
            NSString *weekStr;
            switch (weak) {
                case 1:
                    weekStr = @"星期日";
                    break;
                case 2:
                    weekStr = @"星期一";
                    break;
                case 3:
                    weekStr = @"星期二";
                    break;
                case 4:
                    weekStr = @"星期三";
                    break;
                case 5:
                    weekStr = @"星期四";
                    break;
                case 6:
                    weekStr = @"星期五";
                    break;
                case 7:
                    weekStr = @"星期六";
                    break;
                    
                default:
                    break;
            }
            
            NSString *dateStr = [NSString stringWithFormat:@"%@ %2ld-%2ld", weekStr, month, day];
            [dateArray addObject:dateStr];
        }
        
        _weekDates = dateArray;
        VSALog(@"%ld", dateArray.count);
    }
    return _weekDates;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
//    UINavigationController *naviVC = self.navigationController;
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"naviVC"] = naviVC;
//    [VSANotificationCenter postNotificationName:VSAMainTabBarShowNotification object:nil userInfo:dict];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"orderDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.separatorInset = UIEdgeInsetsMake(5, 10, 5, 10);

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"件洗9元， 袋洗99元";
            cell.textLabel.contentMode = UIViewContentModeCenter;
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.backgroundColor = [UIColor colorWithRed:200 green:200 blue:0 alpha:1.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1: {
            cell.textLabel.text = @"添加/选择地址";
            cell.textLabel.font = [UIFont systemFontOfSize:20];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            break;
        }
        case 2: {
            cell.textLabel.text = @"请选择时间";
            cell.textLabel.font = [UIFont systemFontOfSize:20];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            break;
        }
        case 3: {
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 44;
            break;
            
        default:
            break;
    }
    return (tableView.height - 44) / 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 1: {
//            VSAAddressListController *addressListVC = [[VSAAddressListController alloc] init];
            VSALocationListController *locationListVC = [[VSALocationListController alloc] init];
            [self.navigationController pushViewController:locationListVC  animated:YES];
            break;
        }
        case 2: {
            // 1. 获取当前时间并格式化
            NSArray *dateArray = dateArray;
            
            UIPickerView *pickerView = [[UIPickerView alloc] init];
//            UIDatePicker *datePicker = [[UIDatePicker alloc] init];
//            datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            pickerView.frame = CGRectMake(0, self.view.height - 150, self.view.width, 150);
            pickerView.dataSource = self;
            pickerView.delegate = self;
            pickerView.showsSelectionIndicator = YES;
            [self.view addSubview:pickerView];
        }
        default:
            break;
    }
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.weekDates.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 20;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.weekDates[row];
            break;
        case 1:
            return self.hourDates[row];
        default:
            break;
    }
    return nil;
}

////格式化时间
//NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
//[dateformatter setDateFormat:@"HH:mm:ss"];
//NSString *locationString = [dateformatter stringFromDate:timeDate];
@end
