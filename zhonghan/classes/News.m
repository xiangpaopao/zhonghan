//
//  News.m
//  zhonghan
//
//  Created by xiangpaopao on 13-10-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "News.h"
#import "AppAPIClient.h"

@implementation News
@synthesize ID = _ID;
@synthesize thumb_pic = _thumb_pic;
@synthesize type = _type;
@synthesize title = _title;
@synthesize publish_time = _publish_time;
@synthesize content_url = _content_url;
@synthesize ts = _ts;
@synthesize ifRead = _ifRead;
@synthesize ifNew = _ifNew;
@synthesize haveVideo = _haveVideo;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    _ID = [[attributes valueForKeyPath:@"id"] integerValue];
    _thumb_pic = [attributes valueForKeyPath:@"thumb_pic"];
    _type = [[attributes valueForKeyPath:@"type"] integerValue];
    _title = [attributes valueForKeyPath:@"title"];
    _publish_time = [attributes valueForKeyPath:@"publish_time"];
    _content_url = [attributes valueForKeyPath:@"content_url"];
    _ts = [attributes valueForKeyPath:@"ts"];
    _haveVideo = [[attributes valueForKey:@"haveVedio"] isEqualToString:@"true"]?YES:NO;
    
    //处理服务端返回null的情况
    if ([[NSString stringWithFormat:@"%@",_ts] isEqualToString:@"<null>"]) {
        return nil;
    }
    
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"NewsReadData.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filename])
    {
        //不存在plist文件，新建之
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [arr addObject:@"0"];
        [arr writeToFile:filename atomically:YES];
    }
    NSArray *dataArr = [[NSArray alloc] initWithContentsOfFile:filename];
    
    //是否当天
    NSDate *tsDate = [NSDate dateWithTimeIntervalSince1970:[_ts longLongValue]];
    NSDate *nowDate=[NSDate date];
    if ([self isSameDay:tsDate date2:nowDate]) {
        _ifNew = YES;
    }else{
        _ifNew = NO;
    }
    
    //是否已读
    if ([dataArr containsObject:[NSString stringWithFormat:@"%i",_ID]]) {
        _ifRead = YES;
    }else{
        _ifRead = NO;
    }
    
    //NSLog(@" %i read is %hhd  new is  %hhd ",_ID,_ifRead,_ifNew);
    NSLog(@"dataArr is %@",dataArr);
    
    return self;
}

-(void)setReaded{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"NewsReadData.plist"];
    NSMutableArray *newArr = [[NSMutableArray alloc]initWithContentsOfFile:filename];
    
    if ([newArr containsObject:[NSString stringWithFormat:@"%i",_ID]]==NO) {
        [newArr addObject:[NSString stringWithFormat:@"%i",_ID]];
    }
    
    [newArr writeToFile:filename atomically:YES];
    _ifRead = YES;
    NSLog(@"newArr %@",newArr);
}

- (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

#pragma mark -

+ (void)globalNewsWithBlock:(void (^)(NSArray *posts, NSError *error))block  page:(NSUInteger)page ts:(NSString*)ts{
    NSString *path = [NSString stringWithFormat:@"api/zhonghan/news?page_size=%@&page=%d&ts=%@",kApp_PAGE_SIZE,page,ts];
    [[AppAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"globalNewsWithBlock %@",JSON);
        NSArray *postsFromResponse = [[JSON valueForKeyPath:@"response"] valueForKey:@"news"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary *attributes in postsFromResponse) {
            News *news = [[News alloc] initWithAttributes:attributes];
            
            if (news != nil) {
                [mutablePosts addObject:news];
            }
            
        }
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

+ (void)updateLocalTs:(NSString*)ts{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"HomeData.plist"];
    NSMutableDictionary *homeDic = [NSMutableDictionary dictionaryWithContentsOfFile:filename];
    [homeDic setObject:ts forKey:@"newsTs"];
    [homeDic writeToFile:filename atomically:YES];
    NSLog(@"updateLocalTs %@",homeDic);
}

@end
