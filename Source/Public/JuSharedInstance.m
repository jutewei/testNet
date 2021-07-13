//
//  JuSharedInstance.m
//  PABase
//
//  Created by Juvid on 2017/8/23.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import "JuSharedInstance.h"
#import <UserNotifications/UserNotifications.h>

@implementation JuSharedInstance

+ (instancetype) sharedInstance
{
    static JuSharedInstance *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    
    return sharedInstance;
}
-(UITabBarController *)juRootWindowVC{
    UIViewController *tabVc=[UIApplication sharedApplication].delegate.window.rootViewController;
    if ([tabVc isKindOfClass:[UITabBarController class]]) {
        return (UITabBarController *)tabVc;
    }
    return nil;
}


-(void)setUserPhone:(NSString *)phone dbName:(NSInteger)dbName{
    self.ju_userIdentifier=phone;
    self.ju_dbName=[NSString stringWithFormat:@"%ld",(long)dbName];
}
-(NSString *)juUserDBName{
    if (self.ju_userIdentifier.length) {
        return self.ju_userIdentifier;
    }
    return self.ju_dbName;
}


@end
