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

#define NAVBAR_CHANGE_POINT 30
#define IMAGE_HEIGHT WIDTH_LFL(210)

@interface CIBHomePageViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *advView;

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
    
    self.tableView.tableHeaderView = self.advView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationItem_search"] style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationItem_vrcode"] style:UIBarButtonItemStyleDone target:self action:nil];
    
}

- (SDCycleScrollView *)advView {
    if (_advView == nil) {
        NSArray *localImages = @[@"http://www.yypt.com/m/mobileindeximg/v4/banner/shuang11app2.png",@"http://www.yypt.com/m/mobileindeximg/v4/banner/xyk1024.png", @"http://www.yypt.com/m/mobileindeximg/v4/banner/zhizhuwang1107.png"];
        _advView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, IMAGE_HEIGHT) imageURLStringsGroup:localImages];
        _advView.pageDotColor = [UIColor grayColor];
        _advView.currentPageDotColor = [UIColor whiteColor];
        _advView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        [self adjustStatusBar];
    }
    return _advView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CIBHomePageTableViewCell";
    CIBHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CIBHomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (void)configureCell:(CIBHomePageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)viewModel {
    NSString *imageUrl = @"";
    if (indexPath.row % 2 == 0) {
        imageUrl = @"image_homepage_content_1";
    } else if (indexPath.row % 2 == 1) {
        imageUrl = @"image_homepage_content_2";
    }
    [cell bindViewModel:imageUrl];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
