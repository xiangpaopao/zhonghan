//
//  NewsShowViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "WebShowViewController.h"

@interface WebShowViewController ()

@end

@implementation WebShowViewController

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
     
    for (UIView *view in [[[self.webView subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) view.hidden = YES;
    }
    self.webView.backgroundColor = [UIColor colorWithRed:245.0/255.0
                                                   green:244.0/255.0
                                                    blue:235.0/255.0
                                                   alpha:1.0];
    self.webView.opaque = NO;
    [self.webView setScalesPageToFit:YES];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.hud hide:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.webView.delegate = self;
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"Loading";
    [self.hud hide:NO];
    
    NSURL *url=[NSURL URLWithString:self.webStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:self.webStr ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
@end
