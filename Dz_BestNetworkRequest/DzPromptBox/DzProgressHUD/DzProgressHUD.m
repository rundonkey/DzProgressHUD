//
//  DzProgressHUD.m
//  CFBlurHUD
//
//  Created by 李志学 on 17/2/17.
//  Copyright © 2017年 周凌宇. All rights reserved.
//

#import "DzProgressHUD.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface DzProgressHUD ()

@property(strong,nonatomic)UIView      * backGViewForCenter;
@property(copy  ,nonatomic)NSString    * message;
@property(strong,nonatomic)UILabel     * messageLab;
@property(strong,nonatomic)UIImageView * successImg;
@property(strong,nonatomic)UIImageView * faildImg;
@property(weak,nonatomic)UIActivityIndicatorView * aivLoading;
@property(strong,nonatomic)UIImageView * gifImg;

// QQ提示框
@property(assign,nonatomic)BOOL          isQQPromatBox;
@property(strong,nonatomic)UIImageView * promatSuccessImg;
@property(strong,nonatomic)UIImageView * promatFaildImg;
@property(strong,nonatomic)UILabel     * titleLab;
@property(strong,nonatomic)UIView      * backGView;

@end


@implementation DzProgressHUD
-(instancetype)init
{
    if (self = [super initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)]]) {
    }
    return self;
}

-(void)ownSet{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 12.0;
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
}

+(DzProgressHUD * )promatBox{
    __strong static DzProgressHUD * shareManager;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        shareManager = [[DzProgressHUD alloc]init];
    });
    return shareManager;
}

+(DzProgressHUD * )promatBoxForQQ{
    __strong static DzProgressHUD * shareForQQ;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        shareForQQ = [[DzProgressHUD alloc]init];
    });
    return shareForQQ;
}

#pragma mark  --- dz提示框方法 ---

// 菊花转动 ... message为nil或者@“”则只有菊花
+(void)show:(NSString *)message{
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    DzProgressHUD * hud = [self promatBox];
    hud.isQQPromatBox = NO;
    [hud ownSet];
    [window addSubview:hud];
    
    hud.message = message;
    hud.messageLab.text = message;
    
    hud.backGView.hidden  = YES;
    hud.gifImg.hidden     = YES;
    hud.successImg.hidden = YES;
    hud.faildImg.hidden   = YES;
    hud.aivLoading.hidden = NO;
    hud.messageLab.hidden = NO;
    
    [hud layoutSubviews];
    
    hud.transform = CGAffineTransformScale(hud.transform, 0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        hud.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}

+(void)showSuccess:(NSString *)message{
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    DzProgressHUD * hud = [self promatBox];
    hud.isQQPromatBox = NO;
    [hud ownSet];
    [window addSubview:hud];
    
    hud.message = message;
    hud.messageLab.text = hud.message;
    
    hud.backGView.hidden  = YES;
    hud.successImg.hidden = NO;
    hud.faildImg.hidden   = YES;
    hud.aivLoading.hidden = YES;
    hud.messageLab.hidden = NO;
    hud.gifImg.hidden     = YES;
    
    [hud layoutSubviews];
    
    hud.transform = CGAffineTransformScale(hud.transform, 0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        hud.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}

+ (void)showSuccess:(NSString *)message intervalTime:(CGFloat)intervalTime
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    DzProgressHUD * hud = [self promatBox];
    hud.isQQPromatBox = NO;
    [hud ownSet];
    [window addSubview:hud];
    
    hud.message = message;
    hud.messageLab.text = hud.message;
    
    hud.backGView.hidden  = YES;
    hud.successImg.hidden = NO;
    hud.faildImg.hidden   = YES;
    hud.aivLoading.hidden = YES;
    hud.messageLab.hidden = NO;
    hud.gifImg.hidden     = YES;
    
    [hud layoutSubviews];
    
    hud.transform = CGAffineTransformScale(hud.transform, 0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        hud.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
    
    CGFloat time = intervalTime;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [DzProgressHUD  dismiss];
    });
}

+(void)showFaild:(NSString *)message{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    DzProgressHUD * hud = [self promatBox];
    hud.isQQPromatBox = NO;
    [hud ownSet];
    [window addSubview:hud];
    
    hud.message = message;
    hud.messageLab.text = hud.message;
    
    hud.backGView.hidden  = YES;
    hud.successImg.hidden = YES;
    hud.faildImg.hidden   = NO;
    hud.aivLoading.hidden = YES;
    hud.messageLab.hidden = NO;
    hud.gifImg.hidden     = YES;
    
    [hud layoutSubviews];
    
    hud.transform = CGAffineTransformScale(hud.transform, 0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        hud.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}

+ (void)showFaild:(NSString *)message intervalTime:(CGFloat)intervalTime
{
    // 添加视图
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    DzProgressHUD * hud = [self promatBox];
    hud.isQQPromatBox = NO;
    [hud ownSet];
    [window addSubview:hud];
    
    // 传递文字数据
    hud.message = message;
    hud.messageLab.text = hud.message;
    
    // 显示和隐藏的模块
    hud.backGView.hidden  = YES;
    hud.successImg.hidden = YES;
    hud.faildImg.hidden   = NO;
    hud.aivLoading.hidden = YES;
    hud.messageLab.hidden = NO;
    hud.gifImg.hidden     = YES;
    
    // 重新布局
    [hud layoutSubviews];
    
    // 动画
    hud.transform = CGAffineTransformScale(hud.transform, 0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        hud.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
    
    // 自动消失
    CGFloat time = intervalTime;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [DzProgressHUD  dismiss];
    });

}

+ (void)showGifImage{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    DzProgressHUD * hud = [self promatBox];
    hud.isQQPromatBox = NO;
    [hud ownSet];
    [window addSubview:hud];
    
    hud.backGView.hidden  = YES;
    hud.successImg.hidden = YES;
    hud.faildImg.hidden   = YES;
    hud.aivLoading.hidden = YES;
    hud.messageLab.hidden = YES;
    hud.gifImg.hidden     = NO;
    
    [hud layoutSubviews];
    
    hud.transform = CGAffineTransformScale(hud.transform, 0.1, 0.1);
    [UIView animateWithDuration:0.3 animations:^{
        hud.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}

+(void)dismiss
{
    DzProgressHUD * hud = [DzProgressHUD promatBox];
    [UIView animateWithDuration:0.3 animations:^{
        hud.transform = CGAffineTransformScale(hud.transform, 0.1, 0.1);
    } completion:^(BOOL finished) {
        [hud removeFromSuperview];
    }];
}

#pragma  mark --- 懒加载 ---

-(UIView *)backGViewForCenter
{
    if (_backGViewForCenter == nil) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _backGViewForCenter = view;
    }
    return _backGViewForCenter;
}

-(UIActivityIndicatorView *)aivLoading
{
    if (_aivLoading == nil) {
        UIActivityIndicatorView *aivLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [aivLoading startAnimating];
        aivLoading.color = [UIColor whiteColor];
        [self addSubview:aivLoading];
        _aivLoading = aivLoading;
    }
    return _aivLoading;
}

-(UILabel *)messageLab
{
    if (_messageLab == nil) {
        UILabel * lab  = [[UILabel alloc]init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = [UIColor whiteColor];
        lab.numberOfLines = 0;
        [self addSubview:lab];
        _messageLab = lab;
    }
    return _messageLab;
}

-(UIImageView *)successImg
{
    if (_successImg == nil) {
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"success"];
        [self addSubview:imgView];
        _successImg = imgView;
    }
    return _successImg;
}

-(UIImageView *)faildImg
{
    if (_faildImg == nil) {
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"faild"];
        [self addSubview:imgView];
        self.faildImg = imgView;
    }
    return _faildImg;
}

-(UIImageView *)gifImg
{
    if (_gifImg == nil) {
        UIImageView* animatedImageView = [[UIImageView alloc] init];
        animatedImageView.animationImages =
        @[[UIImage imageNamed:@"1.tiff"],
          [UIImage imageNamed:@"2.tiff"],
          [UIImage imageNamed:@"3.tiff"],
          [UIImage imageNamed:@"4.tiff"],
          [UIImage imageNamed:@"5.tiff"],
          [UIImage imageNamed:@"6.tiff"],
          [UIImage imageNamed:@"7.tiff"],
          [UIImage imageNamed:@"8.tiff"]];
        animatedImageView.animationDuration = 1.0f;
        animatedImageView.animationRepeatCount = 0;
        [self addSubview: animatedImageView];
        [animatedImageView startAnimating];
        self.gifImg = animatedImageView;
    }
    return _gifImg;
}
#pragma  mark -- 模仿QQ提示框 ---
// QQ提示框
+(void)showQQPromatBoxForGreenTitle:(NSString *)title
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    DzProgressHUD * hud = [DzProgressHUD promatBox];
    [window addSubview:hud];
    
    [hud hidsomeView];
    hud.isQQPromatBox = YES;
    
    hud.titleLab.text = title;
    
    hud.backGView.hidden         = NO;
    hud.promatFaildImg.hidden    = YES;
    hud.promatSuccessImg.hidden  = NO;
    hud.titleLab.hidden          = NO;
    
    [hud layoutSubviews];

    hud.transform = CGAffineTransformMakeTranslation(0, HEIGHT/2 - HEIGHT);
//    hud.transform = CGAffineTransformTranslate(hud.transform, 0, HEIGHT/2 - HEIGHT);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:(UIViewAnimationOptionTransitionFlipFromTop) animations:^{
        hud.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self dismiss];
        });
    }];
    
}

+(void)showQQPromatBoxForRedTitle:(NSString *)title
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    DzProgressHUD * hud = [DzProgressHUD promatBox];
    [window addSubview:hud];
    hud.isQQPromatBox = YES;
    [hud hidsomeView];
    hud.titleLab.text = title;
    
    hud.backGView.hidden         = NO;
    hud.promatFaildImg.hidden    = NO;
    hud.promatSuccessImg.hidden  = YES;
    hud.titleLab.hidden          = NO;
    
    [hud layoutSubviews];
    
    hud.transform = CGAffineTransformMakeTranslation(0, HEIGHT/2 - HEIGHT);
    //    hud.transform = CGAffineTransformTranslate(hud.transform, 0, HEIGHT/2 - HEIGHT);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:(UIViewAnimationOptionTransitionFlipFromTop) animations:^{
        hud.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self dismisPromatBoxForQQ];
        });
    }];
}

+(void)dismisPromatBoxForQQ
{
    DzProgressHUD * hud = [DzProgressHUD promatBox];
    [UIView animateWithDuration:0.3 animations:^{
        hud.transform = CGAffineTransformTranslate(hud.transform, 0.01, 0.01);
    } completion:^(BOOL finished) {
        [hud removeFromSuperview];
    }];
}

-(UIView *)backGView
{
    if (_backGView == nil) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _backGView = view;
    }
    return _backGView;
}

-(UIImageView *)promatSuccessImg
{
    if (_promatSuccessImg == nil) {
        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"successQQ"];
        [self.backGView addSubview:imgView];
        _promatSuccessImg = imgView;
    }
    return _promatSuccessImg;
}

-(UIImageView *)promatFaildImg
{
    if (_promatFaildImg == nil) {
        UIImageView * imageVeiw = [[UIImageView alloc]init];
        imageVeiw.image = [UIImage imageNamed:@"failforQQ"];
        [self.backGView addSubview:imageVeiw];
        _promatFaildImg = imageVeiw;
    }
    return _promatFaildImg;
}

-(UILabel *)titleLab{
    if (_titleLab == nil) {
        UILabel * lab = [[UILabel alloc]init];
        lab = [[UILabel alloc]init];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.textColor = [UIColor blackColor];
        lab.numberOfLines = 0;
        [lab sizeToFit];
        [self.backGView addSubview:lab];
        _titleLab = lab;
    }
    return _titleLab;
}


#pragma  mark --- 最后的布局 ---
-(void)layoutSubviews
{
    if (self.isQQPromatBox) {
        
        [self qqPromptBoxLayout];
    }else{
        [self dzPromptBoxLayout];
    }
}

-(void)dzPromptBoxLayout
{
    DzProgressHUD * hudForQQ = [DzProgressHUD promatBoxForQQ];
    [hudForQQ removeFromSuperview];
    CGFloat promatBoxWH;
    DzProgressHUD * hud = [DzProgressHUD promatBox];
    if (hud.gifImg.hidden == NO) {
        promatBoxWH = 200;
    }else promatBoxWH = 120;
    CGFloat promatBoxX = (WIDTH - promatBoxWH)*0.5;
    CGFloat promatBoxY = (HEIGHT- promatBoxWH)*0.5;
    
    self.frame = CGRectMake(promatBoxX, promatBoxY, promatBoxWH, promatBoxWH);
    self.backGViewForCenter.frame = CGRectMake(promatBoxX, promatBoxY, promatBoxWH, promatBoxWH);
    CGFloat promatBoxW = self.frame.size.width;
    CGFloat promatBoxH = self.frame.size.height;
    CGFloat imgW = 50;
    CGFloat imgX = (promatBoxW - imgW) * 0.5;
    CGFloat imgY = (promatBoxH - imgW) * 0.5;
    self.successImg.frame = CGRectMake(imgX, imgY, imgW, imgW);
    self.faildImg.frame   = CGRectMake(imgX, imgY, imgW, imgW);
    self.aivLoading.frame = CGRectMake(imgX, imgY, imgW, imgW);
    self.gifImg.frame    = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (![@"" isEqualToString:self.message]) {
        UILabel * lab = [[UILabel alloc]init];
        lab.text = self.message;
        [lab sizeToFit];
        CGFloat w = lab.frame.size.width;
        CGFloat h = lab.frame.size.height;
        CGSize  size = CGSizeMake(w, h);
        // 略微调高
        CGFloat imgY = (self.frame.size.height - imgW) * 0.5 - 10;
        CGRect frame = self.aivLoading.frame;
        frame.origin.y= imgY;
        self.aivLoading.frame = frame;
        self.successImg.frame = frame;
        self.faildImg.frame = frame;
        CGFloat messageW = promatBoxW - 12 * 2;
        CGFloat messageH = size.height;
        CGFloat messageX = (promatBoxW - messageW) * 0.5;
        CGFloat messageY = CGRectGetMaxY(self.successImg.frame) + 12;
        self.messageLab.frame = CGRectMake(messageX,messageY, messageW, messageH);
        // 如果高度超过限定的高度50,增加自身高度
        if (size.height > 50) {
            CGRect frame = self.frame;
            frame.size.height = CGRectGetMaxY(self.messageLab.frame) + 12;
            frame.origin.x    = WIDTH - self.frame.size.width * 0.5;
            self.frame = frame;
            self.gifImg.frame = self.frame;
        }
    }
}
-(void)qqPromptBoxLayout
{
    self.layer.cornerRadius = 0;
    CGFloat bgViewH = 64;
    CGFloat bgViewX = 0;
    CGFloat bgViewY = 0;
    CGFloat bgViewW = WIDTH;
    self.frame           = CGRectMake(bgViewX, bgViewY, bgViewW, bgViewH);
    self.backGView.frame = CGRectMake(bgViewX, bgViewY, bgViewW, bgViewH);
    
    CGFloat imgWH   = 26;
    CGFloat imgX    = 10;
    CGFloat imgY    = (bgViewH - imgWH)* 0.5+12;
    self.promatFaildImg.frame = CGRectMake(imgX, imgY, imgWH, imgWH);
    self.promatSuccessImg.frame = CGRectMake(imgX, imgY, imgWH, imgWH);
    
    CGFloat labX    = CGRectGetMaxX(self.promatFaildImg.frame)+10;
    CGFloat labY    = imgY;
    CGFloat labW    = WIDTH - labX - 10;
    CGFloat labH    = imgWH;
    self.titleLab.frame = CGRectMake(labX, labY, labW, labH);
}

-(void)hidsomeView
{
    DzProgressHUD * hud = [DzProgressHUD promatBox];
    hud.gifImg.hidden     = YES;
    hud.successImg.hidden = YES;
    hud.faildImg.hidden   = YES;
    hud.aivLoading.hidden = YES;
    hud.messageLab.hidden = YES;
    
}
@end
