//
//  HomeViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-8.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self hideTabBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [self showTabBar];
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

#pragma mark - tabbar action
- (void)hideTabBar {
  if (self.tabBarController.tabBar.hidden == YES) {
    return;
  }
  UIView *contentView;
  if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ){
    contentView = [self.tabBarController.view.subviews objectAtIndex:1];
  }else{
    contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
  }
}
- (void)showTabBar{
  if (self.tabBarController.tabBar.hidden == NO){
    return;
  }
  UIView *contentView;
  if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]){
    contentView = [self.tabBarController.view.subviews objectAtIndex:1];
  }else{
    contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
  }
}

-(IBAction)newsAction:(id)sender
{
  //self.tabBarController.selectedIndex = 1;
}
-(IBAction)booksAction:(id)sender
{
  //self.tabBarController.selectedIndex = 2;
}
-(IBAction)schoolAction:(id)sender
{
  //self.tabBarController.selectedIndex = 3;
}
-(IBAction)aboutAction:(id)sender
{
  //self.tabBarController.selectedIndex = 4;
}

@end
