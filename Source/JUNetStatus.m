//
//  XYNetStatus.m
//  YunServer
//
//  Created by Juvid on 14/11/21.
//  Copyright (c) 2014年 Juvid(zhutianwei). All rights reserved.
//

#import "JUNetStatus.h"
#import "MBProgressHUD+Share.h"
#import <CoreTelephony/CTCellularData.h>
@implementation JUNetStatus
@synthesize sh_networkStatus=_sh_networkStatus,sh_connectionRequired=_sh_connectionRequired;

+ (instancetype)sharedNet{
    static JUNetStatus *_shareNet = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareNet = [[JUNetStatus alloc] init];
        
    });
    return _shareNet;
}
-(id)init{
    self=[super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        self.internetReachability = [Reachability reachabilityForInternetConnection];
        [self.internetReachability startNotifier];
        [self updateInterfaceWithReachability:self.internetReachability];
    }
    return self;
}
//判断网络状态
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}
- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.internetReachability)
    {
        _sh_networkStatus = [reachability currentReachabilityStatus];
        _sh_connectionRequired = _sh_networkStatus;
//        if (_sh_networkStatus!=NotReachable&&_sh_connectionRequired == NO) {
//            [[NSNotificationCenter defaultCenter]postNotificationName:Notification_NetWorkConnect object:nil];
//        }
        if(_sh_connectionRequired){
//            [[NSNotificationCenter defaultCenter]postNotificationName:Notification_WifiUpLoadImage object:nil];
        }
//        if (_sh_networkStatus==ReachableViaWiFi) {
//
//        }
        NSArray *arrMessage=@[@"网络开小差了",@"当前为移动网络环境",@"当前为WIFI状态"];
        if (_isNoShowMark) {///< 第一次不显示状态
            [MBProgressHUD juShowHUDText:arrMessage[_sh_networkStatus]];
        }
        if (_sh_networkStatus==NotReachable) {
            [self shCheckPermissions];
        }
        _isNoShowMark=YES;
    }
}
- (void)shCheckPermissions{
    //    方法1：(APP启动时就开始监听)
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    // 状态发生变化时调用
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState restrictedState) {
        switch (restrictedState) {
            case kCTCellularDataRestrictedStateUnknown:
                NSLog(@"蜂窝移动网络状态：未知");
                break;
            case kCTCellularDataRestricted:
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alr=[[UIAlertView alloc]initWithTitle:@"网络权限已关闭" message:@"您可以在【设置】中为此应用开启网络访问权限"
                                                              delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil];
                    [alr show];
                });
                NSLog(@"蜂窝移动网络状态：关闭");
                break;
            case kCTCellularDataNotRestricted:
                NSLog(@"蜂窝移动网络状态：开启");
                break;

            default:
                break;
        }
    };
}
@end
