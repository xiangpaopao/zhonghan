//
//  AppAPIClient.h
//  zhonghan
//
//  Created by xiangpaopao on 13-10-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPClient.h"

@interface AppAPIClient : AFHTTPClient

+ (AppAPIClient *)sharedClient;

@end
