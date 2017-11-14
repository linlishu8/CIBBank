//
//  CIBHomePageViewModel.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBHomePageViewModel.h"
#import "CIBWebViewModel.h"

@implementation CIBHomePageViewModel

- (void)initialize {
    
    [super initialize];
    
    self.shouldCellSeparatorStyleNone = YES;
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (NSIndexPath *indexPath) {
        CIBWebViewModel *webViewModel = [[CIBWebViewModel alloc] initWithServices:self.services params:@"www.baidu.com"];
        [self.services pushViewModel:webViewModel animated:YES];
        return [RACSignal empty];
    }];
}

@end
