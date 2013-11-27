//
//  NewsCell.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-8.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+AFNetworking.h"

@implementation NewsCell

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

- (void)configureWithNews:(News *)news{
    self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:234.0/255.0 alpha:1.0];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:232.0/255.0 blue:223.0/255.0 alpha:1.0];
    
    [self.titleLabel setText:news.title];
    [self.dateLabel setText:news.publish_time];
    
    
    //当天的且未读 则显示new
    if ((news.ifNew==YES) && (news.ifRead==NO)) {
        [self.ifNewView setHidden:NO];
    }else{
        [self.ifNewView setHidden:YES];
    }
    NSLog(@"cell %i readed is %i",news.ID,news.ifRead);
    
    //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:news.thumb_pic]]];
    //[self.thumbView setImage:image];
    
    [self.thumbView setImageWithURL:[NSURL URLWithString:news.thumb_pic] placeholderImage:[UIImage imageNamed:@"news_thumb_default"]];
    self.thumbView.clipsToBounds=YES;
    //[self.thumbView setFrame:CGRectMake(0, 0, 44, 44)];
    self.thumbView.contentMode=UIViewContentModeScaleAspectFill;

    if (!news.haveVideo) {
        [self.haveVideo setHidden:YES];
    }else{
        [self.haveVideo setHidden:NO];
    }
}

@end
