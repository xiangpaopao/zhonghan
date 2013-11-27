//
//  NewsCell.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-8.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *thumbView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UIImageView *ifNewView;
@property (nonatomic, strong) IBOutlet UIImageView *haveVideo;


- (void)configureWithNews:(News *)news;
  
  
@end
