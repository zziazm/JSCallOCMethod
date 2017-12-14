//
//  JSCWebViewController.m
//  TestOC_JS_URL
//
//  Created by 赵铭 on 2017/12/14.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "JSCWebViewController.h"
@interface JSCWebViewController ()<UIWebViewDelegate, TestJSExport>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation JSCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"JSFile.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    [_webView loadRequest:request];
    // Do any additional setup after loading the view.
}
#pragma mark -- UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"showToastWithparams"] = ^() {
        //NSLog(@"当前线程 - %@",[NSThread currentThread]);
        NSArray *params = [JSContext currentArguments];
        for (JSValue *Param in params) {
            NSLog(@"%@", Param); // 打印结果就是JS传递过来的参数
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:[NSString stringWithFormat:@"js调用oc原生代码成功!"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        });
    };
    
    // 用TestJSExport协议来关联关联objective的方法
    context[@"JSObjective"] = self;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

#pragma mark -- TestJSExport协议

- (void)showAlertWithParameters:(NSString *)parameterone parametertwo:(NSString *)parametertwo {
    NSLog(@"当前线程 - %@",[NSThread currentThread]);// 子线程
    //NSLog(@"JS和OC交互 - %@ -- %@",parameterone,parametertwo);
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:[NSString stringWithFormat:@"js调用oc原生代码成功! - JS参数:%@,%@",parameterone,parametertwo] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    });
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
