//
//  AboutViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutInfoViewController.h"


@interface AboutViewController ()

@property (retain, nonatomic) TGJSBridge *jsBridge;


@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"book_detail_info_bg"]];
    
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    
    [self.webView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-44-48-20)];
    
    self.jsBridge = [TGJSBridge jsBridgeWithDelegate:self];
	self.webView.delegate = self.jsBridge;
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"about" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    for (UIView *view in [[[self.webView subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) view.hidden = YES;
    }
}
- (void)jsBridge:(TGJSBridge *)bridge didReceivedNotificationName:(NSString *)name userInfo:(NSDictionary *)userInfo fromWebView:(UIWebView *)webview
{
    NSString *msgStr = [userInfo objectForKey:@"message"];
    
    AboutInfoViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutInfoViewController"];
    showView.webStr = msgStr;
    [self.navigationController pushViewController:showView animated:YES];
    
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}





@end
