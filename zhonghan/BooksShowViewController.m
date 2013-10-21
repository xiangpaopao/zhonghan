//
//  BooksShowViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "BooksShowViewController.h"
#import "WebShowViewController.h"

@interface BooksShowViewController ()

@end

@implementation BooksShowViewController

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
  
  self.infoBgView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"book_detail_info_bg"]];
  
  [self configure];
}

-(void)configure
{
  [self.imageView setImage:[UIImage imageNamed:@"book_thumb"]];
  [self.titleLabel setText:@"2013年第二三期"];
  [self.dateLabel setText:@"2013.05.12更新"];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)readAction:(id)sender
{
  WebShowViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebShowViewController"];
    showView.webStr=@"detail";
    showView.title=@"杂志内容";
  [self.navigationController pushViewController:showView animated:YES];
}

@end
