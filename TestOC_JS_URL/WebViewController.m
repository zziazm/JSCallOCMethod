//
//  WebViewController.m
//  TestOC_JS_URL
//
//  Created by 赵铭 on 2017/12/13.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"File.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    [_webView loadRequest:request];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark -- UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *scheme = request.URL.scheme;
    NSString *host = request.URL.host;
    NSString *query = request.URL.query;
    if ([scheme isEqualToString:@"test1"]) {
        NSString *methodName = host;
        if (query) {
            methodName = [methodName stringByAppendingString:@":"];
        }
        SEL sel = NSSelectorFromString(methodName);
        NSString *parameter = [[query componentsSeparatedByString:@"="] lastObject];
        [self performSelector:sel withObject:parameter];
        return NO;
    }else if ([scheme isEqualToString:@"test2"]){//JS中的是Test2,在拦截到的url scheme全都被转化为小写。
        NSURL *url = request.URL;
        NSArray *params =[url.query componentsSeparatedByString:@"&"];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (NSString *paramStr in params) {
            NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
            if (dicArray.count > 1) {
                NSString *decodeValue = [dicArray[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [tempDic setObject:decodeValue forKey:dicArray[0]];
            }
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"方式一" message:@"这是OC原生的弹出窗" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"tempDic:%@",tempDic);
        return NO;
    }
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

- (void)showToast {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"JS调用OC代码成功！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)showToastWithParameter:(NSString *)parama {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:[NSString stringWithFormat:@"JS调用OC代码成功 - JS参数：%@",parama] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
