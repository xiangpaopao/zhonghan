//
//  SBTabBarSegue.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-22.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "SBTabBarSegue.h"
#import "MHCustomTabBarController.h"
#import "HomeViewController.h"
#import "TabBarButton.h"


@implementation SBTabBarSegue


- (void) perform {
   
  UIViewController *HomeController = self.sourceViewController;
  MHCustomTabBarController *tabBarViewController = (MHCustomTabBarController *)self.destinationViewController;
  [tabBarViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
  
  if([self.identifier isEqualToString:@"SBSegue1"]){
    [HomeController presentModalViewController:tabBarViewController animated:YES];
    TabBarButton *btn = [tabBarViewController.buttonView.subviews objectAtIndex:1];
    [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
  }else if([self.identifier isEqualToString:@"SBSegue2"]){
    [HomeController presentModalViewController:tabBarViewController animated:YES];
    TabBarButton *btn = [tabBarViewController.buttonView.subviews objectAtIndex:2];
    [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
  }else if([self.identifier isEqualToString:@"SBSegue3"]){
    [HomeController presentModalViewController:tabBarViewController animated:YES];
    TabBarButton *btn = [tabBarViewController.buttonView.subviews objectAtIndex:3];
    [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
  }else if([self.identifier isEqualToString:@"SBSegue4"]){
    [HomeController presentModalViewController:tabBarViewController animated:YES];
    TabBarButton *btn = [tabBarViewController.buttonView.subviews objectAtIndex:4];
    [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
  }else if([self.identifier isEqualToString:@"HomeSegue"]) {
    [HomeController dismissModalViewControllerAnimated:YES];
  }



}





@end
