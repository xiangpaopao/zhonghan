//
//  Schools.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "SchoolsNews.h"

@implementation SchoolsNews

@synthesize _id;
@synthesize title;
@synthesize date;
@synthesize type;
@synthesize info;
@synthesize ifNew;

- (id)initWithParameters:(int)ID
                   title:(NSString *)newTitle
                    date:(NSString *)newDate
                    type:(NSString *)newType
                    info:(NSString *)newInfo
                   ifNew:(NSString *)newIfNew
{
  SchoolsNews *n = [[SchoolsNews alloc] init];
  n._id = ID;
  n.title = newTitle;
  n.date = newDate;
  n.type = newType;
  n.info = newInfo;
  n.ifNew = newIfNew;
  return n;
  
}


@end
