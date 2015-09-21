//
//  VSAMainTabBar.h
//  VSAEDai
//
//  Created by alvin on 15/9/17.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VSAMainTabBarButtonType) {
    VSAMainTabBarButtonTypeWash,
    VSAMainTabBarButtonTypeOrder,
    VSAMainTabBarButtonTypeMine
};

@class VSAMainTabBar;
@protocol VSAMainTabBarDelegate <NSObject>

@optional
- (void)changeViewControllerFrom:(VSAMainTabBarButtonType)fromType to:(VSAMainTabBarButtonType)toType;

@end

@interface VSAMainTabBar : UIView
@property (nonatomic, weak) id<VSAMainTabBarDelegate> delegate;
@end
