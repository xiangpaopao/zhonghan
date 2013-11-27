//
//  AboutViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController (){
    NSString *_aboutUrl;
}

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
    
	self.webView.delegate = self;
    
    _aboutUrl = [NSString stringWithFormat:@"%@preview/zhonghan/about_us",kAFAppDotNetAPIBaseURLString];
    NSURL *url=[NSURL URLWithString:_aboutUrl];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    for (UIView *view in [[[self.webView subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) view.hidden = YES;
    }
    [self setupBackButton];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    NSURL *url = inRequest.URL;
    NSString *urlString = url.absoluteString;
    
    if ([urlString isEqualToString:_aboutUrl]) {
        [self.leftButton setHidden:YES];
    } else {
        [self.leftButton setHidden:NO];
    }
    NSLog(@"url %@", urlString);
    return YES;
}

-(void)setupBackButton{
    UIImage* image= [UIImage imageNamed:@"back_btn"];
    UIImage* imageOn= [UIImage imageNamed:@"back_btn_on"];
    UIButton* leftButton= [[UIButton alloc] initWithFrame:CGRectMake(0, -1, image.size.width, image.size.height)];
    [leftButton setBackgroundImage:image forState:UIControlStateNormal];
    [leftButton setBackgroundImage:imageOn forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(BackButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftDrawerButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    [leftButton setHidden:YES];
    self.leftButton = leftButton;
}

#pragma mark - Button Handlers
-(void)BackButtonPress:(id)sender{
    NSURL *url=[NSURL URLWithString:_aboutUrl];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}


@end
