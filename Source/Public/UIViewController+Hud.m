//
//  UIViewController+JuHud.m
//  PABase
//
//  Created by Juvid on 2017/8/23.
//  Copyright © 2017年 Juvid. All rights reserved.
//

#import "UIViewController+Hud.h"
#import "MBProgressHUD+Share.h"
#import <objc/runtime.h>

@implementation UIViewController (Hud)

static const void *HudCount = &HudCount;
static const char* ProgressHud="nsobject.ProgressHud";

-(NSInteger)hudCount{
    return [objc_getAssociatedObject(self, HudCount) intValue];
}

-(void)setHudCount:(NSInteger)hudCount{
    NSNumber *number = [[NSNumber alloc] initWithInteger:hudCount];
    objc_setAssociatedObject(self, HudCount, number, OBJC_ASSOCIATION_COPY);
}

-(id)ju_progressHud{
    return objc_getAssociatedObject(self, &ProgressHud);
}

-(void)setJu_progressHud:(id)sh_ProgressHud{
    objc_setAssociatedObject(self, &ProgressHud, sh_ProgressHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHUD:(NSString *)info{
    if (!self.ju_progressHud) {
        self.ju_progressHud=[[MBProgressHUD alloc]initWithView:self.view];
        self.ju_progressHud.mode=MBProgressHUDModeIndeterminate;
        self.hudCount=0;

    }
    if (self.hudCount==0) {
        self.ju_progressHud.alpha=0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.ju_progressHud.alpha=1;
        });
    }
    self.hudCount++;
    self.ju_progressHud.labelText = info;
    [self.view addSubview:self.ju_progressHud];

}

-(void)finishHideHUD{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)hideHUD{
    self.hudCount--;
    if(self.hudCount<0){
        self.hudCount=0;
    }
    if (self.hudCount==0) {
        [self.ju_progressHud show:NO];
        [self.ju_progressHud removeFromSuperview];
    }
}

- (void)showWindowHUD:(NSString *)info{
    UIView *view=[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:view];
    hud.mode=MBProgressHUDModeIndeterminate;
    hud.labelText = info;
    [view addSubview:self.ju_progressHud];
    [hud show:YES];
}

- (void)hideWindowHud{
    UIView *view=[UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end
