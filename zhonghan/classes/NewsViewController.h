//
//  NewsViewController.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-8.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REPagedScrollView.h"

@interface NewsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>



@property (nonatomic, strong) IBOutlet UITableView *listView;


@end
