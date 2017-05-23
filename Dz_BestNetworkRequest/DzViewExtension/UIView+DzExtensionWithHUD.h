//
//  UIView+DzExtensionWithHUD.h
//  Dz_BestNetworkRequest
//
//  Created by 李志学 on 17/2/16.
//  Copyright © 2017年 张达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

#define kSuccessDurtion 1
#define kFailDurtion    3

@interface UIView (DzExtensionWithHUD)
@property(assign,nonatomic)CGFloat x;
@property(assign,nonatomic)CGFloat y;
@property(assign,nonatomic)CGFloat width;
@property(assign,nonatomic)CGFloat height;
@property(assign,nonatomic)CGFloat rightX;
@property(assign,nonatomic)CGFloat bottomY;
@property(assign,nonatomic)CGFloat centerX;
@property(assign,nonatomic)CGFloat centerY;

// 展示进度消息,带菊花
+(void)showStatusString:(NSString * )message;

// 纯提示信息，不带菊花
+(void)showMessage:(NSString *)message;

// 展示进度消息，自定义停留时间
+(void)showStatusString:(NSString * )message duration:(NSTimeInterval)duration;

// 展示成功信息，停留1秒
+(void)showSuccessMessage:(NSString * )successMessage;

// 移除展示图
+(void)dismiss;

// 展示失败信息，停留三秒
+(void)showFailMessage:(NSString * )failmessage;

























@end
