//
//  PAResponseModel.h
//  PABase
//
//  Created by Juvid on 2021/4/21.
//

//#import "PABaseModel.h"
#import "PAErrorCode.h"
#import "NSObject+JsonModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol PAResProtocol <NSObject>

@property (nonatomic,copy) NSString *zl_message;///< 提示信息
@property (nonatomic,assign) NSInteger zl_code;///< 状态码
@property (nonatomic,strong) id zl_data;///< 对象
@property (nonatomic,strong) NSArray *zl_list;///< 列表
@property (nonatomic,strong) NSError *zl_error;

@end



@interface PAResponseModel : NSObject<PAResProtocol>

@property (nonatomic,copy) NSString *zl_message;///< 提示信息
@property (nonatomic,assign) NSInteger zl_code;///< 状态码
@property (nonatomic,strong) id zl_data;///< 对象
@property (nonatomic,strong) NSArray *zl_list;///< 列表
@property (nonatomic,strong) NSError *zl_error;

+(id)zlInitFail;
/*
成功提示
*/
-(void)zlSuccessHint;

/**
失败提示

@param path api路径
*/
-(void)zlErrorHint:(NSString *)path;

/*
 *缓存数据转模型
 */
+(id)zlSetCacheDicForModel:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
