//
//  UIColor+YZVerify.m
//  YZVerifyCodeController
//
//  Created by 9fbank on 2017/10/17.
//  Copyright © 2017年 yuanzheng. All rights reserved.
//

#import "UIColor+YZVerify.h"

@implementation UIColor (YZVerify)
+ (UIColor *)yz_colorFromString:(NSString *)str{
    if ([[str substringToIndex:1] isEqualToString:@"#"] || [str hasPrefix:@"0X"]){
        return [self yz_colorWithHexString:str];
    }else{
        NSString *colorString = [str lowercaseString];
        
        if ([colorString isEqualToString:@"red"]){
            return [UIColor redColor];
        }else if ([colorString isEqualToString:@"blue"]){
            return [UIColor blueColor];
        }else if ([colorString isEqualToString:@"orange"]){
            return [UIColor orangeColor];
        }else if ([colorString isEqualToString:@"yellow"]){
            return [UIColor yellowColor];
        }else if ([colorString isEqualToString:@"brown"]){
            return [UIColor brownColor];
        }else if ([colorString isEqualToString:@"gray"]){
            return [UIColor grayColor];
        }else if ([colorString isEqualToString:@"green"]){
            return [UIColor greenColor];
        }else if ([colorString isEqualToString:@"purple"]){
            return [UIColor purpleColor];
        }else if ([colorString isEqualToString:@"magenta"]){
            return [UIColor magentaColor];
        }else if ([colorString isEqualToString:@"cyan"]){
            return [UIColor cyanColor];
        }else if ([colorString isEqualToString:@"white"]){
            return [UIColor whiteColor];
        }else if ([colorString isEqualToString:@"black"]){
            return [UIColor blackColor];
        }else if ([colorString isEqualToString:@"clear"]){
            return [UIColor clearColor];
        }
    }
    
    return [UIColor blackColor];
}

+ (UIColor *)yz_colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self yz_colorComponentFrom: colorString start: 0 length: 1];
            green = [self yz_colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self yz_colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self yz_colorComponentFrom: colorString start: 0 length: 1];
            red   = [self yz_colorComponentFrom: colorString start: 1 length: 1];
            green = [self yz_colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self yz_colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self yz_colorComponentFrom: colorString start: 0 length: 2];
            green = [self yz_colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self yz_colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self yz_colorComponentFrom: colorString start: 0 length: 2];
            red   = [self yz_colorComponentFrom: colorString start: 2 length: 2];
            green = [self yz_colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self yz_colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat)yz_colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}
@end
