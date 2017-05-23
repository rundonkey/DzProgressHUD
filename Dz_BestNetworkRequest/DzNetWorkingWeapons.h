//
//  DzNetWorkingWeapons.h
//  Dz_BestNetworkRequest
//
//  Created by 李志学 on 17/2/16.
//  Copyright © 2017年 张达. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIView+DzExtensionWithHUD.h"

typedef void(^requestSuccessfulBlock)(NSDictionary * responseInfo);
typedef void(^requestFailErrorBlock)(NSError  * error);

@interface DzNetWorkingWeapons : NSObject

@property(copy,nonatomic)requestSuccessfulBlock successBlock;
@property(copy,nonatomic)requestFailErrorBlock  failBlock;

// get请求
+(void)getWithUrl:(NSString * )URL parme:(id)parme successful:(void(^)(id responseInfo))successful faildError:(void(^)(NSError * error))faildError;
// get请求自带提示框
+(void)getWithUrl:(NSString *)URL Parme:(NSDictionary *)parme SuccessMessage:( NSString *)SuccessMessage successful:(requestSuccessfulBlock)successful faildError:(requestFailErrorBlock)faildError;

// post请求
+(void)postWithUrl:(NSString *)URL parme:(NSDictionary *)parme successful:(requestSuccessfulBlock)successful faildError:(requestFailErrorBlock)faildError;

// post请求自带提示框
+(void)postWithUrl:(NSString *)URL parme:(NSDictionary *)parme successMessage:(NSString *)successMessage successful:(requestSuccessfulBlock)successful failError:(requestFailErrorBlock)failError;

// 上传头像
+(void)postUploadImageWithUrl:(NSString *)URL parme:(NSDictionary *)parme imageData:(NSData *)imageData isPromptBox:(BOOL)isPromptBox successful:(requestSuccessfulBlock)successful faildError:(requestFailErrorBlock)faildError;

@end
