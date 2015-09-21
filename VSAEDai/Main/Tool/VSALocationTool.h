//
//  VSALocationTool.h
//  VSAEDai
//
//  Created by alvin on 15/9/18.
//  Copyright © 2015年 alvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSALocation.h"

@interface VSALocationTool : NSObject

+ (void)saveLocation:(VSALocation *)loc;
+ (NSArray *)locations;
@end
