//
//  JuHTTPClient+method.h
//  PABase
//
//  Created by Juvid on 2021/4/21.
//

#import "PAHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PAHTTPManager (method)
//post新方法带初始化参数parameter
- (NSURLSessionDataTask *)PostPath:(NSString *)path
                            paraBlock:(ReqParametes)paraBlock
                             loadType:(JULoadType)showType
                          sucessBlock:(SuccessRes)sucessResult
                            failBlock:(FailureErr)failResult;

//Get新方法带初始化参数parameter
- (NSURLSessionDataTask *)GetPath:(NSString *)path
                            paraBlock:(ReqParametes)paraBlock
                             loadType:(JULoadType)showType
                          sucessBlock:(SuccessRes)sucessResult
                            failBlock:(FailureErr)failResult;

- (NSURLSessionDataTask *)PutPath:(NSString *)path
                            paraBlock:(ReqParametes)paraBlock
                             loadType:(JULoadType)showType
                          sucessBlock:(SuccessRes)sucessResult
                           failBlock:(FailureErr)failResult;


- (NSURLSessionDataTask *)DeletePath:(NSString *)path
                            paraBlock:(ReqParametes)paraBlock
                             loadType:(JULoadType)showType
                          sucessBlock:(SuccessRes)sucessResult
                           failBlock:(FailureErr)failResult;
@end

NS_ASSUME_NONNULL_END
