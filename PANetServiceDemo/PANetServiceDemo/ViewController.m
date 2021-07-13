//
//  ViewController.m
//  PANetServiceDemo
//
//  Created by 朱天伟(平安租赁事业群(汽融商用车)信息科技部科技三团队) on 2021/6/25.
//

#import "ViewController.h"
#import "CopyModel.h"
#import "subModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CopyModel *model3=[CopyModel sharedManager];
    CopyModel *model=[CopyModel new];
    CopyModel *model2=[[CopyModel alloc]init];
    
//    NSObject *model4=[TestModel sharedmanager];
//    subModel *model5=[subModel sharedInstance];

    // Do any additional setup after loading the view.
}


@end
