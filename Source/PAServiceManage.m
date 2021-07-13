//
//  PAServiceManage.m
//  PABase
//
//  Created by Juvid on 2021/4/22.
//

#import "PAServiceManage.h"

@implementation PAServiceManage

+ (instancetype)sharedClient{
    static PAServiceManage *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient=[[PAServiceManage alloc] init];
    });
    return sharedClient;
}

/**添加变量**/
- (NSMutableArray *)zl_services {
    if (!_zl_services) {
        _zl_services = [NSMutableArray array];
    }
    return _zl_services;
}

- (void)addTask:(id)zl_services {
    @synchronized (self.zl_services) {
        [self.zl_services addObject:zl_services];
    }
}

- (void)removeTask:(id)fb_Service {
    @synchronized (self.zl_services) {
        [self.zl_services removeObject:fb_Service];
    }
}

- (id)objectService:(NSString *)classClass{
    id serviceOjc=nil;
    for (id object in self.zl_services) {
        if ([NSStringFromClass([object class]) isEqual:classClass]) {
            serviceOjc=object;
            break;
        }
    }
    return serviceOjc;
}

-(void)zlcancelAllOperations{
    [_manager.manager.operationQueue cancelAllOperations];
}

@end
