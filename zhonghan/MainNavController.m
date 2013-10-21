//
//  MainNavController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-8.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "MainNavController.h"

@interface MainNavController ()

@end

@implementation MainNavController

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
    //  UIImageView* navBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    //  [navBg setImage:[UIImage imageNamed:@"tobbar_bg"]];
    //[self.navigationBar setFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    //
    //  [self.navigationBar addSubview:navBg];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"tobbar_bg"]
                            forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
