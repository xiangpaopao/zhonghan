//
//  AppAPIClient.m
//  zhonghan
//
//  Created by xiangpaopao on 13-10-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//




#import "AppAPIClient.h"

#import "AFJSONRequestOperation.h"

static NSString * const kAFAppDotNetAPIBaseURLString = @"http://192.168.1.247:8860/";

@implementation AppAPIClient

+ (AppAPIClient *)sharedClient {
    static AppAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    
    return self;
}

@end
