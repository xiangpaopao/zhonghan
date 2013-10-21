//
//  BooksShowViewController.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithBackBtnViewController.h"

@interface BooksShowViewController : WithBackBtnViewController

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UITextView *infoView;
@property (nonatomic, strong) IBOutlet UILabel *ifNewLabel;
@property (nonatomic, strong) IBOutlet UIView *infoBgView;


-(void)configure;
-(IBAction)readAction:(id)sender;


@end
