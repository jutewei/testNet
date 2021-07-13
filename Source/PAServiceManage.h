//
//  PAServiceManage.h
//  PABase
//
//  Created by Juvid on 2021/4/22.
//

#import <Foundation/Foundation.h>
#import "PAHTTPManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface PAServiceManage : NSObject

@property (nonatomic, strong) NSMutableArray *zl_services;
@property (nonatomic, weak) PAHTTPManager *manager;

+ (instancetype)sharedClient;

- (NSMutableArray *)zl_services ;

- (id)objectService:(NSString *)classClass;

- (void)addTask:(id)fb_Service ;

- (void)removeTask:(id)fb_Service;

-(void)zlcancelAllOperations;

@end

NS_ASSUME_NONNULL_END
