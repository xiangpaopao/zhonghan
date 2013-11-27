//
//  NewsShowViewController.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithBackBtnViewController.h"
#import "MBProgressHUD.h"

@interface WebShowViewController : WithBackBtnViewController<UIWebViewDelegate>

@property(nonatomic, strong)IBOutlet UIWebView *webView;
@property(nonatomic, strong)NSString *webStr;

@property(nonatomic, strong)MBProgressHUD *hud;

@end
