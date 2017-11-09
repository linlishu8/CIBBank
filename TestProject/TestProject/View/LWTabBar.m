//
//  LWTabBar.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "LWTabBar.h"

#define ButtonNumber 5

@interface LWTabBar ()

@property (nonatomic, strong, readwrite) UIButton *centerButton;

@end

@implementation LWTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.barTintColor = [UIColor whiteColor];
        self.centerButton = [UIButton button].normalImage(@"tab_icon_code");
        [self.centerButton setAdjustsImageWhenHighlighted:NO];
        [self addSubview:self.centerButton];
        
        [self.centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-15);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    
    CGFloat buttonW = barWidth / ButtonNumber;
    CGFloat buttonH = barHeight - 2;
    CGFloat buttonY = 1;
    
    NSInteger buttonIndex = 0;
    
    for (UIView *view in self.subviews) {
        
        NSString *viewClass = NSStringFromClass([view class]);
        if (![viewClass isEqualToString:@"UITabBarButton"]) continue;
        
        CGFloat buttonX = buttonIndex * buttonW;
        if (buttonIndex >= 2) { // 右边2个按钮
            buttonX += buttonW;
        }
        
        view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        
        buttonIndex ++;
        
        
    }
}
@end
