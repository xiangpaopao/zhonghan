//
//  AboutViewController.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong)IBOutlet UIWebView *webView;
@property (nonatomic, strong)UIButton *leftButton;


@end
