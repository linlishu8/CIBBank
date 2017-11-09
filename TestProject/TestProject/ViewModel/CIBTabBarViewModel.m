//
//  CIBTabBarViewModel.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBTabBarViewModel.h"

@interface CIBTabBarViewModel ()

@property (nonatomic, strong, readwrite) CIBHomePageViewModel *homePageViewModel;
@property (nonatomic, strong, readwrite) CIBSupermarketViewModel *supermarketViewModel;
@property (nonatomic, strong, readwrite) CIBWalletViewModel *walletViewModel;
@property (nonatomic, strong, readwrite) CIBAccountViewModel *accountViewModel;

@property (nonatomic, strong, readwrite) RACCommand *doorOpenCommand;

@end

@implementation CIBTabBarViewModel

- (void)initialize {
    
    [super initialize];
    
    self.homePageViewModel = [[CIBHomePageViewModel alloc] initWithServices:self.services params:nil];
    self.supermarketViewModel = [[CIBSupermarketViewModel alloc] initWithServices:self.services params:nil];
    self.walletViewModel = [[CIBWalletViewModel alloc] initWithServices:self.services params:nil];
    self.accountViewModel = [[CIBAccountViewModel alloc] initWithServices:self.services params:nil];
    
    [self.doorOpenCommand.errors subscribe:self.errors];
}

@end
