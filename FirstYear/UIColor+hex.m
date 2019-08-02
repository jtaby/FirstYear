//
//  UIColor+hex.m
//  HSL
//
//  Created by Majd Taby on 7/4/14.
//  Copyright (c) 2014 Majd Taby. All rights reserved.
//

#import "UIColor+hex.h"

@implementation UIColor (colorWithHEX)

+ (UIColor *)backgroundColor {
    return [UIColor colorWithWhite:0.1 alpha:1.0];
}

+ (UIColor *)toolbarBackgroundColor {
    return [UIColor colorWithHue:210.0/360.0 saturation:8.0/100.0 brightness:14.0/100.0 alpha:1.0];
}

+(UIColor*)colorWithHexValue:(uint)hexValue andAlpha:(float)alpha {
    return [UIColor
            colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
            green:((float)((hexValue & 0xFF00) >> 8))/255.0
            blue:((float)(hexValue & 0xFF))/255.0
            alpha:alpha];
}

+ (UIColor *)colorWithHEX:(NSString *)hexString {
    UIColor *col;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@"0x"];
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue]) {
        col = [self colorWithHexValue:hexValue andAlpha:1.0];
    } else {
        // invalid hex string
        col = [self blackColor];
    }
    return col;
}

+ (UIColor *)drPinkColor {
    return [UIColor colorWithHue:348.0/360.0 saturation:91.0/100.0 brightness:95.0/100.0 alpha:1.0];
}

+ (NSString *)hexStringFromColor:(UIColor *)color {
    if (!color) {
        return @"";
    }
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

@end
