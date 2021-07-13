//
//  CopyModel.m
//  PANetServiceDemo
//
//  Created by 朱天伟(平安租赁事业群(汽融商用车)信息科技部科技三团队) on 2021/6/28.
//

#import "CopyModel.h"

@implementation CopyModel

static CopyModel *sharedManager = nil;

+ (CopyModel*)sharedManager{
    @synchronized(self) {
        if (sharedManager == nil)
        {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedManager;
}

+ (id)allocWithZone:(NSZone *)zone{
    @synchronized(self) {
        if (sharedManager == nil) {
            sharedManager = [super allocWithZone:zone];
        }
    }
    return sharedManager; // assignment and return on first
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

@end
