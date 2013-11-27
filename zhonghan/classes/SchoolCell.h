//
//  SchoolCell.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolsNews.h"

@interface SchoolCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *typeLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *infoLabel;
@property (nonatomic, strong) IBOutlet UIImageView *ifNewView;
@property (nonatomic, strong) IBOutlet UIImageView *haveVideo;

- (void)configureWithSchool:(SchoolsNews *)schools;

@end
