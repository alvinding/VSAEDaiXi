//
//  VSAMainTabBar.m
//  VSAEDai
//
//  Created by alvin on 15/9/17.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "VSAMainTabBar.h"

#define barItemCount 3

@interface VSAMainTabBar ()
@property (nonatomic, strong)UIButton *selectedBtn;
@end

@implementation VSAMainTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加三个button
        [self addBarItemWithImage:@"wash_default_icon" selectedImage:@"wash_press_icon"];
        [self addBarItemWithImage:@"order_default_icon" selectedImage:@"order_press_icon"];
        [self addBarItemWithImage:@"my_default_icon" selectedImage:@"my_press_icon"];
    }
    
    return self;
}

- (void)addBarItemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [self addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.tag = i;
        
        if (i == 0) {
            btn.selected = YES;
            self.selectedBtn = btn;
        }
        
        CGFloat btnX = i * btnW;
        btn.width = btnW;
        btn.height = self.height;
        btn.x = btnX;
        btn.y = 0;
    }
}

#pragma mark - 监听事件
- (void)btnClicked:(UIButton *)btn {
    self.selectedBtn.selected = NO;
    switch (btn.tag) {
        case 0:
            btn.selected = YES;
            break;
        case 1:
            btn.selected = YES;
            break;
        case 2:
            btn.selected = YES;
            break;
        default:
            break;
    }
    
    self.selectedBtn = btn;
}

@end
