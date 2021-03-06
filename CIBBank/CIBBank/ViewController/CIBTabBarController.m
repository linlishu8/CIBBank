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

@interface CIBTabBarController () <UITabBarControllerDelegate>

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
        [self navigationControllerWithView:[[CIBSupermarketViewController alloc] initWithViewModel:self.viewModel.supermarketViewModel] WithTitle:@"兴社区" imageName:@"tab_icon_Supermarket" selectedImageName:@"tab_icon_Supermarket_selected"];
    });

    UINavigationController *walletNavigationController = ({
        [self navigationControllerWithView:[[CIBWalletViewController alloc] initWithViewModel:self.viewModel.walletViewModel] WithTitle:@"金融资讯" imageName:@"tab_icon_wallet" selectedImageName:@"tab_icon_wallet_selected"];
    });

    UINavigationController *accountNavigationController = ({
        [self navigationControllerWithView:[[CIBAccountViewController alloc] initWithViewModel:self.viewModel.accountViewModel] WithTitle:@"直销银行" imageName:@"tab_icon_account" selectedImageName:@"tab_icon_account_selected"];
    });
    
    UINavigationController *shopNavigationController = ({
        [self navigationControllerWithView:[[CIBAccountViewController alloc] initWithViewModel:self.viewModel.accountViewModel] WithTitle:@"生活商城" imageName:@"frm000_shsc" selectedImageName:@"frm000_shsc_in"];
    });
    
    self.viewControllers = @[homePageNavigationController, supermarketNavigationController, walletNavigationController, accountNavigationController, shopNavigationController];
    
    [LWSharedAppDelegate.navigationControllerStack pushNavigationController:homePageNavigationController];
    
    [[self
      rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
      fromProtocol:@protocol(UITabBarControllerDelegate)]
     subscribeNext:^(RACTuple *tuple) {
         [LWSharedAppDelegate.navigationControllerStack popNavigationController];
         [LWSharedAppDelegate.navigationControllerStack pushNavigationController:tuple.second];
     }];
    
    self.delegate = self;
}

- (LWNavigationController *)navigationControllerWithView:(UIViewController *)viewController
                                               WithTitle:(NSString *)title
                                               imageName:(NSString *)imageName
                                       selectedImageName:(NSString *)selectedImageName {
    
    viewController.tabBarItem.title = title;
    
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
