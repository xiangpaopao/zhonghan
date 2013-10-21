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
    headerView.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    headerView.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:233.0/255.0
                                                                           green:75.0/255.0
                                                                            blue:63.0/255.0
                                                                           alpha:1.0];
    
    
    self.listView.tableHeaderView = headerView;
    
//    UIImageView *test = [[UIImageView alloc] init];
//    [test setImage:[UIImage imageNamed:@"news_banner"]];
//    test.contentMode = UIViewContentModeScaleAspectFill;
//    test.clipsToBounds = YES;
//    test.frame = CGRectMake(0, 0, ScreenWidth, 180);
//    [headerView addPage:test];
//    test = [[UIImageView alloc] init];
//    [test setImage:[UIImage imageNamed:@"news_banner"]];
//    test.contentMode = UIViewContentModeScaleAspectFill;
//    test.clipsToBounds = YES;
//    test.frame = CGRectMake(0, 0, ScreenWidth, 180);
//    [headerView addPage:test];
//    test = [[UIImageView alloc] init];
//    [test setImage:[UIImage imageNamed:@"news_banner"]];
//    test.contentMode = UIViewContentModeScaleAspectFill;
//    test.clipsToBounds = YES;
//    test.frame = CGRectMake(0, 0, ScreenWidth, 180);
//    [headerView addPage:test];
    
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
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SchoolCell";
    SchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [cell configure];
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebShowViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebShowViewController"];
    showView.webStr=@"detail";
    showView.title=@"课程内容";
    [self.navigationController pushViewController:showView animated:YES];
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
}


@end
