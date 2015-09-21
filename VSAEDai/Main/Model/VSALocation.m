//
//  VSALocation.m
//  VSAEDai
//
//  Created by alvin on 15/9/18.
//  Copyright © 2015年 alvin. All rights reserved.
//

#import "VSALocation.h"

@implementation VSALocation
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.location forKey:@"location"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
    }
    
    return self;
}
@end
