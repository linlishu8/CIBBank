//
//  LWRouter.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/8.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "LWRouter.h"

@implementation LWRouter

+ (instancetype)sharedInstance {
    static LWRouter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (LWViewController *)viewControllerForViewModel:(LWViewModel *)viewModel {
    NSString *viewController = self.viewModelViewMappings[NSStringFromClass(viewModel.class)];
    
    NSParameterAssert([NSClassFromString(viewController) isSubclassOfClass:[LWViewController class]]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

- (NSDictionary *)viewModelViewMappings {
    return @{
             @"CIBTabBarViewModel" : @"CIBTabBarController"
             };
}

- (void)userSignOut:(id<LWViewModelServices>)services {

}

@end
