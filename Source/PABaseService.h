//
//  PAService.h
//  PABase
//
//  Created by Juvid on 2021/4/21.
//  Copyright © 2019 pingan. All rights reserved.
//

#import "JuHTTPConfiguration.h"
NS_ASSUME_NONNULL_BEGIN

@interface PABaseService : NSObject{
    NSURLSessionDataTask *_zl_task;///< 当前网络请求
    NSMutableArray *zl_mArrtasks;///< 存储service task变量
}
@property(nonatomic,strong)NSURLSessionDataTask *zl_task;///< 当前网络请求

@property(nonatomic,copy)Success zl_successBlock;///< 临时变量使用
@property(nonatomic,copy)FailureErr zl_failureBlock;///< 临时变量使用

+ (instancetype)sharedInstance;
/**
 *  @author Juvid, 21-04-21 13:07:48
 *
 *  初始化（需对网络请求做处理的，比如取消本次请求，需声明全局变量不然使用中会被释放）
 *
 *  @return 返回service
 */
+(instancetype)zlServiceInit;
+(instancetype)shareService;
/**
 *  @author Juvid, 21-04-21 18:07:20
 *
 *  初始化、带事物(临时变量,直接调用实例方法变量使用中不会被释放)
 *
 *
 *  @return 自己
 */
+(instancetype)zlTempInit;
/**
 *  @author Juvid, 21-04-21 13:07:04
 *
 *  取消单个网络请求（对象方法调用网络请求可用）
 */
-(void)zlCancleTask;
/**
 *  @author Juvid, 21-04-21 13:07:11
 *
 *  取消当前service所有网络请求
 */
-(void)zlCancleMultipleTask;
/**
 *  @author Juvid, 21-04-21 13:07:19
 *
 *  取消所有service所有网络请求
 */
+(void)zlCancleAllTask;
/**
 *  @author Juvid, 21-04-21 16:08:40
 *
 *  copy block（临时service使用）
 *
 *  @param successBlock 成功
 *  @param failureBlock 失败
 */
-(void) success:(Success)successBlock
        failure:(FailureErr)failureBlock;

-(void)addFbTask:(NSURLSessionDataTask *)fb_task;

@end


NS_ASSUME_NONNULL_END
