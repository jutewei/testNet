//
//  PAErrorCode.h
//  PABase
//
//  Created by Juvid on 16/7/5.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#ifndef PAErrorCode_h
#define PAErrorCode_h

typedef NS_ENUM(NSInteger, PAErrorCode) {
    PAErrorCodeHandled = -2, // 失败，但已经被其他组件处理
    PAErrorCodeUnknown = -1, // 未知错误
    PAErrorCodeSucceed = 200, // 成功
    PAErrorCodeCommonBadRequest = 400, // 请求参数有误, 语义有误, 无法被服务端使用,缺少字段, 字段较验失败都返回
    PAErrorCodeCommonUnauthorized = 401, // 如果请求需要用户验证，验证失败时返回
    PAErrorCodeCommonForbidden = 403, // 服务端已经接收请求,但是服务器拒绝处理该请求,没有权限访问资源
    PAErrorCodeCommonNotFound = 404, // 不想暴露具体原因,或没有其他合适的状态码返回时使用，资源不存在
};

#endif /* PAErrorCode_h */
