//
//  Home.m
//  zhonghan
//
//  Created by xiangpaopao on 13-10-21.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "Home.h"
#import "AppAPIClient.h"

@implementation Home
@synthesize news=_news;
@synthesize emag=_emag;
@synthesize college=_college;


- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    _news = [[attributes valueForKeyPath:@"news"] integerValue];
    _emag = [[attributes valueForKeyPath:@"emag"] integerValue];
    _college = [[attributes valueForKeyPath:@"college"] integerValue];
    
    return self;
}


+ (void)globalHomeWithBlock:(void (^)(NSDictionary *posts, NSError *error))block{
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"HomeData.plist"];

    NSDictionary *homeDic = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSString *newsTs = [homeDic objectForKey:@"newsTs"];
    NSString *emagTs = [homeDic objectForKey:@"emagTs"];
    NSString *collegeTs = [homeDic objectForKey:@"collegeTs"];

    //NSLog(@"homedic %@",homeDic);
    
    NSString *path = [NSString stringWithFormat:@"/api/zhonghan/home?news_ts=%@&emag_ts=%@&college_ts=%@",newsTs,emagTs,collegeTs];
    [[AppAPIClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"globalhomeWithBlock %@",JSON);
        NSDictionary *postsFromResponse = [JSON valueForKeyPath:@"response"];
//        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
//        for (NSDictionary *attributes in postsFromResponse) {
//            Home *home = [[Home alloc] initWithAttributes:attributes];
//            [mutablePosts addObject:home];
//        }
        
        
        if (block) {
            block([NSDictionary dictionaryWithDictionary:postsFromResponse], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block([NSDictionary dictionary], error);
        }
    }];

    
}

@end
