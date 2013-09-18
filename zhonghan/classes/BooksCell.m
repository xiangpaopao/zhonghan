//
//  BooksCell.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "BooksCell.h"

@implementation BooksCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configure
{
  
  [self.imageView setImage:[UIImage imageNamed:@"book_thumb"]];
  [self.titleLabel setText:@"2013年第二二期"];
  [self.dateLabel setText:@"2013.05.12更新"];
  [self.infoLabel setText:@"2013年第一一期文字介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍"];
  
  self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book_cell_bg"]];
  self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book_cell_bg_on"]];
}

@end
