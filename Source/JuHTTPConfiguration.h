//
//  JuHTTPConfiguration.h
//  PABase
//
//  Created by Juvid on 16/7/5.
//  Copyright © 2016年 Juvid(zhutianwei). All rights reserved.
//

#ifndef JuHTTPConfiguration_h
#define JuHTTPConfiguration_h
#import "PAResponseModel.h"

typedef NS_ENUM(NSInteger, JULoadType) {
    JULoadNone,//不显示load
    JULoadHint,// 接口调用失败显示
    JULoadShow,//显示load
    JULoadSuccess,//不显示load成功弹框
    JULoadShowAndSuc,//显示load 并弹框
    JUFailHandle // 最上层处理fail信息
};
typedef NS_ENUM(NSInteger, JURequestType) {
    JURequestTypeGet,//
    JURequestTypePost,//
    JURequestTypePut,//
    JURequestTypeDelete//
};

typedef  void (^__nullable FailureErr) (PAResponseModel *_Nullable zlResErrorM);///< 请求失败
typedef  void (^__nullable Success) (id  _Nullable result);///< 请求成功赋值给control可以是任意值
typedef  void (^__nullable SuccessRes) (PAResponseModel *_Nullable zlResponseM);///< 请求成功数据
typedef  void (^__nullable ReqParametes) (NSMutableDictionary *_Nonnull parametes);///< 网络请求body

//#define HTTPClientSession [PFBHTTPClient sharedClient]

#endif /* JuHTTPConfiguration_h */
