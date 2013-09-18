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
  [self setupHomeMenuButton];
}

-(void)setupHomeMenuButton{
  UIImage* image= [UIImage imageNamed:@"back_btn"];
  UIImage* imageOn= [UIImage imageNamed:@"back_btn_on"];
  UIButton* leftButton= [[UIButton alloc] initWithFrame:CGRectMake(0, -1, image.size.width, image.size.height)];
  [leftButton setBackgroundImage:image forState:UIControlStateNormal];
  [leftButton setBackgroundImage:imageOn forState:UIControlStateHighlighted];
  [leftButton addTarget:self action:@selector(HomeButtonPress:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem* leftDrawerButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
  [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

#pragma mark - Button Handlers
-(void)HomeButtonPress:(id)sender{
  [self.navigationController popViewControllerAnimated:YES];
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
