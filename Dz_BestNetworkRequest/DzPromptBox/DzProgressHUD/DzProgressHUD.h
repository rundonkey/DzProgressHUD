//
//  DzProgressHUD.h
//  CFBlurHUD
//
//  Created by 李志学 on 17/2/17.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DzProgressHUD : UIVisualEffectView
/**
 *  显示指示器
 *  如果不希望有文字，message填入nil或者@""
 *
 *  @param message 信息文本
 */
+ (void)show:(NSString *)message;

/**
 *  显示成功指示器
 *  如果不希望有文字，message填入nil或者@""
 *
 *  @param message 信息文本
 */
+ (void)showSuccess:(NSString *)message;
/**
 *  显示成功指示器
 *  如果不希望有文字，message填入nil或者@""
 *  自定义时间自动消失
 *  @param message 信息文本
 *  @param intervalTime 存在时间
 */
+ (void)showSuccess:(NSString *)message intervalTime:(CGFloat)intervalTime;

/**
 *  显示错误指示器
 *  如果不希望有文字，message填入nil或者@""
 *
 *  @param message 信息文本
 */
+ (void)showFaild:(NSString *)message;
/**
 *  显示错误指示器
 *  如果不希望有文字，message填入nil或者@""
 *
 *  @param message 信息文本
 *  @param intervalTime 存在时间
 */
+ (void)showFaild:(NSString *)message intervalTime:(CGFloat)intervalTime;

/**
 * 加载gif图
 */
+ (void)showGifImage;

/**
 *  撤去指示器
 */
+ (void)dismiss;

// 模仿QQ提示框(自动消失)
+(void)showQQPromatBoxForGreenTitle:(NSString * )title;
+(void)showQQPromatBoxForRedTitle  :(NSString * )title;

@end
