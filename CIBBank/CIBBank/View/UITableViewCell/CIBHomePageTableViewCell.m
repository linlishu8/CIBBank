//
//  CIBHomePageTableViewCell.m
//  CIBBank
//
//  Created by 动感超人 on 2017/11/16.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBHomePageTableViewCell.h"

@interface CIBHomePageTableViewCell ()

@property (nonatomic, strong) UIImageView *cellImageView;

@end


@implementation CIBHomePageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.cellImageView];
        
        [self.cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
    }
    return self;
}

- (void)bindViewModel:(NSString *)viewModel {
    [self.cellImageView setImage:[UIImage imageNamed:viewModel]];
}

@end
