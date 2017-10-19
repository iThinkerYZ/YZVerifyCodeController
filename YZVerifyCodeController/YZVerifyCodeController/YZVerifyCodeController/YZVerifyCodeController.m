//
//  YZVerifyCodeController.m
//  YZVerifyCodeController
//
//  Created by 9fbank on 2017/10/17.
//  Copyright © 2017年 yuanzheng. All rights reserved.
//

#import "YZVerifyCodeController.h"
#import "YZVerifyAlertView.h"

@interface YZVerifyCodeController ()
@property (nonatomic, weak) YZVerifyAlertView *alertView;
@end

@implementation YZVerifyCodeController
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self initializeConfig];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YZVerifyAlertView *alertView = [YZVerifyAlertView alertView];
    _alertView = alertView;
    alertView.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
    
    // 关闭弹出界面
    alertView.closeOperation = ^(){
        [self dismissViewControllerAnimated:NO completion:nil];
    };
    
    // 设置属性
    if (_delegate != nil) {
        alertView.title = self.codeTitle;
        alertView.verifyPhoneNum = self.verifyPhoneNum;
        alertView.confirmTitle = self.confirmTitle;
        alertView.timeCode = self.timeCode;
        alertView.codeButtonTitle = self.codeButtonTitle;
        
        // 事件传递
        __weak typeof(self) weakSelf = self;
        alertView.sureOperation = ^(){
            if ([_delegate respondsToSelector:@selector(sureButton:)]) {
                
                [_delegate sureButton:weakSelf];
            }
        };
        
        alertView.getCodeOperation = ^(){
            if ([_delegate respondsToSelector:@selector(getCodeButton:)]) {
                [_delegate getCodeButton:weakSelf];
            }
        };
        
        alertView.unGetCodeOperation = ^(){
            if ([_delegate respondsToSelector:@selector(unGetCodeButton:)]) {
                [_delegate unGetCodeButton:weakSelf];
            }
        };
    }
    
    [self.view addSubview:alertView];
}

- (void)initializeConfig{
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:.8];
}

#pragma mark - 初始化方法
- (instancetype)initWithTitle:(NSString *)title verifyPhoneNum:(NSString *)verifyPhoneNum delegate:(id)delegate codeButtonTitle:(NSString *)codeButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle timeCode:(NSInteger)timeCode
{
    if (self = [super init]) {
        self.codeTitle = title;
        self.verifyPhoneNum = verifyPhoneNum;
        self.delegate = delegate;
        self.codeButtonTitle = codeButtonTitle;
        self.confirmTitle = confirmButtonTitle;
        self.timeCode = timeCode;
    }
    return self;
}

+ (instancetype)verifyCodeControllerWithTitle:(NSString *)title verifyPhoneNum:(NSString *)verifyPhoneNum delegate:(id)delegate codeButtonTitle:(NSString *)codeButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle timeCode:(NSInteger)timeCode
{
    return [[self alloc] initWithTitle:title verifyPhoneNum:verifyPhoneNum delegate:delegate codeButtonTitle:codeButtonTitle confirmButtonTitle:confirmButtonTitle timeCode:timeCode];
}

- (void)dismiss
{
    [_alertView close];
}

@end
