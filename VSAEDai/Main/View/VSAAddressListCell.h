//
//  VSAAddressListCell.h
//  VSAEDai
//
//  Created by alvin on 15/9/18.
//  Copyright © 2015年 alvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSALocation.h"

@interface VSAAddressListCell : UITableViewCell
+ (VSAAddressListCell *)addressListCell;
@property (nonatomic, weak) VSALocation *location;
@end
