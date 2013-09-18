//
//  BooksShowViewController.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksShowViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UITextView *infoView;
@property (nonatomic, strong) IBOutlet UILabel *ifNewLabel;

-(void)configure;
-(IBAction)readAction:(id)sender;


@end
