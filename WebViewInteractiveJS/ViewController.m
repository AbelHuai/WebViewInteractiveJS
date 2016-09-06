//
//  ViewController.m
//  WebViewInteractiveJS
//
//  Created by Abel on 16/9/6.
//  Copyright © 2016年 杨南. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ViewController ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *activityIndicatorView;
    UIWebView *_webView;
}
@property WebViewJavascriptBridge* bridge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    _webView.backgroundColor = [UIColor redColor];
    _webView.scrollView.backgroundColor = [UIColor redColor];
    //    webView_.scrollView.bounces = NO;
    [self.view addSubview:_webView];
    
    //    NSString* requestUrl = [NSString stringUtils:[self.shareDic objectForKey:@"app_view_url"]];
    NSString* requestUrl = @"https://www.baidu.com";
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    [_webView loadRequest:request];
    
    [WebViewJavascriptBridge enableLogging];

    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"Response for message from ObjC");
    }];
    [_bridge registerHandler:@"Back" handler:^(id data, WVJBResponseCallback responseCallback) {

        responseCallback(@"Response from testObjcCallback");
    }];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    [activityIndicatorView setCenter: CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height)/2)];

    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray] ;
    [self.view addSubview : activityIndicatorView] ;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating] ;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    if (_webView.isLoading) {
//        return NO;
//    }else{
//        return YES;
//    }
//}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicatorView stopAnimating];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
