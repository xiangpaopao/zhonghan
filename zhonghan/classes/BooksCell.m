//
//  BooksCell.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "BooksCell.h"
#import "UIImageView+AFNetworking.h"

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

-(void)configureWithBooks:(Books *)books
{
    NSString *titleStr = books.title;
    [self.bookImageView setImageWithURL:[NSURL URLWithString:books.thumb_pic] placeholderImage:[UIImage imageNamed:@"news_thumb_default"]];
     self.bookImageView.clipsToBounds=YES;
    self.bookImageView.contentMode=UIViewContentModeScaleAspectFill;
    
    [self.titleLabel setText:titleStr];
    [self.dateLabel setText:books.publish_time];
    [self.infoLabel setText:books.desc];
    
    CGSize titleSize = [titleStr sizeWithFont:self.titleLabel.font constrainedToSize:self.titleLabel.frame.size];
    [self.ifNewView setFrame:CGRectMake(titleSize.width + self.titleLabel.frame.origin.x +1, 12, 31, 13)];
    
    [self.ifNewView setHidden:books.ifRead];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book_cell_bg"]];
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book_cell_bg_on"]];
    
}

@end
