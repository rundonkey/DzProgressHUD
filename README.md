# DzProgressHUD
DzProgressHUD(iOS提示框Objective-C)

![城市有我奋斗的青春.jpg](http://upload-images.jianshu.io/upload_images/1782677-0c75212cdeee0665.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

>这波怕是要来一波湿得了，今天2017年农历1月22。
恩，今天是我的生日。
还好周六,写了一个提示框分享一下。
本来只是想模仿QQ的提示框动画的，写着写着写了好多。
做iOS的时间说长不长说短也不短，今天这个框架全当生日礼物了，么么哒。
还是老套路看下效果图吧。



![背景图还是要骚.png](http://upload-images.jianshu.io/upload_images/1782677-fb53cce6f36f6d41.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![展示两个，哦啦.png](http://upload-images.jianshu.io/upload_images/1782677-19a2335ac8a284e5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

>先说下思路吧:
一开始我继承个UIView直接开怼，然而我还需要一个模糊背景这就比较蛋疼了。
扒了几下看到一个UIVisualEffectView,所以就用了。
很简单:就是画好控件全部加在 UIVisualEffectView 然后大家都懂提示框加在window。
实现外界可调用的接口:弹出提示框，清除提示框等等一些方法。
贴下代码:

1.懒加载把所有的控件都写好加在self(UIVisualEffectView)上
```
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
// 贴三个实现 ，都是一个套路
```

2.从layoutSubviews布局好每一个控件的位置
```
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
```

3.实现外界可调用的接口:我这里写的类方法，因为是提示框所以存在这么一个情况(网络请求->菊花转动，请求完成或失败后->清除提示框，所以在类中创建了单例可以理解为self来使用)
```
// 所有外界可调用的接口基本都是这么实现的，我利用hidden属性来控制的UI（可能比较low希望童鞋们有好的办法可以教我一下）
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
```
```
#pragma  mark -- 模仿QQ提示框 ---
// 这里是模仿QQ提示框的实现部分（其实都一样）
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
```

>好了，容我附上Demo下载地址:https://pan.baidu.com/s/1kUKrd35
demo中还有一个自己封装的网络请求类，所以有点乱名字也是网络请求的.

```
再bb点没用的:
今天是我的23岁生日，也是如此平常的一天。
早上在公交上走神还做过了站，很难受。迟到了（虽然我的内心是拒绝的）。
但是我带了几瓶奶和一些巧克力分享给同事(我们这个小团队很和谐)，大家都很开心。
but,全公司就我一个单身汪(哇，好气。)。
另:
希望有可以用到我的东西的童鞋升职加薪，早日脱单，BUG滚蛋。
实在过意不去就给评论生日快乐助助兴 哈哈 。
无兄弟不撸码，兄弟们一块加油！ GO GO GO 。
(下一篇可能会更新关于动画文章，谢谢大家)
```
