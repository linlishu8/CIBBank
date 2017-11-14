//
//  CIBHomePageViewController.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBHomePageViewController.h"
#import "CIBHomePageViewModel.h"
#import "CIBHomePageCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "CIBHomePageCollectionViewCell.h"
#import "CIBMenuCollectionViewCell.h"

#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + NAV_HEIGHT*2)
#define NAV_HEIGHT 64
#define IMAGE_HEIGHT HEIGHT_LFL(210)
#define SCROLL_DOWN_LIMIT 70
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

@interface CIBHomePageViewController () <SDCycleScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *advView;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@property (nonatomic, strong, readonly) CIBHomePageViewModel *viewModel;

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
    self.navigationItem.title = @"首页";
    
    _bindCellDict = @[@{@"title" : @"理财超市", @"image" : @"icon_homepage_menu"},
                      @{@"title" : @"钱大交易所", @"image" : @"icon_homepage_menu_1"},
                      @{@"title" : @"基金超市", @"image" : @"icon_homepage_menu_2"},
                      @{@"title" : @"银证转账", @"image" : @"icon_homepage_menu_3"},
                      @{@"title" : @"钱大医生", @"image" : @"icon_homepage_menu_4"},
                      @{@"title" : @"附近网点", @"image" : @"icon_homepage_menu_5"},
                      @{@"title" : @"钱包转账", @"image" : @"icon_homepage_menu_6"},
                      @{@"title" : @"更多", @"image" : @"icon_homepage_menu_7"}];
    
    self.tableView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-64, 0, 0, 0);
    [self.tableView addSubview:self.advView];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationItem_search"] style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationItem_vrcode"] style:UIBarButtonItemStyleDone target:self action:nil];
    
    [self wr_setNavBarBackgroundAlpha:0];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CIBHomePageCollectionViewCell *cell = [[CIBHomePageCollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageCollectionViewCell"];
        [cell setBackgroundColor:colorViewBackGround];
        return cell;
    } else if (indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault           reuseIdentifier:@"UIBannerTableViewCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:colorViewBackGround];
        UIImageView *bannerImageViewLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_homepage_banner_1"]];
        [cell.contentView addSubview:bannerImageViewLeft];
        
        UIImageView *bannerImageViewRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_homepage_banner_2"]];
        [cell.contentView addSubview:bannerImageViewRight];
        
        [bannerImageViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(cell.contentView).offset(10);
            make.bottom.equalTo(cell.contentView);
            make.width.mas_equalTo(cell.contentView).dividedBy(2).offset(-10);
        }];
        
        [bannerImageViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.and.top.and.bottom.equalTo(bannerImageViewLeft);
            make.left.equalTo(bannerImageViewLeft.mas_right).offset(10);
            make.right.equalTo(cell.contentView).offset(-10);
        }];
        return cell;
    }
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault           reuseIdentifier:@"UITableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:colorViewBackGround];
    NSString *imageUrl = @"";
    if (indexPath.row == 2) {
        imageUrl = @"image_homepage_content_1";
    } else if (indexPath.row == 3) {
        imageUrl = @"image_homepage_content_2";
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageUrl]];
    [cell.contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    return HEIGHT_LFL(262);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        CIBHomePageCollectionViewCell *menuCell = (CIBHomePageCollectionViewCell *)cell;
        [menuCell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
        NSInteger index = menuCell.collectionView.indexPath.row;
        
        CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
        [menuCell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
    }
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CIBMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MenuCollectionViewCell forIndexPath:indexPath];
    [cell bindViewModel:_bindCellDict[indexPath.row]];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.didSelectCommand execute:indexPath];
}

#pragma mark - UIScrollViewDelegate Methods

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
        self.advView.frame = CGRectMake(0, newOffsetY, KSCREEN_WIDTH, -newOffsetY);
    }
    
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    CIBTileCollectionView *collectionView = (CIBTileCollectionView *)scrollView;
    NSInteger index = collectionView.indexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SDCycleScrollView *)advView {
    if (_advView == nil) {
        NSArray *localImages = @[@"http://www.yypt.com/m/mobileindeximg/v4/banner/shuang11app2.png",@"http://www.yypt.com/m/mobileindeximg/v4/banner/xyk1024.png", @"http://www.yypt.com/m/mobileindeximg/v4/banner/zhizhuwang1107.png"];
        _advView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -IMAGE_HEIGHT, KSCREEN_WIDTH, IMAGE_HEIGHT) imageURLStringsGroup:localImages];
        _advView.pageDotColor = [UIColor grayColor];
        _advView.currentPageDotColor = [UIColor whiteColor];
        _advView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _advView;
}

@end
