//
//  Books.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Books : NSObject

@property (readonly) NSUInteger ID;
@property (readonly) NSString *thumb_pic;
@property (readonly) NSString *title;
@property (readonly) NSString *publish_time;
@property (readonly) NSString *desc;
@property (readonly) NSString *content_url;
@property (readonly) NSString *ts;
@property  BOOL ifRead;
@property  BOOL ifNew;



- (id)initWithAttributes:(NSDictionary *)attributes;
- (void)setReaded;

+ (void)updateLocalTs:(NSString*)ts;

+ (void)globalBooksWithBlock:(void (^)(NSArray *posts, NSError *error))block page:(NSUInteger)page ts:(NSString*)ts;


@end
