//
//  SchoolViewController.m
//  zhonghan
//
//  Created by xiangpaopao on 13-8-9.
//  Copyright (c) 2013年 xiangpaopao. All rights reserved.
//

#import "SchoolViewController.h"
#import "REPagedScrollView.h"
#import "SchoolCell.h"
#import "WebShowViewController.h"
#import "SchoolsNews.h"
#import "MJRefresh.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIView+WhenTappedBlocks.h"

@interface SchoolViewController ()<MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
    
    NSMutableArray *_newsArr;
    NSMutableArray *_bannerArr;
    NSUInteger _page;
    NSString *_ts;
}

@end

@implementation SchoolViewController

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
    self.title = @"税务学院";
    //self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initHeaderView];
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
    _newsArr = [NSMutableArray arrayWithCapacity:5];
    _bannerArr = [NSMutableArray arrayWithCapacity:5];
    [self initData];
    
    //点击banner进入详情
    [self.listView.tableHeaderView whenTapped:^{
        SchoolsNews *news =(SchoolsNews*)[_bannerArr objectAtIndex:self.headerView.pageControl.currentPage];
        WebShowViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebShowViewController"];
        showView.webStr=news.content_url;
        showView.title=@"播报详情";
        //若未读 把id存储下来
        if (!news.ifRead) {
            [news setReaded];
        }
        [self.navigationController pushViewController:showView animated:YES];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)initData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    [SchoolsNews globalSchoolsWithBlock:^(NSArray *news, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            [hud hide:YES];
            [_newsArr addObjectsFromArray:news];
            
            SchoolsNews *newsOne =(SchoolsNews*)[_newsArr objectAtIndex:0];
            _ts = newsOne.ts;
            [SchoolsNews updateLocalTs:_ts];
            _page=_page+1;
            [self.listView reloadData];
            
            //banner图
            [self loadHeaderView];
        }
    } page:1 ts:_ts];
}

#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_header == refreshView) {
        [SchoolsNews globalSchoolsWithBlock:^(NSArray *news, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
            } else {
                if([news count]>0){
                    for (int i = 0; i<[news count]; i++) {
                        [_newsArr insertObject:[news objectAtIndex:i] atIndex:0];
                    }
                    SchoolsNews *newsOne =(SchoolsNews*)[_newsArr objectAtIndex:0];
                    _ts = newsOne.ts;
                    [SchoolsNews updateLocalTs:_ts];
                }
                [self.listView reloadData];
                [self loadHeaderView];
            }
        } page:1 ts:_ts];
    } else {
        [SchoolsNews globalSchoolsWithBlock:^(NSArray *news, NSError *error) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
            } else {
                if([news count]>0){
                    for (int i = 0; i<[news count]; i++) {
                        [_newsArr addObject:[news objectAtIndex:i]];
                    }
                    //[_newsArr addObjectsFromArray:news];
                    SchoolsNews *newsOne =(SchoolsNews*)[_newsArr objectAtIndex:0];
                    _ts = newsOne.ts;
                    _page=_page+1;
                }
                [self.listView reloadData];
                [self loadHeaderView];
            }
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
    self.headerView = headerView;
    self.listView.tableHeaderView = self.headerView ;
}
-(void)loadHeaderView
{
    [self.headerView removeAllPages];
    [_bannerArr removeAllObjects];
    for (SchoolsNews *item in _newsArr) {
        if (item.type == 1) {
            [_bannerArr insertObject:item atIndex:0];
            //NSLog(@"item.type %@",_bannerArr);
        }
    };
    
    int size = [_bannerArr count];
    self.listView.tableHeaderView = self.headerView;
    
    if (size>3) {
        size=3;
    }else if(size==0){
        self.listView.tableHeaderView = nil;
    }
    NSLog(@"banner size %i",size);
    for (int i=0; i<size; i++) {
        UIImageView *test = [[UIImageView alloc] init];
        test.contentMode = UIViewContentModeScaleAspectFill;
        test.clipsToBounds = YES;
        test.frame = CGRectMake(0, 0, ScreenWidth, 180);
        SchoolsNews* bannerItem = [_bannerArr objectAtIndex:i];
        //NSLog(@"bannerItem.thumb_pic %@",bannerItem.thumb_pic);
        [test setImageWithURL:[NSURL URLWithString:bannerItem.thumb_pic]];
        [self.headerView addPage:test withTitle:bannerItem.title];
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
    static NSString *CellIdentifier = @"SchoolCell";
    SchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    [cell configureWithSchool:[_newsArr objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebShowViewController *showView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebShowViewController"];
    SchoolsNews *news =(SchoolsNews*)[_newsArr objectAtIndex:indexPath.row];
    showView.webStr=news.content_url;
    showView.title=@"课程内容";
    //若未读 把id存储下来
    if (!news.ifRead) {
        [news setReaded];
        SchoolCell *cell = (SchoolCell*)[tableView cellForRowAtIndexPath:indexPath];
        [cell.ifNewView setHidden:YES];
    }
    [self.navigationController pushViewController:showView animated:YES];
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
}


@end
