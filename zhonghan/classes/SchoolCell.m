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

-(void)initWithSchool
{
  self.typeLabel.layer.cornerRadius = 5;
  self.typeLabel.layer.masksToBounds = YES;
  self.typeLabel.layer.borderWidth = 1;
  self.typeLabel.layer.borderColor = discussionColor.CGColor;
  
  
}


@end
