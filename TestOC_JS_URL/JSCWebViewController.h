//
//  JSCWebViewController.h
//  TestOC_JS_URL
//
//  Created by 赵铭 on 2017/12/14.
//  Copyright © 2017年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol TestJSExport<JSExport>
JSExportAs
(showAlert,
 - (void)showAlertWithParameters:(NSString *)parameterone parametertwo:(NSString *)parametertwo
 );
@end
@interface JSCWebViewController : UIViewController

@end
