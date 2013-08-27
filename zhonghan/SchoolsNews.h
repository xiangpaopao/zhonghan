//
//  Schools.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolsNews : NSObject

@property int _id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *ifNew;

- (id)initWithParameters:(int)ID
                   title:(NSString *)newTitle
                    date:(NSString *)newDate
                    type:(NSString *)newType
                    info:(NSString *)newInfo
                   ifNew:(NSString *)newIfNew;


@end
