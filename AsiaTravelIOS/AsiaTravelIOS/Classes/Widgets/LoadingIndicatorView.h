//
//  LoadingIndicatorView.h
//  WebViewPJ
//
//  Created by wangxinxin on 15/11/25.
//  Copyright © 2015年 wangxinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum LoadResultState{
    
    LoadResultStateSuccess,                //加载成功
    LoadResultStateFailed,                 //加载失败
    
}LoadResultState;

@interface LoadingIndicatorView : UIView

@property (nonatomic, assign) NSString *loadtext;
@property (nonatomic, readonly) BOOL isAnimating;


//use this to init
- (id)initWithFrame:(CGRect)frame;
-(void)setLoadText:(NSString *)text;

- (void)startAnimation;
- (void)stopAnimationWithLoadText:(NSString *)text withState:(LoadResultState)state;
@end
