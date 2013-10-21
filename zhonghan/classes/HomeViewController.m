//
//  HomeViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-8.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "HomeViewController.h"
#import "ODRefreshControl.h"

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
  //[self hideTabBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  //[self showTabBar];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
    [self buildUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void) buildUI
{
    self.msgLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_num_bg"]];
    [self.cotainerView setContentSize:CGSizeMake(self.cotainerView.frame.size.width , self.cotainerView.frame.size.height + 1)];
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.cotainerView];
    refreshControl.tintColor = [UIColor colorWithRed:150.0/255.0
                                               green:11.0/255.0
                                                blue:15.0/255.0
                                               alpha:1.0];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    if(IS_IPHONE5){
        
        [self.bgView setFrame:CGRectMake(0, 0, self.bgView.frame.size.width, self.bgView.frame.size.height)];
        
        [self.cotainerView setFrame:CGRectMake(0, 100, self.cotainerView.frame.size.width, self.cotainerView.frame.size.height)];
    }
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
  double delayInSeconds = 3.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [refreshControl endRefreshing];
  });
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
