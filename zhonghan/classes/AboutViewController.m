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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}


-(IBAction)chinaAction:(id)sender
{
  AboutInfoViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutInfoViewController"];
  [self.navigationController pushViewController:showView animated:YES];
}


-(IBAction)internationalAction:(id)sender
{
  AboutInfoViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutInfoViewController"];
  [self.navigationController pushViewController:showView animated:YES];
}

@end
