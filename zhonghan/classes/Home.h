//
//  Home.h
//  zhonghan
//
//  Created by xiangpaopao on 13-10-21.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Home : NSObject


@property (readonly) NSUInteger news;
@property (readonly) NSUInteger emag;
@property (readonly) NSUInteger college;


- (id)initWithAttributes:(NSDictionary *)attributes;


+ (void)globalHomeWithBlock:(void (^)(NSDictionary *posts, NSError *error))block;


@end
