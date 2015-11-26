//
//  UIBarButtonItem+AT.m
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "UIBarButtonItem+AT.h"

@implementation UIBarButtonItem (AT)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if([icon isEqualToString:@""]){
        [button setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
    
    if([highIcon isEqualToString:@""]){
        [button setBackgroundImage:nil forState:UIControlStateHighlighted];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    }
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.exclusiveTouch = YES;
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}



@end
