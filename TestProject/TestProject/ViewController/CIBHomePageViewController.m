//
//  CIBHomePageViewController.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBHomePageViewController.h"
#import "SDCycleScrollView.h"
#import "WRNavigationBar.h"

#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + NAV_HEIGHT*2)
#define NAV_HEIGHT 64
#define IMAGE_HEIGHT HEIGHT_LFL(210)
#define SCROLL_DOWN_LIMIT 70
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

@interface CIBHomePageViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *advView;

@end

@implementation CIBHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    self.tableView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-64, 0, 0, 0);
    [self.tableView addSubview:self.advView];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationItem_search"] style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationItem_vrcode"] style:UIBarButtonItemStyleDone target:self action:nil];
    
    [self wr_setNavBarBackgroundAlpha:0];
    [self wr_setNavBarShadowImageHidden:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > NAVBAR_COLORCHANGE_POINT) {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        self.navigationItem.title = @"首页";
    } else {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTintColor:[UIColor whiteColor]];
        [self wr_setNavBarTitleColor:[UIColor whiteColor]];
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        self.navigationItem.title = @"";
    }
    
    //限制下拉的距离
//    if(offsetY < LIMIT_OFFSET_Y) {
//        [scrollView setContentOffset:CGPointMake(0, LIMIT_OFFSET_Y)];
//    }
    
    // 改变图片框的大小 (上滑的时候不改变)
    // 这里不能使用offsetY，因为当（offsetY < LIMIT_OFFSET_Y）的时候，y = LIMIT_OFFSET_Y 不等于 offsetY
    CGFloat newOffsetY = scrollView.contentOffset.y;
    if (newOffsetY < -IMAGE_HEIGHT) {
        self.advView.frame = CGRectMake(0, newOffsetY, SCREEN_WIDTH, -newOffsetY);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault           reuseIdentifier:@"UITableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:colorViewBackGround];
    UIView *backgroundView = [UIView new];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    backgroundView.cornerRadius = 4;
    backgroundView.masksToBounds = YES;
    [cell.contentView addSubview:backgroundView];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return HEIGHT_LFL(144);
    } else if (indexPath.row == 1) {
        return HEIGHT_LFL(89);
    }
    return HEIGHT_LFL(300);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SDCycleScrollView *)advView {
    if (_advView == nil) {
        NSArray *localImages = @[@"http://www.yypt.com/m/mobileindeximg/v4/banner/shuang11app2.png",@"http://www.yypt.com/m/mobileindeximg/v4/banner/xyk1024.png", @"http://www.yypt.com/m/mobileindeximg/v4/banner/zhizhuwang1107.png"];
        _advView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -IMAGE_HEIGHT, SCREEN_WIDTH, IMAGE_HEIGHT) imageURLStringsGroup:localImages];
        _advView.pageDotColor = [UIColor grayColor];
        _advView.currentPageDotColor = [UIColor whiteColor];
        _advView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _advView;
}

@end
