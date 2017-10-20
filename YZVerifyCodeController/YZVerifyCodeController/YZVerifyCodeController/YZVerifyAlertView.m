//
//  YZVerifyAlertView.m
//  YZVerifyCodeController
//
//  Created by 9fbank on 2017/10/17.
//  Copyright © 2017年 yuanzheng. All rights reserved.
//

#import "YZVerifyAlertView.h"
#import "UIColor+YZVerify.h"
#define Verify_ScreenW [UIScreen mainScreen].bounds.size.width
#define Verify_ScreenH [UIScreen mainScreen].bounds.size.height
#define Verify_FontSize [UIFont systemFontOfSize:17]
#define Verify_UnGetCoderFontSize [UIFont systemFontOfSize:14]
#define Verify_AlertFrame CGRectMake(0, 0, 300, 217)
#define Verify_AlertW 300
#define Verify_AlertH 217

@interface YZVerifyAlertView()
@property (nonatomic, weak) UIButton *confirmView; // 底部确认按钮
@property (nonatomic, weak) UIView *separateView; // 分割线
@property (nonatomic, weak) UILabel *titleView; // 顶部标题
@property (nonatomic, weak) UITextField *verifyPhoneNumView; // 验证输入框
@property (nonatomic, weak) UIButton *getCodeView; // 读秒View
@property (nonatomic, assign) NSInteger timeCount;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation YZVerifyAlertView
#pragma mark - 资源文件加载
- (NSBundle *)bundle
{
    return [NSBundle bundleWithPath:[[NSBundle bundleForClass:NSClassFromString(@"YZVerifyCodeController")] pathForResource:@"YZVerifyCodeController" ofType:@"bundle"]];
    
}
- (UIImage *)closeImage
{
    NSString *imageName = [[UIScreen mainScreen] scale] >= 2?@"X@2x":@"X@3x";
    UIImage *image = [[UIImage imageWithContentsOfFile:[[self bundle] pathForResource:imageName ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}
#pragma mark 类方法
+ (instancetype)alertView
{
    return [[self alloc] initWithFrame:Verify_AlertFrame];
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:Verify_AlertFrame]) {
        self.center = CGPointMake(Verify_ScreenW * 0.5, Verify_ScreenH * 0.5);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 12;
        
        // 设置closeView
        [self setupCloseView];
        
        // 添加titleView
        [self setupTitleView];
        
        // 添加短信验证码
        [self setupVerifyView];
        
        // 添加底部确认按钮
        [self setupConfirmView];
        
        // 添加分割线
        [self setupSeparateView];
        
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    // 开启定时器
    [self startTimer];
}

- (void)setupCloseView{
    UIImage *image = [self closeImage];
    UIImageView *closeImage = [[UIImageView alloc] initWithImage:image];
    closeImage.userInteractionEnabled = YES;
    closeImage.frame = CGRectMake(12, 11, 15, 15);
    [self addSubview:closeImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
    [closeImage addGestureRecognizer:tap];
}

// 设置短信验证码View
- (void)setupVerifyView
{
    CGFloat h = self.frame.size.height;
    CGFloat y = 70;
    h = h - y - 49;
    CGFloat x = 16;
    
    UIView *verifyView = [[UIView alloc] initWithFrame:CGRectMake(x, 70, Verify_AlertW, h)];
    [self addSubview:verifyView];
    
    // 输入框
    CGFloat inputW = 195;
    CGFloat inputH = 46;
    UITextField *inputView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, inputW, inputH)];
    inputView.layer.borderWidth = 1;
    inputView.layer.borderColor = [UIColor yz_colorFromString:@"#A8AAB9"].CGColor;
    inputView.layer.cornerRadius = 2.5;
    inputView.keyboardType = UIKeyboardTypeNumberPad;
    inputView.textAlignment = NSTextAlignmentCenter;
    inputView.font = Verify_FontSize;
    inputView.clearButtonMode = UITextFieldViewModeAlways;
    [inputView addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [verifyView addSubview:inputView];
    _verifyPhoneNumView = inputView;
    
    // 读秒按钮
    CGFloat readSecW = Verify_AlertW - CGRectGetMaxX(inputView.frame) - x;
    UIButton *readSecView = [UIButton buttonWithType:UIButtonTypeCustom];
    readSecView.frame = CGRectMake(CGRectGetMaxX(inputView.frame), 0, readSecW, inputH);
    readSecView.titleLabel.font = Verify_FontSize;
    [verifyView addSubview:readSecView];
    [readSecView addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    _getCodeView = readSecView;
    
    // 收不到验证码
    UILabel *unGetCoderView = [[UILabel alloc]  init];
    unGetCoderView.textAlignment = NSTextAlignmentLeft;
    CGFloat unGetCoderViewY = CGRectGetMaxY(_verifyPhoneNumView.frame) + 15;
    unGetCoderView.frame = CGRectMake(0, unGetCoderViewY, Verify_AlertW - x, 18);
    unGetCoderView.text = @"收不到验证码?";
    unGetCoderView.textColor = [UIColor yz_colorFromString:@"#A8AAB9"];
    unGetCoderView.font = Verify_UnGetCoderFontSize;
    [verifyView addSubview:unGetCoderView];
    unGetCoderView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unGetCode)];
    [unGetCoderView addGestureRecognizer:tap];
}

- (void)setupTitleView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, Verify_AlertW, 18)];
    label.font = Verify_FontSize;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _titleView = label;
}

- (void)setupSeparateView
{
    CGFloat y = _confirmView.frame.origin.y;
    y--;
    CGFloat w = Verify_ScreenW - 2 * y;
    UIView *separeteView = [[UIView alloc] initWithFrame:CGRectMake(0, y, w, 0.5)];
    _separateView = separeteView;
    separeteView.backgroundColor = [UIColor yz_colorFromString:@"#EBEBEB"];
    separeteView.alpha = 0.5;
    [self addSubview:separeteView];
}

- (void)setupConfirmView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmView = button;
    CGFloat buttonH = 49;
    button.frame = CGRectMake(0, self.frame.size.height - buttonH, Verify_AlertW, buttonH);
    [button setTitle:self.confirmTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor yz_colorFromString:@"#3A72EF"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor yz_colorFromString:@"#A8AAB9"] forState:UIControlStateDisabled];
    button.titleLabel.font = Verify_FontSize;
    button.contentMode = UIViewContentModeCenter;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.enabled = NO;
    [self addSubview:button];
    [button addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 设置内容
- (void)setTitle:(NSString *)title
{
    if (title) {
        _title = title;
        _titleView.text = title;
    }
}

- (void)setVerifyPhoneNum:(NSString *)verifyPhoneNum
{
    if (verifyPhoneNum) {
        
        _verifyPhoneNum = verifyPhoneNum;
        
        NSString *phone3 = [verifyPhoneNum substringWithRange:NSMakeRange(0, 3)];
        NSString *phone4 = [verifyPhoneNum substringWithRange:NSMakeRange(verifyPhoneNum.length - 4, 4)];
        _verifyPhoneNumView.placeholder = [NSString stringWithFormat:@"已发送至%@****%@",phone3,phone4];
    }
}

- (void)setTimeCode:(NSInteger)timeCode
{
    if (timeCode) {
        
        _timeCode = timeCode;
        
        [_getCodeView setTitle:[NSString stringWithFormat:@"%ld秒",timeCode] forState:UIControlStateNormal];
    }
}

- (void)setConfirmTitle:(NSString *)confirmTitle
{
    if (confirmTitle) {
        _confirmTitle = confirmTitle;
        
        [_confirmView setTitle:confirmTitle forState:UIControlStateNormal];
    }
}


#pragma mark - 业务
- (void)close
{
    [self removeFromSuperview];
    if (_closeOperation) {
        _closeOperation();
    }
}

#pragma mark - 定时器
- (void)startTimer {
    if (_timer.valid) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _timeCount = self.timeCode > 0 ?self.timeCode : 60;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(titleForTime:) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)titleForTime:(NSTimer *)currentTimer {
    
    [_getCodeView setTitle:[NSString stringWithFormat:@"%lds",_timeCount] forState:UIControlStateNormal];
    [_getCodeView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_getCodeView setUserInteractionEnabled:NO];
    
    _timeCount --;
    
    if (_timeCount < 0) {
        [_getCodeView setTitle:self.codeButtonTitle.length > 0?self.codeButtonTitle:@"重新获取" forState:UIControlStateNormal];
        [_getCodeView setTitleColor:[UIColor yz_colorFromString:@"#3A72EF"] forState:UIControlStateNormal];
        [_getCodeView setUserInteractionEnabled:YES];
        [_timer invalidate];
    }
}

#pragma mark - 文件改变
- (void)textChange:(UITextField *)textField{
    _confirmView.enabled = textField.text.length >= 6;
}


#pragma mark - 事件处理
- (void)sure
{
    [self close];
    
    [_timer invalidate];
    
    if (_sureOperation) {
        _sureOperation();
    }
}

- (void)unGetCode
{
    if (_unGetCodeOperation) {
        _unGetCodeOperation();
    }
}

- (void)getCode
{
    [self startTimer];
    
    if (_getCodeOperation) {
        _getCodeOperation();
    }
}

@end
