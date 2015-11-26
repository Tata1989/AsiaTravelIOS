//
//  ATBaseWebViewVC.m
//  Test
//
//  Created by wangxinxin on 15/11/18.
//  Copyright (c) 2015年 wangxinxin. All rights reserved.
//

#import "ATBaseWebViewVC.h"
#import "LoadingIndicatorView.h"

@interface ATBaseWebViewVC ()<UIWebViewDelegate>

@property (nonatomic, strong)     UIWebView *webView;
@property (nonatomic, strong)     LoadingIndicatorView *indicator;


@end

@implementation ATBaseWebViewVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNavigationBar:self.navigationController];
    if (self.canBack){
          [self setUpNavigationBarLeftBack];
    }
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-kNavBarHeight)];
    if (self.navigationController.navigationBarHidden == YES && [self.navigationItemTitle isEqualToString:@"首页"]) {
        // _webView.frame = CGRectMake(0, -kStatusBarHeight, ScreenWidth, ScreenHeight+kStatusBarHeight);
    }
    DDLog(@"_webView.frame:%@",NSStringFromCGRect(_webView.frame));
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]];
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.opaque = NO;
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
    self.title = self.navigationItemTitle ? self.navigationItemTitle : @"亚洲旅游";
    
    
    _indicator = [[LoadingIndicatorView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height/2-50, 80, 100)];
    [_indicator setLoadText:@"正在加载..."];
    
    __weak typeof(_webView) weakWedview = _webView;
    _indicator.loadResultBlock = ^(LoadResultState state){
        
        if (state == LoadResultStateFailed) {
            [weakWedview reload];
        }
    };
    
    [self.view addSubview:_indicator];
     [_indicator startAnimation];
    


    
    [self.view bringSubviewToFront:_indicator];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

#pragma mark - private methods
- (void)leftbarbuttonAction
{
    if(_webView.canGoBack){
        
        [_webView goBack];
        
    }
    else{
         [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    DDLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    DDLog(@"webViewDidFinishLoad");
    [_indicator stopAnimationWithLoadText:@"加载成功" withState:LoadResultStateSuccess];//加载成功
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    DDLog(@"title      = %@",title);
    self.navigationItem.title = [self getDomTitle:title];
    
    //隐藏preloader
    NSString *hidePreloaderJS = [webView stringByEvaluatingJavaScriptFromString:@"var preloader = document.getElementById('preloader');preloader.style.display = 'none';;"];
    [webView stringByEvaluatingJavaScriptFromString:hidePreloaderJS];

    
    //隐藏头部header
    NSString *hideHeaderJS = [webView stringByEvaluatingJavaScriptFromString:@"var header = document.getElementById('vlm-h-1');header.parentNode.removeChild(header);"];
    [webView stringByEvaluatingJavaScriptFromString:hideHeaderJS];
    

    //隐藏footer
    if([webView.request.URL.absoluteString hasPrefix:kBaseURL]){
        
        NSString *hideFooerJS = [NSString stringWithFormat:@"var footer= document.getElementById('menu');footer.style.display = 'none';"];
        [webView stringByEvaluatingJavaScriptFromString:hideFooerJS];
        
    }
     //首页的搜素框位置修改
    if ([self.navigationItemTitle isEqualToString:@"首页"]) {
        NSString *toperJS = [NSString stringWithFormat:@"var toper = document.getElementsByClassName('toper')[0];toper.style.top = '20px';"];
        [webView stringByEvaluatingJavaScriptFromString:toperJS];
        
    }
    
    DDLog(@"request_URL:%@",webView.request.URL.absoluteString);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是不是tel也就是打电话按钮被点击
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
//        self.webUrl = request.URL.absoluteString;
 
            if ([request.URL.absoluteString hasPrefix:@"tel"])
            {
                
            }else {
                
                ATBaseWebViewVC *webViewVC = [[ATBaseWebViewVC alloc] init];
                webViewVC.webUrl = request.URL.absoluteString;
                webViewVC.canBack = YES;
                DDLog(@"push新的控制器");
                [self.navigationController pushViewController:webViewVC animated:YES];
                
                return NO;
            }

    }
    return YES;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if ([NetworkTool networkStatus] == NO) {
        [MBProgressHUD showMessage:@"当前网络不可用 请检查你的网络设置" time:3];
    }
    else{
         [_indicator stopAnimationWithLoadText:@"加载失败" withState:LoadResultStateFailed];//加载失败
    }
    DDLog(@"error =%@",error);
}
#pragma mark - 页面title字符串处理
- (NSString *)getDomTitle:(NSString*)domTitle{
    if (domTitle) {
        NSArray *array = [domTitle componentsSeparatedByString:@"_"];
        if (array.count > 0) {
            return array[0];
        }
    }
    return nil;
}

@end
