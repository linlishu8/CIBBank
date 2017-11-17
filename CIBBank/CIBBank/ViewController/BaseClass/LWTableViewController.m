//
//  LWTableViewController.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "LWTableViewController.h"
#import "LWTableViewModel.h"
#import "MJRefresh.h"

@interface LWTableViewController ()

@property (nonatomic, strong, readwrite) UITableView *tableView;

@property (nonatomic, strong, readonly) LWTableViewModel *viewModel;

@end

@implementation LWTableViewController

@dynamic viewModel;

- (instancetype)initWithViewModel:(LWViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        if ([viewModel shouldRequestRemoteDataOnViewDidLoad]) {
            @weakify(self)
            [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
                @strongify(self)
                [self.viewModel.requestRemoteDataCommand execute:@1];
            }];
        }
    }
    return self;
}

- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self)
    [[RACObserve(self.viewModel, dataSource)
      deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self)
         [self reloadData];
     }];
    
    [self.viewModel.requestRemoteDataCommand.executing subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        UIView *emptyDataSetView = [self.tableView.subviews.rac_sequence objectPassingTest:^(UIView *view) {
            return [NSStringFromClass(view.class) isEqualToString:@"DZNEmptyDataSetView"];
        }];
        emptyDataSetView.alpha = 1.0 - executing.floatValue;
        
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
        tableView;
    });
    
    if (self.viewModel.shouldCellSeparatorStyleNone) {
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView setSeparatorColor:[UIColor clearColor]];
    }
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = footer;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
    
    if (self.viewModel.shouldPullToRefresh) {
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTriggered:)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        self.tableView.mj_header = header;
    }
    
    if (self.viewModel.shouldInfiniteScrolling) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        self.tableView.mj_footer = footer;

        @weakify(self)
        RAC(self.tableView.mj_footer, hidden) = [[RACObserve(self.viewModel, dataSource)
                                                  deliverOnMainThread]
                                                 map:^(NSArray *dataSource) {
                                                     @strongify(self)
                                                     NSUInteger count = 0;
                                                     count += dataSource.count;
                                                     return @(count < self.viewModel.perPage);
                                                 }];
    }
}

- (void)refreshTriggered:(id)sender {
    @weakify(self)
    [[[self.viewModel.requestRemoteDataCommand
       execute:@1]
      deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self)
         self.viewModel.page = 1;
     } error:^(NSError *error) {
         @strongify(self)
         [self.tableView.mj_header endRefreshing];
     } completed:^{
         @strongify(self)
         [self.tableView.mj_header endRefreshing];
     }];
}

- (void)loadMoreData {
    @weakify(self)
    [[[self.viewModel.requestRemoteDataCommand
       execute:@(self.viewModel.page + 1)]
      deliverOnMainThread]
     subscribeNext:^(NSArray *results) {
         @strongify(self)
         self.viewModel.page += 1;

     } error:^(NSError *error) {
         @strongify(self)
         [self.tableView.mj_footer endRefreshingWithNoMoreData];
     } completed:^{
         @strongify(self)
         [self.tableView.mj_footer endRefreshing];
     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"ECTableViewCellStyleSubtitle" forIndexPath:indexPath];
    cell.textLabel.font = ECFont(14.0);
    cell.detailTextLabel.font = ECFont(14.0);
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    id object = self.viewModel.dataSource[indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    UIFont *font = ECBoldFont(16.0);
    UIColor *textColor = colorFont;
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:@"没有数据哦" attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    UIFont *font = ECFont(14.0);
    UIColor *textColor = colorViewBorder;
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"暂无数据，使用后重试" attributes:attributes];
    return attributedString;
    
}


#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return [self.viewModel.dataSource count] == 0 || self.viewModel.dataSource == nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"placeholder_tumblr"];
}


- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    scrollView.contentOffset = CGPointZero;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    
    CGFloat offset = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    offset += CGRectGetHeight(self.navigationController.navigationBar.frame);
    return -offset;
}



@end
