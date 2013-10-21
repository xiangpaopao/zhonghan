//
//  WithBackBtnViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-9-22.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "WithBackBtnViewController.h"

@interface WithBackBtnViewController ()

@end

@implementation WithBackBtnViewController

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
  [self setupBackButton];
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
}

#pragma mark - Button Handlers
-(void)BackButtonPress:(id)sender{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
