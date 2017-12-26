//
//  CIBHomePageViewController.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBHomePageViewController.h"
#import "CIBHomePageViewModel.h"
#import "SDCycleScrollView.h"
#import "CIBHomePageTableViewCell.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 170
#define NAV_HEIGHT 64
#define SCROLL_DOWN_LIMIT 70
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

@interface CIBHomePageViewController () <SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SDCycleScrollView *advView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation CIBHomePageViewController {
    NSArray *_bindCellDict;
}

@dynamic viewModel;

- (void)bindViewModel {
    [super bindViewModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = self.advView;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationItem_vrcode"] style:UIBarButtonItemStyleDone target:self action:nil];
    
    UIBarButtonItem *serviceRightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationItem_service"] style:UIBarButtonItemStyleDone target:self action:nil];
    
    UIBarButtonItem *messageRightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationItem_message"] style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.navigationItem.rightBarButtonItems = @[messageRightItem, serviceRightItem];
    
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    
    self.searchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH_LFL(183), HEIGHT_LFL(25))];
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"navigationItem_search"] forState:UIControlStateNormal];
//    [self.searchButton addTarget:self action:@selector(onClickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.searchButton;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > NAV_HEIGHT) {
//        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
//        [self wr_setNavBarBackgroundAlpha:alpha];
//        [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
//        [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
//        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
//    } else {
//        [self wr_setNavBarBackgroundAlpha:0];
//        [self wr_setNavBarTintColor:[UIColor whiteColor]];
//        [self wr_setNavBarTitleColor:[UIColor whiteColor]];
//        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
//    }
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [self updateNavBarButtonItemsAlphaAnimated:.0f];
    } else {
        [self updateNavBarButtonItemsAlphaAnimated:1.0f];
    }
    
    if (offsetY > NAVBAR_COLORCHANGE_POINT) {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self updateSearchBarColor:alpha];
        [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    } else {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTintColor:[UIColor whiteColor]];
        [self wr_setNavBarTitleColor:[UIColor whiteColor]];
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    //限制下拉的距离
    if(offsetY < LIMIT_OFFSET_Y) {
        [scrollView setContentOffset:CGPointMake(0, LIMIT_OFFSET_Y)];
    }
}

- (void)updateNavBarButtonItemsAlphaAnimated:(CGFloat)alpha
{
    NSLog(@"alpha%.2f",alpha);
    [UIView animateWithDuration:0.2 animations:^{
        [self.navigationController.navigationBar wr_setBarButtonItemsAlpha:alpha hasSystemBackIndicator:NO];
    }];
}

- (void)updateSearchBarColor:(CGFloat)alpha {
    UIColor *color = [[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0] colorWithAlphaComponent:alpha];
    UIImage *image = [UIImage imageNamed:@"navigationItem_search"];
    image = [image lw_updateImageWithTintColor:color alpha:alpha];
    [self.searchButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark - tableview delegate / dataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = [NSString stringWithFormat:@"空的 %zd",indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.row == 0) {
//        return HEIGHT_LFL(144);
//    } else if (indexPath.row == 1) {
//        return HEIGHT_LFL(89);
//    }
    return HEIGHT_LFL(262);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self touchVerification];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(-[self navBarBottom], 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (SDCycleScrollView *)advView {
    if (_advView == nil) {
        NSArray *localImages = @[@"http://www.yypt.com/m/mobileindeximg/v4/banner/shuang11app2.png",@"http://www.yypt.com/m/mobileindeximg/v4/banner/xyk1024.png", @"http://www.yypt.com/m/mobileindeximg/v4/banner/zhizhuwang1107.png"];
        _advView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, HEIGHT_LFL(210)) imageURLStringsGroup:localImages];
        _advView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [self adjustStatusBar];
    }
    return _advView;
}

- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(CGSizeMake(newSize.width*2, newSize.height*2));
    [image drawInRect:CGRectMake (0, 0, newSize.width*2, newSize.height*2)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (int)navBarBottom {
    if ([WRNavigationBar isIphoneX]) {
        return 88;
    } else {
        return 64;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
