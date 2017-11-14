//
//  CIBHomePageViewModel.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBHomePageViewModel.h"

@implementation CIBHomePageViewModel

- (void)initialize {
    
    [super initialize];
    
    self.shouldCellSeparatorStyleNone = YES;
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (NSIndexPath *indexPath) {
        NSLog(@"11");
        return [RACSignal empty];
    }];
}

@end
