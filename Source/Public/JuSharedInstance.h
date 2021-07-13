//
//  JuSharedInstance.h
//  PABase
//
//  Created by Juvid on 2017/8/23.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JuWindow.h"
#define Ju_Share [JuSharedInstance sharedInstance]

@interface JuSharedInstance : NSObject

+ (instancetype) sharedInstance;

@property (nonatomic,strong)    UIViewController *topViewcontrol;
@property (nonatomic,weak)      NSString *ju_userIdentifier;    ///< 用户唯一标识 （手机号）
@property (nonatomic,strong)    NSString *ju_dbName;            ///< 用户数据库标识
@property (nonatomic,copy)      NSDate *ju_finishData;          ///< webview当前链接是否加载结束

//-(void)juShowMsgFailHint;

-(UITabBarController *)juRootWindowVC;

-(void)setUserPhone:(NSString *)phone dbName:(NSInteger)dbName;

-(NSString *)juUserDBName;

-(NSString *)renameUserIMDB;

@end
