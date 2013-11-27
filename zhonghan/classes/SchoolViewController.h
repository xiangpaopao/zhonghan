//
//  SchoolViewController.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REPagedScrollView.h"


@interface SchoolViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) IBOutlet UITableView *listView;
@property (nonatomic, strong) REPagedScrollView *headerView;

@end
