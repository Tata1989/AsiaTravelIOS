//
//  LoadingIndicatorView.m
//  WebViewPJ
//
//  Created by wangxinxin on 15/11/25.
//  Copyright © 2015年 wangxinxin. All rights reserved.
//

#import "LoadingIndicatorView.h"

@interface LoadingIndicatorView ()
{
        UIImageView *imageView;
        UILabel *_infolabel;
        UIButton *_reloadBtn;
}

@end
@implementation LoadingIndicatorView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _isAnimating = NO;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, frame.size.width,frame.size.height-40)];
        [self addSubview:imageView];
        //设置动画帧
        imageView.animationImages=[NSArray arrayWithObjects: [UIImage imageNamed:@"Load1"],
                                   [UIImage imageNamed:@"Load2"],
                                   [UIImage imageNamed:@"Load3"],
                                   [UIImage imageNamed:@"Load4"],
                                   [UIImage imageNamed:@"Load5"],
                                   [UIImage imageNamed:@"Load6"],
                                   nil ];
        
        
        _infolabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-40, frame.size.width, 20)];
        _infolabel.backgroundColor = [UIColor clearColor];
        _infolabel.textAlignment = NSTextAlignmentCenter;
        _infolabel.textColor = [UIColor colorWithRed:84.0/255 green:86./255 blue:212./255 alpha:1];
        _infolabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:14.0f];
        [self addSubview:_infolabel];
        
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _reloadBtn.frame = CGRectMake(0, frame.size.height-20, frame.size.width+10, 20);
        [_reloadBtn setTitle:@"点击重新加载" forState:UIControlStateNormal];
        _reloadBtn.titleLabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:14.0f];
        _reloadBtn.tintColor = [UIColor colorWithRed:84.0/255 green:86./255 blue:212./255 alpha:1];
        [_reloadBtn addTarget:self action:@selector(reloadAction:) forControlEvents:UIControlEventTouchUpInside];
        _reloadBtn.hidden = YES;
        [self addSubview:_reloadBtn];
 
        self.layer.hidden = YES;
    }
    return self;
}
- (void)reloadAction:(UIButton*)btn{
    btn.hidden = YES;
    [self startAnimation];
    
    if (self.loadResultBlock) {
        self.loadResultBlock(LoadResultStateFailed);
    }
}

- (void)startAnimation
{
    _isAnimating = YES;
    self.layer.hidden = NO;
    [self doAnimation];
}

-(void)doAnimation{
    
    _infolabel.text = _loadtext;
    //设置动画总时间
    imageView.animationDuration=1.0;
    //设置重复次数,0表示不重复
    imageView.animationRepeatCount=0;
    //开始动画
    [imageView startAnimating];
}

- (void)stopAnimationWithLoadText:(NSString *)text withState:(LoadResultState)state
{
    _isAnimating = NO;
    _infolabel.text = text;
    if(state == LoadResultStateSuccess){
        
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [imageView stopAnimating];
            self.layer.hidden = YES;
            self.alpha = 1;
        }];
    }else if(state == LoadResultStateFailed){
        [imageView stopAnimating];
        [imageView setImage:[UIImage imageNamed:@"Load3"]];
        _reloadBtn.hidden = NO;
        
    }

    
}


-(void)setLoadText:(NSString *)text;
{
    if(text){
        _loadtext = text;
    }
}

@end
