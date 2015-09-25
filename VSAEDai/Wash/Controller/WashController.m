//
//  WashController.m
//  VSAEDai
//
//  Created by alvin on 15/9/17.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "WashController.h"
#import "VSAWashCell.h"
#import "WashOrderController.h"
#import "VSALocation.h"
#import "VSACityListController.h"

#define ImageCount 3
int i = 0;

@interface WashController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
//显示图片轮播的scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation WashController
//
//- (UIScrollView *)scrollView {
//    if (_scrollView == nil) {
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 49, self.view.width, 150)];
//        _scrollView.backgroundColor = [UIColor greenColor];
//        _scrollView.contentSize = CGSizeMake(_scrollView.width * ImageCount, 0);
//        _scrollView.pagingEnabled = YES;
//        _scrollView.bounces = NO;
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.delegate = self;
//        [self.view addSubview:_scrollView];
//    }
//    
//    return _scrollView;
//}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = ImageCount;
        CGSize size = [_pageControl sizeForNumberOfPages:ImageCount];
        _pageControl.centerX = self.scrollView.centerX;
        _pageControl.width = size.width;
        _pageControl.height = size.height;
        _pageControl.x = self.scrollView.centerX - _pageControl.width / 2;
        _pageControl.y = CGRectGetMaxY(self.scrollView.frame) - _pageControl.height;
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
        [self.mainScrollView addSubview:_pageControl];
        self.pageControl = _pageControl;
        [_pageControl addTarget:self action:@selector(pageValueChange) forControlEvents:UIControlEventValueChanged];
    }
    
    return _pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];

    [self setupNavigationBar];
    [self setupMainScrollView];
    [self setupImageScroll];
    [self setupMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化
- (void)setupNavigationBar {
    //中间logo
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"home_logo"];
    [imageView sizeToFit];
    self.navigationItem.titleView = imageView;
    
    //leftBarButtonItem - 城市
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"服务范围" style:UIBarButtonItemStylePlain target:self action:@selector(serviceBtnClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //rightBarButtonItem - 服务范围
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"城市" style:UIBarButtonItemStylePlain target:self action:@selector(locateBtnClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setupMainScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = VSAMainBackgroundColor;
    [self.view addSubview:scrollView];
    self.mainScrollView = scrollView;
}

- (void)setupImageScroll {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, self.view.width, 150);
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.contentSize = CGSizeMake(scrollView.width * ImageCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self.mainScrollView addSubview:scrollView];
    
    for (int i = 0; i < ImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
//        CGRect rect = self.scrollView.bounds;
//        imageView.frame = rect;
        imageView.width = self.scrollView.width;
        imageView.height = self.scrollView.height;
        UIImage *image = [UIImage imageNamed:@"xiaohuangren"];
        imageView.image = image;
        [self.scrollView addSubview:imageView];
        CGRect rectImage = imageView.frame;
        
        imageView.x = self.scrollView.width * i;
    }

//    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
//        imageView.x = imageView.width *idx;
//        imageView.y = 0;
//    }];
    
    self.pageControl.currentPage = 0;
    
    //添加timer
    [self startTimer];
}

- (void)startTimer {
    //    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark - 监听事件
- (void)locateBtnClick {
    //弹出 选择城市view
    VSACityListController *cityListVC = [[VSACityListController alloc] init];
    [self presentViewController:cityListVC animated:YES completion:nil];
}

- (void)serviceBtnClick {
    UIViewController *serviceVC = [[UIViewController alloc] init];
    serviceVC.view.backgroundColor = VSAMainBackgroundColor;
    serviceVC.navigationItem.title = @"服务范围";
    [self.navigationController pushViewController:serviceVC animated:YES];
}

- (void)changePage {
    //改变currentPageNumber
    i++;
    [self.pageControl setCurrentPage:i % ImageCount];
    [self pageValueChange];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //    NSLog(@"%s", __func__);
    //根据scrollView的contentOffsize确定page number
    //    NSLog(@"%f",self.scrollView.contentOffset.x);
    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
}

- (void)pageValueChange {
    //根据当前page值，计算scrollView contentOffSet
    CGFloat x = self.pageControl.currentPage * self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)setupMenu {
    
//    UIScrollView *scrollView = [[UIScrollView alloc] init];
//    [self.view addSubview:scrollView];
//    scrollView.frame = self.view.bounds;
//    scrollView.delegate = self;
//    self.scrollView = scrollView;
    //layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.minimumInteritemSpacing = 1;
    
    CGRect rect = CGRectMake(0, self.scrollView.height, self.view.width, self.view.height - self.scrollView.height - 30);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    
    [self.mainScrollView addSubview:collectionView];
    collectionView.backgroundColor = [UIColor clearColor];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    //注册cell
    [collectionView registerClass:[VSAWashCell class] forCellWithReuseIdentifier:@"washCell"];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        default:
            break;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *id = @"washCell";
    VSAWashCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:id forIndexPath:indexPath];
    cell.title.text = [NSString stringWithFormat:@"Cell %ld",indexPath.row];
    cell.backgroundColor = VSAMainBlueColor;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select -- %@", indexPath);
    WashOrderController *orderVC = [[WashOrderController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
    
    //隐藏tabBar, 通知
    [VSANotificationCenter postNotificationName:VSAMainTabBarHideNotification object:nil];
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return CGSizeMake((self.view.width - 2) / 2, 100);
            break;
        case 1:
            return CGSizeMake((self.view.width - 2*2) / 3, 100);
            break;
        default:
            break;
    }
    return CGSizeMake((self.view.width - 5 * 4) / 2, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 5, 0);
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 2;
//}

@end
