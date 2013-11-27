//
//  BooksShowViewController.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithBackBtnViewController.h"
#import "Books.h"

@interface BooksShowViewController : WithBackBtnViewController

@property (nonatomic, strong) IBOutlet UIImageView *postImageView;
@property (nonatomic, strong) IBOutlet UILabel *postTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *postDateLabel;
@property (nonatomic, strong) IBOutlet UITextView *postInfoView;
@property (nonatomic, strong) IBOutlet UILabel *ifNewLabel;
@property (nonatomic, strong) IBOutlet UIView *infoBgView;

@property (nonatomic, strong) Books *book;

-(IBAction)readAction:(id)sender;


@end
