//
//  CIBTabBarViewModel.h
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "LWViewModel.h"
#import "CIBHomePageViewModel.h"
#import "CIBSupermarketViewModel.h"
#import "CIBWalletViewModel.h"
#import "CIBAccountViewModel.h"

@interface CIBTabBarViewModel : LWViewModel

//首页
@property (nonatomic, strong, readonly) CIBHomePageViewModel *homePageViewModel;
//金融超市
@property (nonatomic, strong, readonly) CIBSupermarketViewModel *supermarketViewModel;
//掌柜钱包
@property (nonatomic, strong, readonly) CIBWalletViewModel *walletViewModel;
//我的账户
@property (nonatomic, strong, readonly) CIBAccountViewModel *accountViewModel;

@property (nonatomic, strong, readonly) RACCommand *doorOpenCommand;//钱大扫码

@end
