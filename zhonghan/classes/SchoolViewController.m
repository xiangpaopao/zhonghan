//
//  SchoolViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "SchoolViewController.h"
#import "REPagedScrollView.h"
#import "SchoolCell.h"
#import "WebShowViewController.h"


@interface SchoolViewController ()

@end

@implementation SchoolViewController

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
  
  //self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
  
  [self initHeaderView];
}

- (void)initHeaderView
{
  REPagedScrollView *headerView = [[REPagedScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
  //  headerView.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
  //  headerView.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
  self.listView.tableHeaderView = headerView;
  
  UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
  test.backgroundColor = [UIColor redColor];
  [headerView addPage:test];
  
  test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
  test.backgroundColor = [UIColor blueColor];
  [headerView addPage:test];
  
  test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
  test.backgroundColor = [UIColor greenColor];
  [headerView addPage:test];
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
  return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 78.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"SchoolCell";
  SchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
    cell = [topLevelObjects objectAtIndex:0];
  }
  
  [cell initWithSchool];
  
  return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  WebShowViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebShowViewController"];
  [self.navigationController pushViewController:showView animated:YES];
}


@end
