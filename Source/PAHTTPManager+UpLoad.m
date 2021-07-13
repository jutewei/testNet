//
//  JuHTTPClient+UpLoad.m
//  PABase
//
//  Created by Juvid on 2021/4/21.
//

#import "PAHTTPManager+UpLoad.h"
#import "UIViewController+Hud.h"
#import "JuSharedInstance.h"

@implementation PAHTTPManager (UpLoad)
- (NSURLSessionDataTask *)newUpLoadPath:(NSString *)path
                              imageData:(NSData *)imageData
                            paraBlock:(void(^)(NSMutableDictionary *parameter))paraBlock
                             loadType:(JULoadType)showType
                          sucessBlock:(SuccessRes)sucessResult
                              failBlock:(FailureErr)failResult{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    UIViewController  *currentTaskVC;
       if (showType==JULoadShow||showType==JULoadShowAndSuc) {
           currentTaskVC=(id)Ju_Share.topViewcontrol;
           [currentTaskVC showHUD:nil];
       }
    
    [self setSetHttpHead:path];
    if (paraBlock)  paraBlock(parameters);
    return  [_manager POST:path parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//          [formData appendPartWithFormData:imageData name:@"file"];
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"test.png" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PAResponseModel *fbResM=[PAResponseModel juToModel:responseObject];
        if (currentTaskVC)[currentTaskVC hideHUD];
        if (fbResM.zl_code==PAErrorCodeSucceed) {
            if (showType==JULoadSuccess||showType==JULoadShowAndSuc) {
                [fbResM zlSuccessHint];
            }
            sucessResult(fbResM);
        }else{
            [fbResM zlErrorHint:path];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (currentTaskVC)[currentTaskVC hideHUD];
        PAResponseModel *resM=[PAResponseModel juInitM];
        resM.zl_error=error;
        if (showType>JULoadNone) {
            [resM zlErrorHint:path];
        }
        failResult(resM);
    }];
}
@end
