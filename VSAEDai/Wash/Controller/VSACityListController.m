//
//  VSACityListController.m
//  VSAEDai
//
//  Created by alvin on 15/9/23.
//  Copyright © 2015年 alvin. All rights reserved.
//

#import "VSACityListController.h"
#import "INTULocationManager.h"
#import "MBProgressHUD.h"

@interface VSACityListController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic, strong) NSMutableArray *cityKeys;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *locateBtn;
@property (nonatomic, strong) CLGeocoder *geocoder;
@end

@implementation VSACityListController

#pragma mark - 懒加载
-(CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCities];
    [self setupHeadBar];
    [self setupLocateView];
    [self setupTableView];
}

#pragma mark - 初始化
- (void)setupHeadBar {
    UIView *headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, self.view.width, 49);
    [self.view addSubview:headView];
    headView.backgroundColor = VSAMainBlueColor;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"city_close"] forState:UIControlStateNormal];
    [closeBtn sizeToFit];
    closeBtn.x = 10;
    closeBtn.y = 20;
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:closeBtn];
}

- (void)setupLocateView {
    UIView *locateView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, self.view.width, 40)];
    locateView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:locateView];
    
    UILabel *locateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 30)];
    locateLabel.text = @"定位城市";
    locateLabel.font = [UIFont systemFontOfSize:13];
    [locateView addSubview:locateLabel];
    
    UIButton *locateBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(locateLabel.frame), 15, 100, 30)];
    [locateBtn setTitle:@"点击定位" forState:UIControlStateNormal];
    locateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [locateBtn addTarget:self action:@selector(locateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.locateBtn = locateBtn;
    [locateView addSubview:locateBtn];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.height -= 89;
    tableView.y = 89;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
}

- (void)loadCities {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    self.cityKeys = [NSMutableArray array];
    [self.cityKeys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    VSALog(@"%@, %ld", self.cities, self.cityKeys.count);
}

#pragma mark - 监听事件
- (void)closeBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)locateBtnClick {
    INTULocationManager *mgr = [INTULocationManager sharedInstance];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //获取CLLocation -> 获取对应的CLPlacemark -> 获取对应的城市
    [mgr requestLocationWithDesiredAccuracy:INTULocationAccuracyNeighborhood timeout:30 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        if (status == INTULocationStatusSuccess) {
            [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                for (CLPlacemark *pk in placemarks) {
                    VSALog(@"====>%@", pk.addressDictionary);
                }
                if (error) {
                    [self.locateBtn setTitle:@"定位失败" forState:UIControlStateNormal];
                    return;
                }
                CLPlacemark *placemark = [placemarks lastObject];
                
                NSString *city = placemark.locality;
                [self.locateBtn setTitle:city forState:UIControlStateNormal];
            }];
        } else if (status == INTULocationStatusTimedOut) {
            [self.locateBtn setTitle:@"超时" forState:UIControlStateNormal];
        } else {
            [self.locateBtn setTitle:@"定位失败" forState:UIControlStateNormal];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = self.cityKeys[section];
    NSArray *array = self.cities[key];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    NSString *title = titleLabel.text = self.cityKeys[section];
    [bgView addSubview:titleLabel];
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSString *key = self.cityKeys[indexPath.section];
    NSString *title = cell.textLabel.text = self.cities[key][indexPath.row];
    
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.cityKeys;
}

@end
