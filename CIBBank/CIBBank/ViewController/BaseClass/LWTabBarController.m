//
//  ECTabBarController.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/8.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "LWTabBarController.h"

@interface LWTabBarController ()

@property (nonatomic, strong, readwrite) LWViewModel *viewModel;

@end

@implementation LWTabBarController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    LWTabBarController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    
    return viewController;
}

- (LWTabBarController *)initWithViewModel:(id)viewModel {
    self.viewModel = viewModel;
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : colorNavBackGround} forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],  NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
}

- (void)bindViewModel {
    [self.viewModel.errors subscribeNext:^(LWError *error) {
        if ([error.domain isEqualToString:@"暂无数据"]) {
            return;
        }
        if (error) {
            
        }
        
    }];
}


@end
