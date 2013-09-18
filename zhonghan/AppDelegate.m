//
//  AppDelegate.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-6.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "AppDelegate.h"
#import <NewRelicAgent/NewRelicAgent.h>
#import "DCIntrospect.h"
#import "RavenClient.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
  
  [NewRelicAgent startWithApplicationToken:@"AA471c45a8fa83b59d8eccc3472ab0161347965f5b"];
  
  [self.window makeKeyAndVisible];
	[[DCIntrospect sharedIntrospector] start];
  
  
  [RavenClient clientWithDSN:@"http://f5328160d7cd47658736678501e3ec25:3ae9f0c370454bcfb881effadcc09356@sentry.airad.com/11"];
  [[RavenClient sharedClient] setupExceptionHandler];

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

@end
