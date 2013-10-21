//
//  NewsViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-8.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "NewsViewController.h"
#import "REPagedScrollView.h"
#import "NewsCell.h"
#import "WebShowViewController.h"
#import "News.h"
#import "MJRefresh.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"

@interface NewsViewController ()<MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
    
    NSMutableArray *_newsArr;
    NSMutableArray *_bannerArr;
    NSUInteger _page;
    NSString *_ts;
}

@end

@implementation NewsViewController

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
    self.title = @"每日播报";
    //self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initHeaderView];
    
    _page = 1;
    _ts=@"";
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    
    // 下拉刷新
    _header = [[MJRefreshHeaderView alloc] init];
    _header.delegate = self;
    _header.scrollView = self.listView;
    
    // 上拉加载更多
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = self.listView;
    
    _newsArr = [NSMutableArray arrayWithCapacity:5];
    _bannerArr = [NSMutableArray arrayWithCapacity:5];
    
    
    
    [News globalNewsWithBlock:^(NSArray *news, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            [hud hide:YES];
            [_newsArr addObjectsFromArray:news];
            
            News *newsOne =(News*)[_newsArr objectAtIndex:0];
            _ts = newsOne.ts;
            _page=_page+1;
            [self.listView reloadData];
            
            //banner图
            for (News *item in _newsArr) {
                if (item.type == 1) {
                    [_bannerArr insertObject:item atIndex:0];
                    //NSLog(@"item.type %@",_bannerArr);
                }
                
            };
            [self loadHeaderView];
        }
        
    } page:1 ts:@""];
    
    
}


#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_header == refreshView) {
        [News globalNewsWithBlock:^(NSArray *news, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
            } else {
                if([news count]>0){
                    for (int i = 0; i<[news count]; i++) {
                        [_newsArr insertObject:[news objectAtIndex:i] atIndex:0];
                    }
                    News *newsOne =(News*)[_newsArr objectAtIndex:0];
                    _ts = newsOne.ts;
                }
                [self.listView reloadData];
            }
            
            //NSLog(@"page %lu",(unsigned long)_page);
        } page:1 ts:_ts];
    } else {
        [News globalNewsWithBlock:^(NSArray *news, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
            } else {
                if([news count]>0){
                    for (int i = 0; i<[news count]; i++) {
                        [_newsArr addObject:[news objectAtIndex:i]];
                    }
                    //[_newsArr addObjectsFromArray:news];
                    News *newsOne =(News*)[_newsArr objectAtIndex:0];
                    _ts = newsOne.ts;
                    _page=_page+1;
                }
                [self.listView reloadData];
            }
            
            //NSLog(@"page %lu",(unsigned long)_page);
        } page:_page ts:@""];
    }
    
}

- (void)initHeaderView
{
    REPagedScrollView *headerView = [[REPagedScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 180)];
    headerView.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    headerView.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:233.0/255.0
                                                                           green:75.0/255.0
                                                                            blue:63.0/255.0
                                                                           alpha:1.0];
    self.listView.tableHeaderView = headerView;
}
-(void)loadHeaderView
{
    REPagedScrollView *headerView =(REPagedScrollView*) self.listView.tableHeaderView;
    int size = [_bannerArr count];
    if (size>3) {
        size=3;
    }
    //NSLog(@"_bannerArr %@",_bannerArr);
    for (int i=0; i<size; i++) {
        UIImageView *test = [[UIImageView alloc] init];
        test.contentMode = UIViewContentModeScaleAspectFill;
        test.clipsToBounds = YES;
        test.frame = CGRectMake(0, 0, ScreenWidth, 180);
        News* bannerItem = [_bannerArr objectAtIndex:i];
        NSLog(@"bannerItem.thumb_pic %@",bannerItem.thumb_pic);
        [test setImageWithURL:[NSURL URLWithString:bannerItem.thumb_pic]];
        [headerView addPage:test withTitle:bannerItem.title];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    [_header endRefreshing];
    [_footer endRefreshing];
    return [_newsArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [cell configureWithNews:[_newsArr objectAtIndex:indexPath.row]];
    
    //NSLog(@"wocaonimalegebi %@",[_newsArr objectAtIndex:indexPath.row]);
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebShowViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebShowViewController"];
    
    News *news =(News*)[_newsArr objectAtIndex:indexPath.row];
    
    showView.webStr=news.content_url;
    showView.title=@"播报详情";
    
    //若未读 把id存储下来
    if (!news.ifRead) {
        [news setReaded];
        NewsCell *cell = (NewsCell*)[tableView cellForRowAtIndexPath:indexPath];
        [cell.ifNewView setHidden:YES];
    }
    [self.navigationController pushViewController:showView animated:YES];
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
}



@end
