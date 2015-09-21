//
//  VSAMineController.m
//  VSAEDai
//
//  Created by alvin on 15/9/18.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "VSAMineController.h"
#import "MJExtension.h"
#import "VSAMineCellModel.h"
#import "VSAAddressListController.h"
#import "VSALoginController.h"
#import "VSAShareView.h"

@interface VSAMineController () <UITableViewDataSource, UITableViewDelegate, VSAShareViewDelegate>
@property (nonatomic, weak) NSArray *cellModels;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *shareViewBtn;
@property (nonatomic, weak) UIView *shareView;
@property (nonatomic, strong) UIView *mainView;
@end

@implementation VSAMineController

#pragma mark - 懒加载
- (NSArray *)cellModels {
    if (!_cellModels) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AboutMe.plist" ofType:nil];
        _cellModels = [VSAMineCellModel objectArrayWithFile:path];
    }
    
    return _cellModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VSAMainBackgroundColor;
    
    //初始化tableView
    [self setupTableView];
    //初始化UIImageView
    [self setupImageView];
    
//    UINavigationController *naviVC = self.navigationController;
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"naviVC"] = naviVC;
//    [VSANotificationCenter postNotificationName:VSAMainTabBarShowNotification object:nil userInfo:dict];
}

#pragma mark - 初始化方法
- (void)setupImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, self.view.width, 118);
    imageView.image = [UIImage imageNamed:@"mine_background"];
    [self.scrollView addSubview:imageView];
    
    //logo 76*77
    UIImageView *avatarView = [[UIImageView alloc] init];
    avatarView.frame = CGRectMake(5, 10, 76, 77);
    avatarView.image = [UIImage imageNamed:@"mine_avatar"];
    [self.scrollView addSubview:avatarView];
    //登陆信息/提示
    UIButton *logonBtn = [[UIButton alloc] init];
    [logonBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    logonBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [logonBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGFloat btnX = CGRectGetMaxX(avatarView.frame) + 5;
    CGFloat btnY = avatarView.y;
    logonBtn.frame = CGRectMake(btnX, btnY, 100, 70);
    [logonBtn addTarget:self action:@selector(logonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:logonBtn];
}

- (void) setupTableView {
    //scrollView里面装tableView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(self.view.width, self.view.height - 49);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UITableView *tableView = [[UITableView alloc] init];
    CGFloat tableW = self.view.width;
    CGFloat tableH = self.view.height - 150 - 49 - 66;
    tableView.frame = CGRectMake(0, 150, tableW, tableH);
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.scrollEnabled = NO;
    [scrollView addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 监听事件
- (void)logonClick {
    VSALoginController *loginVC = [[VSALoginController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger totalCount = self.cellModels.count;
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return totalCount - 5;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VSAMineCellModel *model;
    switch (indexPath.section) {
        case 0: {
            model = self.cellModels[indexPath.row];
            break;
        }
        case 1: {
            model = self.cellModels[indexPath.row + 5];
            break;
        }
        default:
            break;
    }
//    VSAMineCellModel *model = self.cellModels[indexPath.row];
    UIImage *image = [UIImage imageNamed:model.pic];
    
    static NSString *identifier = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.imageView.image = image;
    //让cell没有点击效果
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_right"]];
    CGRect rect = arrowImageView.frame;
    rect.origin.x = self.view.width - 40;
    rect.origin.y = 10;
    arrowImageView.frame = rect;
    [cell.contentView addSubview:arrowImageView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 2: { //常用地址
                    VSAAddressListController *addressListVC = [[VSAAddressListController alloc] init];
                    [self.navigationController pushViewController:addressListVC animated:YES];
                    break;
                }
                case 3: {
                    //获取最上面的window
                    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
                    
                    //获取要缩放的view
                    UIView *mainView = self.navigationController.view.superview;
                    self.mainView = mainView;
                    [UIView animateWithDuration:0.25 animations:^{
                        mainView.transform = CGAffineTransformScale(mainView.transform, 0.9, 0.9);
                    }];
                    
                    //添加透明的button
                    UIButton *shareViewBtn = [[UIButton alloc] init];
                    shareViewBtn.frame = self.view.bounds;
                    shareViewBtn.backgroundColor = [UIColor blackColor];
                    shareViewBtn.alpha = 0.7;
                    [window addSubview:shareViewBtn];
                    self.shareViewBtn = shareViewBtn;
                    [shareViewBtn addTarget:self action:@selector(shareViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                    //添加分享菜单view
                    VSAShareView *shareView = [[[NSBundle mainBundle] loadNibNamed:@"VSAShareView" owner:self options:nil] lastObject];
                    shareView.delegate = self;
                    shareView.y = self.view.height - shareView.height;
                    self.shareView = shareView;
                    [window addSubview:shareView];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - VSAShareViewDelegate
- (void)shareViewDidRemove:(VSAShareView *)shareView {
    [shareView removeFromSuperview];
    [self.shareViewBtn removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - others
- (void)shareViewBtnClick {
    [self.shareViewBtn removeFromSuperview];
    [self.shareView removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.transform = CGAffineTransformIdentity;
    }];
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
