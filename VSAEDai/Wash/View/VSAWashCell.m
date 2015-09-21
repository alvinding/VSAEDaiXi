//
//  VSAWashCell.m
//  VSAEDai
//
//  Created by alvin on 15/9/17.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "VSAWashCell.h"

@interface VSAWashCell ()

@end

@implementation VSAWashCell

- (void)awakeFromNib {
    NSLog(@"awake from nib");
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"VSAWashCell" owner:self options:nil] lastObject];
    }
    
    return self;
}

@end
