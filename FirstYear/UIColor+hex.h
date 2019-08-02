//
//  UIColor+hex.h
//  HSL
//
//  Created by Majd Taby on 7/4/14.
//  Copyright (c) 2014 Majd Taby. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NSStringize_helper(x) #x
#define NSStringize(x) @NSStringize_helper(x)

#define HSLHEX(x) [UIColor colorWithHEX:NSStringize(x)]

@interface UIColor (colorWithHEX)

+ (UIColor *)colorWithHEX:(NSString *)hexString;
+ (NSString *)hexStringFromColor:(UIColor *)color;
+ (UIColor *)backgroundColor;
+ (UIColor *)toolbarBackgroundColor;
+ (UIColor *)drPinkColor;

@end
