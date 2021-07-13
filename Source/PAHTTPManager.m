//
//  PAHTTPManager.m
//  PABase
//
//  Created by Juvid on 2021/4/21.
//

#import "PAHTTPManager.h"
#import "UIViewController+Hud.h"
#import "JUNetStatus.h"
#import "JuSharedInstance.h"
#import "PAServiceManage.h"

@interface PAHTTPManager ()
@property (nonatomic,copy)NSString *baseUrl;
@end

@implementation PAHTTPManager{
    AFHTTPSessionManager *baseManager;
}
@synthesize manager=_manager;

-(instancetype)init{
    self=[super init];
    if (self) {
        PAServiceManage.sharedClient.manager=self;
    }
    return self;
}

+ (instancetype)sharedClient{
    static PAHTTPManager *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient=[[self alloc] init];
    });
    return sharedClient;
}

+ (void)configUrl:(NSString *)url{
    PAHTTPManager.sharedClient.baseUrl=url;
}


-(nullable NSURL *)baseURLStr{
    return [NSURL URLWithString:self.baseUrl];
}
/**
 请求头处理
 */
-(void)setSetHttpHead:(NSString *)path{}

/**
 相同参数请求包装
 */
- (NSMutableDictionary *)setCommonDic:(NSMutableDictionary *)dic {
   
    NSMutableDictionary *MDic=[NSMutableDictionary dictionary];
    [MDic setValue:@"" forKey:@""];
    return dic;
}

/**
 Debug Log日志
 */
-(void)zlDebugLog:(NSURLSessionDataTask *)task responseData:(id)responseObject parameters:(id)parameters{
#ifdef DEBUG
    if (!responseObject) {
        return ;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    NSString *josn= [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSData *paraData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paraJosn= [[NSString alloc] initWithData:paraData encoding:NSUTF8StringEncoding];
//    LogDebug(@"成功 \n地址%@  \n头部%@ \n参数%@ \n   返回%@",task.currentRequest.URL, self.requestSerializer.HTTPRequestHeaders ,parameters,josn);
    NSLog(@"成功 \n地址：%@  \n参数：%@ \n 返回值：%@",task.currentRequest.URL,paraJosn,josn);
    
#endif

}

//带状态请求
- (NSURLSessionDataTask *)requestPath:(NSString *)path
                           withMethod:(JURequestType)method
                         reqParametes:(ReqParametes)paraBlock
                          loadType:(JULoadType)showType
                       sucessBlock:(SuccessRes)sucessResult
                         failBlock:(FailureErr)failResult{
    UIViewController  *currentTaskVC;
    if (showType==JULoadShow||showType==JULoadShowAndSuc) {
        currentTaskVC=(id)Ju_Share.topViewcontrol;
        [currentTaskVC showHUD:nil];
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (paraBlock)  paraBlock(parameters);
    return [self requestPath:path withMethod:method reqParametes:parameters sucessBlock:^(PAResponseModel *fbResponseM) {
        if (currentTaskVC)[currentTaskVC hideHUD];
        if (showType==JULoadSuccess||showType==JULoadShowAndSuc) {
            [fbResponseM zlSuccessHint];
        }
        sucessResult(fbResponseM);
    } failBlock:^(PAResponseModel *fbResErrorM) {
        if (currentTaskVC) [currentTaskVC hideHUD];
         failResult(fbResErrorM);///< 回调
        if (showType>JULoadNone) {
            [fbResErrorM zlErrorHint:path];
        }
    }];
}

//请求请求
- (NSURLSessionDataTask *)requestPath:(NSString *)path
                           withMethod:(JURequestType)method
                         reqParametes:(id)parameters
                       sucessBlock:(SuccessRes)sucessResult
                         failBlock:(FailureErr)failResult{

    [self setCommonDic:parameters];
    

    if ([JUNetStatus sharedNet].sh_networkStatus==NotReachable) {///< 无网络不请求
        [MBProgressHUD juShowHUDText:@"请检查网络连接"];
        failResult([self.zlResClass zlInitFail]);
        return nil;
    }

    return [self HTTPPath:path withMethod:method parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        PAResponseModel *fbResM=[self.zlResClass juToModel:responseObject];
        [self zlDebugLog:task responseData:responseObject parameters:parameters];///< 打印日志
        switch (fbResM.zl_code) {
            case PAErrorCodeSucceed:{
                sucessResult(fbResM);
            }
                break;
            case PAErrorCodeCommonUnauthorized:{///< token过期，重新刷新 刷新接口出现700表示要重新登录
                if ([self isCanRefresh:30]) {///< 一分钟不刷新 防止token重复刷
                    [self mtRefreshToken:fbResM postPath:path reqParametes:parameters
                             sucessBlock:sucessResult failBlock:failResult];
                }
                else{///< 一分钟内重复刷新token返回失败
                    failResult(fbResM);
                }
            }
                break;
            default:{/// 失败
                if (fbResM.zl_code==PAErrorCodeCommonBadRequest) {
                    NSLog(@"验证失败====>> \n地址：%@  \n参数：%@ \n",task.currentRequest.URL,parameters);
                }
                failResult(fbResM);
            }
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败 \n地址%@  \n原始地址%@\n 参数%@ \n  返回%@",task.currentRequest.URL,task.originalRequest.URL,parameters,error);
        PAResponseModel *resM=[self.zlResClass juInitM];
        resM.zl_error=error;
        failResult(resM);
    }];
}

-(Class)zlResClass{
    return [PAResponseModel class];
}

//post请求
- (NSURLSessionDataTask *)HTTPPath:(NSString *)path
                        withMethod:(JURequestType)method
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                           failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    [self setBaseManage:path];
    [self setSetHttpHead:path];
    if (method==JURequestTypePost) {
        return [_manager POST:path parameters:parameters headers:nil progress:nil  success:success failure:failure];
    }else if(method==JURequestTypePut){
        return [_manager PUT:path parameters:parameters headers:nil success:success failure:failure];
    }else if (method == JURequestTypeDelete){
        return [_manager DELETE:path parameters:parameters headers:nil success:success failure:failure];
    }else{
        return [_manager GET:path parameters:parameters headers:nil progress:nil success:success failure:failure];
    }
}

//子类调用
-(void)mtRefreshToken:(PAResponseModel *)fbResM
             postPath:(NSString *)path
         reqParametes:(NSDictionary *)parameters
          sucessBlock:(SuccessRes)sucessResult
            failBlock:(FailureErr)failResult{}

-(BOOL)isCanRefresh:(NSInteger)maxTime{
    NSTimeInterval spaceTime= [[NSDate date] timeIntervalSinceDate:_zl_tokenDate];
    if (!_zl_tokenDate||spaceTime>maxTime) {///< 一分钟不刷新 防止token重复刷
        _zl_tokenDate=[NSDate date];
        return YES;
    }
    else{///< 一分钟内重复刷新token返回失败
     return  NO;
    }
}

-(void)setBaseManage:(NSString *)path{
    [self zlInitManager];
    
}
-(void)zlInitManager{
    if (!baseManager) {
        baseManager=[[AFHTTPSessionManager alloc]initWithBaseURL:[self baseURLStr]];
        baseManager.requestSerializer= [AFJSONRequestSerializer serializer];
        baseManager.requestSerializer.timeoutInterval = 60;
    }
    _manager=baseManager;
   
}

@end
