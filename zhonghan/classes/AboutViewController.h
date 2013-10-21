//
//  AboutViewController.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGJSBridge.h"


@interface AboutViewController : UIViewController<TGJSBridgeDelegate>

@property (nonatomic, strong)IBOutlet UIWebView *webView;


@end
