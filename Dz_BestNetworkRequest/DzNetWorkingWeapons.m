//
//  DzNetWorkingWeapons.m
//  Dz_BestNetworkRequest
//
//  Created by 李志学 on 17/2/16.
//  Copyright © 2017年 张达. All rights reserved.
//
#import "DzNetWorkingWeapons.h"
#import "DzProgressHUD.h"

@implementation DzNetWorkingWeapons

+(void)getWithUrl:(NSString *)URL parme:(id)parme successful:(void (^)(id))successful faildError:(void (^)(NSError *))faildError{
    [DzProgressHUD showGifImage];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 10.0;
    NSString * urlStr = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:urlStr parameters:parme progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successful) {
            [DzProgressHUD showSuccess:@""];
            successful(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [DzProgressHUD showFaild:@"加载失败" intervalTime:2];
            faildError(error);
        }
    }];
}

+(void)postWithUrl:(NSString *)URL parme:(NSDictionary *)parme successful:(requestSuccessfulBlock)successful faildError:(requestFailErrorBlock)faildError
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //第二步，设置头文件
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.0;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];  // @"text/plain"
    NSString * urlStr = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:urlStr parameters:parme progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successful) {
            successful(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faildError) {
            faildError(error);
        }
    }];
}
+(void)postUploadImageWithUrl:(NSString *)URL parme:(NSDictionary *)parme imageData:(NSData *)imageData isPromptBox:(BOOL)isPromptBox successful:(requestSuccessfulBlock)successful faildError:(requestFailErrorBlock)faildError
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 25.0;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
    NSString * url = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:url parameters:parme constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imageData == nil) {
        }else{
            [formData appendPartWithFileData:imageData name:@"iconUrl" fileName:@"iconUrl" mimeType:@"png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successful) {
            successful(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faildError) {
            faildError(error);
        }
    }];
}


+(void)getWithUrl:(NSString *)URL Parme:(NSDictionary *)parme SuccessMessage:(NSString *)SuccessMessage successful:(requestSuccessfulBlock)successful faildError:(requestFailErrorBlock)faildError
{
    
}
+(void)postWithUrl:(NSString *)URL parme:(NSDictionary *)parme successMessage:(NSString *)successMessage successful:(requestSuccessfulBlock)successful failError:(requestFailErrorBlock)failError
{
    
}
































@end
