//
//  VSALocationTool.m
//  VSAEDai
//
//  Created by alvin on 15/9/18.
//  Copyright © 2015年 alvin. All rights reserved.
//

//保存地址的路径
#define VSALocationPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"location.archive"]

#import "VSALocationTool.h"

@implementation VSALocationTool
+ (void)saveLocation:(VSALocation *)loc {
    NSMutableArray *locations = (NSMutableArray *)[self locations];
    if (!locations) {
        locations = [NSMutableArray array];
    }
    [locations addObject:loc];
    [NSKeyedArchiver archiveRootObject:locations toFile:VSALocationPath];
    NSLog(VSALocationPath);
}

//返回保存的地址数组
+ (NSArray *)locations {
    NSArray *locations = [NSKeyedUnarchiver unarchiveObjectWithFile:VSALocationPath];
    return locations;
}
@end
