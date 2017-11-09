//
//  CIBTabBarController.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBTabBarController.h"
#import "LWNavigationController.h"
#import "CIBHomePageViewController.h"
#import "CIBSupermarketViewController.h"
#import "CIBWalletViewController.h"
#import "CIBAccountViewController.h"
#import "CIBTabBarViewModel.h"
#import "LWTabBar.h"

@interface CIBTabBarController ()

@property (nonatomic, strong) CIBTabBarViewModel *viewModel;

@end

@implementation CIBTabBarController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *homePageNavigationController = ({
        [self navigationControllerWithView:[[CIBHomePageViewController alloc] initWithViewModel:self.viewModel.homePageViewModel] WithTitle:@"首页" imageName:@"tab_icon_homepage" selectedImageName:@"tab_icon_homepage_selected"];
    });
    
    UINavigationController *supermarketNavigationController = ({
        [self navigationControllerWithView:[[CIBSupermarketViewController alloc] initWithViewModel:self.viewModel.supermarketViewModel] WithTitle:@"金融超市" imageName:@"tab_icon_Supermarket" selectedImageName:@"tab_icon_Supermarket_selected"];
    });
    
    UINavigationController *walletNavigationController = ({
        [self navigationControllerWithView:[[CIBWalletViewController alloc] initWithViewModel:self.viewModel.walletViewModel] WithTitle:@"掌柜钱包" imageName:@"tab_icon_wallet" selectedImageName:@"tab_icon_wallet_selected"];
    });
    
    UINavigationController *accountNavigationController = ({
        [self navigationControllerWithView:[[CIBAccountViewController alloc] initWithViewModel:self.viewModel.accountViewModel] WithTitle:@"我的账户" imageName:@"tab_icon_account" selectedImageName:@"tab_icon_account_selected"];
    });
    
    [self.tabBarController addChildViewController:homePageNavigationController];
    [self.tabBarController addChildViewController:supermarketNavigationController];
    [self.tabBarController addChildViewController:walletNavigationController];
    [self.tabBarController addChildViewController:accountNavigationController];
    
    [ECSharedAppDelegate.navigationControllerStack pushNavigationController:homePageNavigationController];
    
    [[self
      rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
      fromProtocol:@protocol(UITabBarControllerDelegate)]
     subscribeNext:^(RACTuple *tuple) {
         [ECSharedAppDelegate.navigationControllerStack popNavigationController];
         [ECSharedAppDelegate.navigationControllerStack pushNavigationController:tuple.second];
     }];
    
    self.tabBarController.delegate = self;
    
    LWTabBar *tabBar = [[LWTabBar alloc] init];
    [self.tabBarController setValue:tabBar forKey:@"tabBar"];
    
//    @weakify(self)
//    [[tabBar.centerButton rac_signalForControlEvents:UIControlEventTouchUpInside]
//     subscribeNext:^(__kindof UIControl * _Nullable x) {
//         @strongify(self)
//         if ([self.viewModel.services.user.myBindDoorList.modelList count] == 1) {
//             [self.viewModel.doorOpenCommand execute:nil];
//         } else {
//             self.tabBarController.selectedIndex = 1;
//             [ECSharedAppDelegate.navigationControllerStack pushNavigationController:depositNavigationController];
//         }
//     }];
}

- (LWNavigationController *)navigationControllerWithView:(UIViewController *)viewController
                                               WithTitle:(NSString *)title
                                               imageName:(NSString *)imageName
                                       selectedImageName:(NSString *)selectedImageName {
    
    viewController.tabBarItem.title = title;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],  NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    if (imageName) {
        UIImage *normalImage = [UIImage imageNamed:imageName];
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.image = normalImage;
    }
    if (selectedImageName) {
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage = selectedImage;
    }
    return [[LWNavigationController alloc] initWithRootViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
