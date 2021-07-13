//
//  XYNetStatus.h
//  YunServer
//
//  Created by Juvid on 14/11/21.
//  Copyright (c) 2014年 Juvid(zhutianwei). All rights reserved.
//
/**
 *网络状态判断
 */
#import <Foundation/Foundation.h>
#import "Reachability.h"
#define Notification_NetWorkConnect  @"netWorkConnect"//网络连接
@interface JUNetStatus : NSObject{
    NetworkStatus _sh_networkStatus;
    BOOL _sh_connectionRequired;
}
+ (instancetype)sharedNet;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic)  NetworkStatus sh_networkStatus;///<  网络状态
@property  BOOL sh_connectionRequired;///是否有网络
@property (nonatomic) BOOL isNoShowMark;///<是否显示网络提示
@end
