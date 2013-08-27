//
//  TabBarButton.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-22.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
  [self setSelected:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
