//
//  JuHTTPClient+method.m
//  PABase
//
//  Created by Juvid on 2021/4/21.
//

#import "PAHTTPManager+method.h"

@implementation PAHTTPManager (method)
//post新方法带初始化参数parameter
- (NSURLSessionDataTask *)DeletePath:(NSString *)path
                            paraBlock:(ReqParametes)paraBlock
                             loadType:(JULoadType)showType
                          sucessBlock:(SuccessRes)sucessResult
                            failBlock:(FailureErr)failResult{
    return [self requestPath:path withMethod:JURequestTypeDelete reqParametes:paraBlock loadType:showType sucessBlock:sucessResult failBlock:failResult];
}

- (NSURLSessionDataTask *)PutPath:(NSString *)path
                            paraBlock:(ReqParametes)paraBlock
                             loadType:(JULoadType)showType
                          sucessBlock:(SuccessRes)sucessResult
                            failBlock:(FailureErr)failResult{
    return [self requestPath:path withMethod:JURequestTypePut reqParametes:paraBlock loadType:showType sucessBlock:sucessResult failBlock:failResult];
}

- (NSURLSessionDataTask *)PostPath:(NSString *)path
                            paraBlock:(ReqParametes)paraBlock
                             loadType:(JULoadType)showType
                          sucessBlock:(SuccessRes)sucessResult
                            failBlock:(FailureErr)failResult{
    return [self requestPath:path withMethod:JURequestTypePost reqParametes:paraBlock loadType:showType sucessBlock:sucessResult failBlock:failResult];
}

//Get新方法带初始化参数parameter
- (NSURLSessionDataTask *)GetPath:(NSString *)path
                            paraBlock:(ReqParametes)paraBlock
                             loadType:(JULoadType)showType
                          sucessBlock:(SuccessRes)sucessResult
                           failBlock:(FailureErr)failResult{
    return [self requestPath:path withMethod:JURequestTypeGet reqParametes:paraBlock loadType:showType sucessBlock:sucessResult failBlock:failResult];
}


@end
