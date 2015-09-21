//
//  VSAShareView.h
//  VSAEDai
//
//  Created by alvin on 15/9/21.
//  Copyright © 2015年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VSAShareView;
@protocol VSAShareViewDelegate <NSObject>

@optional
- (void)shareViewDidRemove:(VSAShareView *)shareView;

@end

@interface VSAShareView : UIView
@property (nonatomic, weak) id<VSAShareViewDelegate> delegate;
@end
