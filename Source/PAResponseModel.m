//
//  PAResponseModel.m
//  PABase
//
//  Created by Juvid on 2021/4/21.
//

#import "PAResponseModel.h"
#import "MBProgressHUD+Share.h"

@implementation PAResponseModel

+(id)zlInitFail{
    PAResponseModel *model=[PAResponseModel new];
    model.zl_error=[NSError errorWithDomain:@"无网络连接" code:-999 userInfo:nil];
    model.zl_code=PAErrorCodeUnknown;
    return model;
}
-(void)zlSuccessHint{
    [MBProgressHUD juShowHUDText:self.zl_message];
}

+(id)zlSetCacheDicForModel:(NSDictionary *)dic{
    PAResponseModel *model=[PAResponseModel juToModel:dic];
    model.zl_code=PAErrorCodeSucceed;
    return model;
}
-(void)zlErrorHint:(NSString *)path{
    if (!_zl_error) {///服务器code错误/
        if(_zl_code!= PAErrorCodeCommonUnauthorized){///<
            [MBProgressHUD juShowHUDText:[NSString stringWithFormat:@"%@ code:%ld\n地址:%@",self.zl_message,(long)self.zl_code,path]];
        }
    }else{///< 网络错误
        if (_zl_error.code!=-999) {///< -999请求取消不提示
            [MBProgressHUD juShowHUDText:[NSString stringWithFormat:@"code:%ld %@",(long)_zl_error.code,_zl_error.localizedDescription]];
        }
    }
}

//状态码统一处理（子类实现相关方法）
-(NSInteger)zl_code{
    if (_zl_code==PAErrorCodeSucceed) {
        return 1;
    }else if(_zl_code==PAErrorCodeCommonUnauthorized){
        return 401;
    }
    return _zl_code;
}

@end
