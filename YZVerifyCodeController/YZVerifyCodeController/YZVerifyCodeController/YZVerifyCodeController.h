//
//  YZVerifyCodeController.h
//  YZVerifyCodeController
//
//  Created by 9fbank on 2017/10/17.
//  Copyright © 2017年 yuanzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZVerifyCodeController;

@protocol YZVerifyCodeControllerDelegate <NSObject>
@required

/**
 *  点击收不到验证码按钮
 *
 *  @param codeVc 验证码控制器本身
 */
- (void)unGetCodeButton:(YZVerifyCodeController *)codeVc;
/**
 *  点击确定按钮
 *
 *  @param codeVc 验证码控制器本身
 *  @param smsCode 输入的短信验证码
 */
- (void)sureButton:(YZVerifyCodeController *)codeVc smsCode:(NSString *)smsCode;
/**
 *  点击获取验证码
 *
 *  @param codeVc 控制器本身
 */
- (void)getCodeButton:(YZVerifyCodeController *)codeVc;

@end

@interface YZVerifyCodeController : UIViewController
// title
@property (nonatomic, copy) NSString *codeTitle;

// confirmTitle
@property (nonatomic, copy) NSString *confirmTitle;

// verifyPhoneNum
@property (nonatomic, copy) NSString *verifyPhoneNum;

// 倒计时秒数
@property (nonatomic, assign) NSInteger timeCode;

// 验证按钮标题
@property (nonatomic, copy) NSString *codeButtonTitle;

@property (nonatomic, assign) id <YZVerifyCodeControllerDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title verifyPhoneNum:(NSString *)verifyPhoneNum delegate:(id)delegate codeButtonTitle:(NSString *)codeButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle timeCode:(NSInteger)timeCode;

+ (instancetype)verifyCodeControllerWithTitle:(NSString *)title verifyPhoneNum:(NSString *)verifyPhoneNum delegate:(id)delegate codeButtonTitle:(NSString *)codeButtonTitle confirmButtonTitle:(NSString *)confirmButtonTitle timeCode:(NSInteger)timeCode;

- (void)dismiss;

@end
