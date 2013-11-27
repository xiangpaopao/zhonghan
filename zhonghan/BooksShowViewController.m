//
//  BooksShowViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "BooksShowViewController.h"
#import "WebShowViewController.h"
#import "UIImageView+AFNetworking.h"

@interface BooksShowViewController ()
{
    
    NSString *_webStr;
}
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
  self.title=@"杂志详情";
  self.infoBgView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"book_detail_info_bg"]];
    
    [self configure];
}

-(void)configure
{
    [self.postImageView setImageWithURL:[NSURL URLWithString:self.book.thumb_pic] placeholderImage:[UIImage imageNamed:@"news_thumb_default"]];
    self.postImageView.clipsToBounds=YES;
    self.postImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.postTitleLabel setText:self.book.title];
    [self.postDateLabel setText:self.book.publish_time];
    [self.postInfoView setText:self.book.desc];
    _webStr = self.book.content_url;
    
    
    if(IS_IPHONE5){
        [self.postInfoView setFrame:CGRectMake(self.postInfoView.frame.origin.x,
                                               self.postInfoView.frame.origin.y,
                                               290,
                                               302)];
    }else{
        [self.postInfoView setFrame:CGRectMake(self.postInfoView.frame.origin.x,
                                               self.postInfoView.frame.origin.y,
                                               290,
                                               210)];
    }
    
    [self.infoBgView setFrame:CGRectMake(self.infoBgView.frame.origin.x,
                                         self.infoBgView.frame.origin.y,
                                         self.infoBgView.frame.size.width,
                                         ScreenHeight -44 -50 -146)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)readAction:(id)sender
{
  WebShowViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebShowViewController"];
    showView.webStr=_webStr;
    showView.title=@"杂志";
  [self.navigationController pushViewController:showView animated:YES];
}

@end
