//
//  AppDelegate.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-6.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "AppDelegate.h"
//#import "DCIntrospect.h"
#import "UncaughtExceptionHandler.h"
#import "RavenClient.h"
#import "AppAPIClient.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
//	[[DCIntrospect sharedIntrospector] start];
//    
    [RavenClient clientWithDSN:@"http://aa32bb05ce8a449dbc69d9d339ab1144:c2162354dd9144089351d82f6e583dd1@sentry.airad.com/11"];
    [[RavenClient sharedClient] setupExceptionHandler];
    //推送的形式：标记，声音，提示
    
    //InstallUncaughtExceptionHandler();
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//push
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken {
    
    //注册成功，将deviceToken保存到应用服务器数据库中
    NSString *pTokenStr = [[[NSString stringWithFormat:@"%@", pToken]
                            stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"regisger success:%@",pTokenStr);
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: pTokenStr, @"token", nil];
    
    [[AppAPIClient sharedClient] postPath:@"/api/zhonghan/req_token" parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"Request Token %@",JSON);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // 处理推送消息
    NSLog(@"userinfo:%@",userInfo);
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserProfileSuccess:) name:@"Notification_GetUserProfileSuccess" object:nil];
    
    NSDictionary *postInfo = [NSDictionary dictionaryWithObject:[userInfo objectForKey:@"zhonghan_model"] forKey:@"model"];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"TestNotification" object:nil userInfo:postInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Registfail%@",error);
}

@end
