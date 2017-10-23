//
//  ViewController.m
//  YZVerifyCodeController
//
//  Created by 9fbank on 2017/10/17.
//  Copyright © 2017年 yuanzheng. All rights reserved.
//

#import "ViewController.h"
#import "YZVerifyCodeController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YZVerifyCodeController *verifyVC = [[YZVerifyCodeController alloc] initWithTitle:@"转入100元" verifyPhoneNum:@"18818875622" delegate:self codeButtonTitle:@"重新获取" confirmButtonTitle:@"确认转入" timeCode:5];
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"玖富宝可支付金融不足，当前最多可支付XXX元" message:@"400-800-8818" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"hello" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVc addAction:action];
    [self presentViewController:verifyVC animated:NO completion:nil];
    
}



@end
