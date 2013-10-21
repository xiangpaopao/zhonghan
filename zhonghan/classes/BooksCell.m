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
    NSString *titleStr = @"2013年第二年";
    [self.imageView setImage:[UIImage imageNamed:@"book_thumb"]];
    [self.titleLabel setText:titleStr];
    [self.dateLabel setText:@"2013.05.12更新"];
    [self.infoLabel setText:@"2013年第一一期文字介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍介绍"];
    
    CGSize titleSize = [titleStr sizeWithFont:self.titleLabel.font constrainedToSize:self.titleLabel.frame.size];
    [self.ifNewView setFrame:CGRectMake(titleSize.width + self.titleLabel.frame.origin.x +1, 12, 31, 13)];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book_cell_bg"]];
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book_cell_bg_on"]];
}

@end
