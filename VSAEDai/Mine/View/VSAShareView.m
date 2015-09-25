//
//  VSAShareView.m
//  VSAEDai
//
//  Created by alvin on 15/9/21.
//  Copyright © 2015年 alvin. All rights reserved.
//

#import "VSAShareView.h"

@interface VSAShareView ()

@end

@implementation VSAShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)cancelClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareViewDidRemove:)]) {
        [self.delegate shareViewDidRemove:self];
    }
}
- (IBAction)shareToSession:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareToSession)]) {
        [self.delegate shareToSession];
    }
}
- (IBAction)shareToTimeline:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareToTimeline)]) {
        [self.delegate shareToTimeline];
    }
}


@end
