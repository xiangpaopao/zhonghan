//
//  SchoolCell.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SchoolCell.h"

#define discussionColor [UIColor colorWithRed:235.0/255.0 \
green:117.0/255.0 \
blue:87.0/255.0 \
alpha:1.0]

#define techColor [UIColor colorWithRed:0.0/255.0 \
green:186.0/255.0 \
blue:162.0/255.0 \
alpha:1.0]

#define pastColor [UIColor colorWithRed:159.0/255.0 \
green:165.0/255.0 \
blue:177.0/255.0 \
alpha:1.0]

@implementation SchoolCell

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

-(void)configureWithSchool:(SchoolsNews *)schools
{
    self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:234.0/255.0 alpha:1.0];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:232.0/255.0 blue:223.0/255.0 alpha:1.0];
    
    [self.titleLabel setText:schools.title];
    [self.dateLabel setText:schools.publish_time];
    [self.infoLabel setText:schools.sub_title];
    self.typeLabel.layer.cornerRadius = 6;
    self.typeLabel.layer.masksToBounds = YES;
    self.typeLabel.layer.borderWidth = 2;
    
    if (schools.category==1) {
        self.typeLabel.layer.borderColor = discussionColor.CGColor;
    }else{
        self.typeLabel.layer.borderColor = techColor.CGColor;
    }
    if (schools.ifRead) {
        self.typeLabel.layer.borderColor = pastColor.CGColor;
    }
    
    //当天的且未读 则显示new
    if ((schools.ifNew==YES) && (schools.ifRead==NO)) {
        [self.ifNewView setHidden:NO];
    }else{
        [self.ifNewView setHidden:YES];
    }
    
    if (!schools.haveVideo) {
        [self.haveVideo setHidden:YES];
    }else{
        [self.haveVideo setHidden:NO];
    }
}


@end
