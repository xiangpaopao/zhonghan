//
//  BooksViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "BooksViewController.h"
#import "BooksCell.h"
#import "Books.h"
#import "BooksShowViewController.h"
#import "MJRefresh.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@interface BooksViewController ()<MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
    
    NSMutableArray *_booksArr;
    NSUInteger _page;
    NSString *_ts;
}


@end

@implementation BooksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"电子杂志";
    //self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _page = 1;
    _ts=@"";
    
    
    // 下拉刷新
    _header = [[MJRefreshHeaderView alloc] init];
    _header.delegate = self;
    _header.scrollView = self.listView;
    // 上拉加载更多
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = self.listView;
    _booksArr = [NSMutableArray arrayWithCapacity:5];
    [self initData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}
-(void)initData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    [Books globalBooksWithBlock:^(NSArray *books, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            [hud hide:YES];
            [_booksArr addObjectsFromArray:books];
            
            Books *booksOne =(Books*)[_booksArr objectAtIndex:0];
            _ts = booksOne.ts;
            [Books updateLocalTs:_ts];
            _page=_page+1;
            [self.listView reloadData];
        }
    } page:1 ts:_ts];
}
#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_header == refreshView) {
        [Books globalBooksWithBlock:^(NSArray *books, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
            } else {
                if([books count]>0){
                    for (int i = 0; i<[books count]; i++) {
                        [_booksArr insertObject:[books objectAtIndex:i] atIndex:0];
                    }
                    Books *booksOne =(Books*)[_booksArr objectAtIndex:0];
                    _ts = booksOne.ts;
                    [Books updateLocalTs:_ts];
                }
                [self.listView reloadData];
            }
        } page:1 ts:_ts];
    } else {
        [Books globalBooksWithBlock:^(NSArray *books, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
            } else {
                if([books count]>0){
                    for (int i = 0; i<[books count]; i++) {
                        [_booksArr addObject:[books objectAtIndex:i]];
                    }
                    Books *booksOne =(Books*)[_booksArr objectAtIndex:0];
                    _ts = booksOne.ts;
                    _page=_page+1;
                }
                [self.listView reloadData];
            }
        } page:_page ts:@""];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    [_header endRefreshing];
    [_footer endRefreshing];
    return [_booksArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BooksCell";
    BooksCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [cell configureWithBooks:[_booksArr objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Books* books = (Books*)[_booksArr objectAtIndex:indexPath.row];
    BooksShowViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"BooksShow"];
    showView.book = books;
    
    //若未读 把id存储下来
    if (!books.ifRead) {
        [books setReaded];
        BooksCell *cell = (BooksCell*)[tableView cellForRowAtIndexPath:indexPath];
        [cell.ifNewView setHidden:YES];
    }
    
    [self.navigationController pushViewController:showView animated:YES];
    
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
}


@end

