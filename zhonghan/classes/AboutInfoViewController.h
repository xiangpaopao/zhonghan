//
//  AboutInfoViewController.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithBackBtnViewController.h"

@interface AboutInfoViewController : WithBackBtnViewController

@property(nonatomic, strong)IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString* webStr;

@end
