//
//  PAService.m
//  PABase
//
//  Created by Juvid on 2021/4/21.
//  Copyright © 2019 pingan. All rights reserved.
//

#import "PABaseService.h"
#import "PAServiceManage.h"

@interface PABaseService ()
@property(nonatomic,weak) id zl_targer;///<  所有者
@end


@implementation PABaseService
@synthesize zl_task=_zl_task;

+ (instancetype)sharedInstance {
    static PABaseService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc] init];
    });
    return service;
}

/**初始化service*/
+(instancetype)zlServiceInit{
    return [[[self class] alloc]init];
}

+(instancetype)shareService{
    PABaseService *service=[PAServiceManage.sharedClient objectService:NSStringFromClass([self class])];
    if (!service) {
        service=[[[self class] alloc]init];
        [PAServiceManage.sharedClient addTask:service];
    }
    return service;
}

/*
+(instancetype)shareTarget:(id)target{
    PABaseService *service=[PAServiceManage.sharedClient objectService:NSStringFromClass([self class])];
    if (![service.zl_targer isEqual:target]) {
        service=[[self alloc]init];
        service.zl_targer=target;
    }
    return service;
}*/

+(instancetype)zlTempInit{
    PABaseService *service=[[[self class] alloc]init];
    [PAServiceManage.sharedClient addTask:service];
    return service;
}

-(void)setZl_task:(NSURLSessionDataTask *)zl_task{
    [self zlCancleTask];
    _zl_task=zl_task;
}

-(void)addFbTask:(NSURLSessionDataTask *)fb_task{
    _zl_task=fb_task;
    if (!zl_mArrtasks) zl_mArrtasks=[NSMutableArray array];
    [zl_mArrtasks addObject:fb_task];
}

/**取消单个网络请求*/
-(void)zlCancleTask{
    if (_zl_task) {
        [_zl_task cancel];
    }
}

/**取消多个网络请求**/
-(void)zlCancleMultipleTask{
    for (NSURLSessionDataTask *task in zl_mArrtasks) {
        [task cancel];
    }
    if(zl_mArrtasks) [zl_mArrtasks removeObject:_zl_task];
}

/**取消所有网络请求**/
+(void)zlCancleAllTask{
    [PAServiceManage.sharedClient zlcancelAllOperations];
}

-(void)success:(Success)successBlock
       failure:(FailureErr)failureBlock{
    _zl_successBlock=successBlock;
    _zl_failureBlock=failureBlock;
}

+(void)zlRemoveService{
    PABaseService *service=[PAServiceManage.sharedClient objectService:NSStringFromClass([self class])];
    if (service) {
        [PAServiceManage.sharedClient removeTask:service];
    }
}
-(Success)zl_successBlock{
    return ^(id result){
        [PAServiceManage.sharedClient removeTask:self];
        if (self->_zl_successBlock) {
            self->_zl_successBlock(result);
        }
    };
}
-(FailureErr)zl_failureBlock{
    return ^(PAResponseModel *fbResErrorM){
        [PAServiceManage.sharedClient removeTask:self];
        if (self->_zl_failureBlock) {
            self->_zl_failureBlock(fbResErrorM);
        }
    };
}

@end
