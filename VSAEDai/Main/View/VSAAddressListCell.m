//
//  VSAAddressListCell.m
//  VSAEDai
//
//  Created by alvin on 15/9/18.
//  Copyright © 2015年 alvin. All rights reserved.
//

#import "VSAAddressListCell.h"

@interface VSAAddressListCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *addr;
@end

@implementation VSAAddressListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setLocation:(VSALocation *)location {
    _location = location;
    self.name.text = location.name;
    self.phone.text = location.phone;
    self.addr.text = location.location;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (VSAAddressListCell *)addressListCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"VSAAddressListCell" owner:self options:nil] lastObject];
}

@end
