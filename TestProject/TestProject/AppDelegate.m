//
//  AppDelegate.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/8.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "LWViewModelServicesImpl.h"
#import "LWNavigationControllerStack.h"
#import "LWHomepageViewModel.h"

@interface AppDelegate ()

@property (nonatomic, copy) NSString *reachability;
@property (nonatomic, strong) LWViewModelServicesImpl *services;
@property (nonatomic, strong, readwrite) LWNavigationControllerStack *navigationControllerStack;

@end

@implementation AppDelegate

- (void)reachabilityChanged {
    
    @weakify(self)
    Reachability *baiduReach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    baiduReach.reachableBlock = ^(Reachability * reachability) {
        @strongify(self)
        self.reachability = reachability.currentReachabilityString;
    };
    baiduReach.unreachableBlock = ^(Reachability *reachability) {
        @strongify(self)
        self.reachability = @"NoConnection";
    };
    [baiduReach startNotifier];
}

- (void)configureKeyboardManager {
    IQKeyboardManager.sharedManager.enableAutoToolbar = NO;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self reachabilityChanged];//网络状态
    [self configureKeyboardManager];//键盘
    
    self.services = [[LWViewModelServicesImpl alloc] init];
    self.navigationControllerStack = [[LWNavigationControllerStack alloc] initWithServices:self.services];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.services resetRootViewModel:[self createInitialViewModel]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (LWViewModel *)createInitialViewModel {
    return [[LWHomepageViewModel alloc] initWithServices:self.services params:nil];
}

- (void)configureAppearance {
    self.window.backgroundColor = colorViewBackGround;
    [UINavigationBar appearance].barTintColor = colorNavBackGround;
    [UINavigationBar appearance].barStyle  = UIBarStyleBlack;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    [UITabBar appearance].tintColor = colorNavBackGround;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
