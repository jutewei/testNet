//
//  JuHTTPClient+UpLoad.h
//  PABase
//
//  Created by Juvid on 2021/4/21.
//

#import "PAHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PAHTTPManager (UpLoad)

- (NSURLSessionDataTask *)newUpLoadPath:(NSString *)path
                              imageData:(NSData *)imageData
                            paraBlock:(void(^)(NSMutableDictionary *parameter))paraBlock
                             loadType:(JULoadType)showType
                          sucessBlock:(SuccessRes)sucessResult
                           failBlock:(FailureErr)failResult;
@end

NS_ASSUME_NONNULL_END
