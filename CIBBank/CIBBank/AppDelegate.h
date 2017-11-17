//
//  AppDelegate.h
//  CIBBank
//
//  Created by 动感超人 on 2017/11/15.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWNavigationControllerStack.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readonly) LWNavigationControllerStack *navigationControllerStack;

@end

