//
//  News.h
//  zhonghan
//
//  Created by xiangpaopao on 13-10-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (readonly) NSUInteger ID;
@property (readonly) NSString *thumb_pic;
@property (readonly) NSUInteger type;
@property (readonly) NSString *title;
@property (readonly) NSString *publish_time;
@property (readonly) NSString *content_url;
@property (readonly) NSString *ts;
@property (readonly) BOOL haveVideo;
@property  BOOL ifRead;
@property  BOOL ifNew;


- (id)initWithAttributes:(NSDictionary *)attributes;
- (void)setReaded;

+ (void)updateLocalTs:(NSString*)ts;

+ (void)globalNewsWithBlock:(void (^)(NSArray *posts, NSError *error))block page:(NSUInteger)page ts:(NSString*)ts;


@end
