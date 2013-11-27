//
//  HomeViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-8.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "HomeViewController.h"
#import "ODRefreshControl.h"
#import "Home.h"

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
    [self initDataFile];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    
}


- (void) receiveTestNotification:(NSNotification *) notification
{
    
    if ([[notification name] isEqualToString:@"TestNotification"]){
        NSUInteger model = [[notification.userInfo objectForKey:@"model"] integerValue];
        
        if (model == 1) {
            [self.newsBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }else if (model == 2) {
            [self.booksBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }else if (model == 3) {
            [self.schoolBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void) initDataFile
{
    //如果不存在存放tag的文件 创建之
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"HomeData.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filename])
    {
        //不存在plist文件，新建之
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"0" forKey:@"collegeTs"];
        [dic setObject:@"0" forKey:@"emagTs"];
        [dic setObject:@"0" forKey:@"newsTs"];
        [dic writeToFile:filename atomically:YES];
    }
}
-(void) buildUI
{
    self.newsLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_num_bg"]];
    self.booksLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_num_bg"]];
    self.schoolLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_num_bg"]];
    [self.newsLabel setHidden:YES];
    [self.booksLabel setHidden:YES];
    [self.schoolLabel setHidden:YES];
    
    
    [self.cotainerView setContentSize:CGSizeMake(self.cotainerView.frame.size.width , self.cotainerView.frame.size.height + 1)];
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.cotainerView];
    refreshControl.tintColor = [UIColor colorWithRed:150.0/255.0
                                               green:11.0/255.0
                                                blue:15.0/255.0
                                               alpha:1.0];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    if(IOS_VERSION >= 7){
        
        [self.cotainerView setFrame:CGRectMake(0, 47, self.cotainerView.frame.size.width, self.cotainerView.frame.size.height)];
    }
    
    if(IS_IPHONE5){
        
        [self.bgView setFrame:CGRectMake(0, 0, self.bgView.frame.size.width, self.bgView.frame.size.height)];
        
        [self.cotainerView setFrame:CGRectMake(0, 100, self.cotainerView.frame.size.width, self.cotainerView.frame.size.height)];
    }
}





- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    [Home globalHomeWithBlock:^(NSDictionary *home, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            [refreshControl endRefreshing];
            
            NSUInteger college = [[home objectForKey:@"college"] intValue];
            NSUInteger emag = [[home objectForKey:@"emag"] intValue];
            NSUInteger news = [[home objectForKey:@"news"] intValue];
            
            
            if (news>0) {
                [self.newsLabel setHidden:NO];
                [self.newsLabel setText:[NSString stringWithFormat:@"%i",news]];
            }else{
                [self.newsLabel setHidden:YES];
            }
            if (emag>0) {
                [self.booksLabel setHidden:NO];
                [self.booksLabel setText:[NSString stringWithFormat:@"%i",emag]];
            }else{
                [self.booksLabel setHidden:YES];
            }
            if (college>0) {
                [self.schoolLabel setHidden:NO];
                [self.schoolLabel setText:[NSString stringWithFormat:@"%i",college]];
            }else{
                [self.schoolLabel setHidden:YES];
            }
            
        }
        
    }];
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
    [self.newsLabel setHidden:YES];
}
-(IBAction)booksAction:(id)sender
{
    //self.tabBarController.selectedIndex = 2;
    [self.booksLabel setHidden:YES];
}
-(IBAction)schoolAction:(id)sender
{
    //self.tabBarController.selectedIndex = 3;
    [self.schoolLabel setHidden:YES];
}
-(IBAction)aboutAction:(id)sender
{
    //self.tabBarController.selectedIndex = 4;
}

@end
