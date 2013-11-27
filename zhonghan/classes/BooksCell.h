//
//  BooksCell.h
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Books.h"

@interface BooksCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *bookImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *infoLabel;
@property (nonatomic, strong) IBOutlet UIImageView *ifNewView;

- (void)configureWithBooks:(Books *)books;

@end
