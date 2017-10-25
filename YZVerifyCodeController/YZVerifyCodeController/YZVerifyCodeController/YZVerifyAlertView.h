//
//  YZVerifyAlertView.h
//  YZVerifyCodeController
//
//  Created by 9fbank on 2017/10/17.
//  Copyright © 2017年 yuanzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZVerifyAlertView : UIView

// title
@property (nonatomic, copy) NSString *title;

// confirmTitle
@property (nonatomic, copy) NSString *confirmTitle;

// verifyPhoneNum
@property (nonatomic, copy) NSString *verifyPhoneNum;

// 倒计时秒数
@property (nonatomic, assign) NSInteger timeCode;

// 验证按钮标题
@property (nonatomic, copy) NSString *codeButtonTitle;

+ (instancetype)alertView;

// 业务处理
@property (nonatomic, strong) void(^closeOperation)(void);

// 收不到验证码
@property (nonatomic, strong) void(^unGetCodeOperation)(void);

// 点击确认
@property (nonatomic, strong) void(^sureOperation)(NSString *);

// 重新获取验证码
@property (nonatomic, strong) void(^getCodeOperation)(void);

// 关闭
- (void)close;

@end
