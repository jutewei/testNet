//
//  PAHTTPManager.h
//  PABase
//
//  Created by Juvid on 2021/4/21.
//
#import "PAResponseModel.h"
#import "JuHTTPConfiguration.h"
#import "AFHTTPSessionManager.h"
#define JuRequestList @"onlyList"

@interface PAHTTPManager : NSObject{
    NSMutableArray *_zl_services;
    AFHTTPSessionManager *_manager;
}
#define FailureHandle(value)  if(failureBlock) failureBlock(value);
#define SuccessBlock(value)   if(successBlock) successBlock(value);

@property (nonatomic, strong) NSMutableArray *zl_services;

@property (nonatomic, strong) NSDate *zl_tokenDate;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (instancetype)sharedClient;

+ (void)configUrl:(NSString *)url;

//- (NSMutableDictionary *)setCommonDic:(NSMutableDictionary *)dic;

-(void)zlDebugLog:(NSURLSessionDataTask *)task responseData:(id)responseObject parameters:(id)parameters;

-(BOOL)isCanRefresh:(NSInteger)maxTime;

-(void)setSetHttpHead:(NSString *)path;

-(void)setBaseManage:(NSString *)path;
//带状态请求
- (NSURLSessionDataTask *)requestPath:(NSString *)path
                           withMethod:(JURequestType)method
                         reqParametes:(ReqParametes)paraBlock
                          loadType:(JULoadType)showType
                       sucessBlock:(SuccessRes)sucessResult
                         failBlock:(FailureErr)failResult;

//请求请求
- (NSURLSessionDataTask *)requestPath:(NSString *)path
                           withMethod:(JURequestType)method
                         reqParametes:(id)parameters
                       sucessBlock:(SuccessRes)sucessResult
                            failBlock:(FailureErr)failResult;
@end
