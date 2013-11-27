//
//  HomeViewController.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-8.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *bgView;
@property (nonatomic, strong) IBOutlet UIScrollView *cotainerView;
@property (nonatomic, strong) IBOutlet UILabel *newsLabel;
@property (nonatomic, strong) IBOutlet UILabel *booksLabel;
@property (nonatomic, strong) IBOutlet UILabel *schoolLabel;

@property (nonatomic, strong) IBOutlet UIButton *newsBtn;
@property (nonatomic, strong) IBOutlet UIButton *booksBtn;
@property (nonatomic, strong) IBOutlet UIButton *schoolBtn;
@property (nonatomic, strong) IBOutlet UIButton *aboutBtn;


-(IBAction)newsAction:(id)sender;
-(IBAction)booksAction:(id)sender;
-(IBAction)schoolAction:(id)sender;
-(IBAction)aboutAction:(id)sender;

@end
