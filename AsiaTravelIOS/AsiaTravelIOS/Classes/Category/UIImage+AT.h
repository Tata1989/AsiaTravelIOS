//
//  UIImage+AT.h
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AT)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)resizedImageWithName:(NSString *)name;

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;


@end
