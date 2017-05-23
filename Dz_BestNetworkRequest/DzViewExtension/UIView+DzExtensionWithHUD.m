//
//  UIView+DzExtensionWithHUD.m
//  Dz_BestNetworkRequest
//
//  Created by 李志学 on 17/2/16.
//  Copyright © 2017年 张达. All rights reserved.
//

#import "UIView+DzExtensionWithHUD.h"

@implementation UIView (DzExtensionWithHUD)

#pragma mark --------- setter --------- 
-(void)setX:(CGFloat)x{
    CGRect frame   = self.frame;
    frame.origin.x = x;
    self.frame     = frame;
}
-(void)setY:(CGFloat)y{
    CGRect frame   = self.frame;
    frame.origin.y = y;
    self.frame     = frame;
}
-(void)setWidth:(CGFloat)width{
    CGRect frame     = self.frame;
    frame.size.width = width;
    self.frame       = frame;
}
-(void)setHeight:(CGFloat)height{
    CGRect frame     = self.frame;
    frame.size.height= height;
    self.frame       = frame;
}
-(void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}
-(void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}
-(void)setRightX:(CGFloat)rightX{
    CGRect frame     = self.frame;
    frame.origin.x   = rightX - frame.size.width;
    self.frame       = frame;
}
-(void)setBottomY:(CGFloat)bottomY{
    CGRect frame     = self.frame;
    frame.origin.y   = bottomY - frame.size.height;
    self.frame       = frame;
}

#pragma mark  -------- getter -------- 
-(CGFloat)x{
    return self.frame.origin.x;
}
-(CGFloat)y{
    return  self.frame.origin.y;
}
-(CGFloat)width{
    return  self.frame.size.width;
}
-(CGFloat)height{
    return  self.frame.size.height;
}
-(CGFloat)rightX{
    return self.frame.origin.x+self.frame.size.width;
}
-(CGFloat)bottomY{
    return self.frame.origin.y+self.frame.size.height;
}
-(CGFloat)centerX{
    return self.center.x;
}
-(CGFloat)centerY{
    return self.center.y;
}

#pragma mark -------- 提示框 --------

+(void)showStatusString:(NSString *)message{
    [SVProgressHUD showStatusString:message];
}
+(void)showMessage:(NSString *)message{
    [SVProgressHUD setInfoImage:nil];
    [SVProgressHUD showInfoWithStatus:message];
}
+(void)showStatusString:(NSString *)message duration:(NSTimeInterval)duration{
    [UIView showStatusString:message];
    [SVProgressHUD dismissWithDelay:duration];
}
+(void)showSuccessMessage:(NSString *)successMessage{
    [SVProgressHUD setMinimumDismissTimeInterval:kSuccessDurtion];
    [SVProgressHUD showSuccessWithStatus:successMessage];
}
+(void)showFailMessage:(NSString *)failmessage{
    [SVProgressHUD setMinimumDismissTimeInterval:kFailDurtion];
    [SVProgressHUD showErrorWithStatus:failmessage];
}












@end
