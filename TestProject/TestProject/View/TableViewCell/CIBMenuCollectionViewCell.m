//
//  CIBMenuCollectionViewCell.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/13.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBMenuCollectionViewCell.h"

@interface CIBMenuCollectionViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *iconLabel;

@end

@implementation CIBMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [UIImageView new];
        [self.contentView addSubview:self.iconImageView];
        
        self.iconLabel = [UILabel label].normalColor(colorFont).normalFont(ECFont(12)).normalTextAlignment(NSTextAlignmentCenter);
        [self.contentView addSubview:self.iconLabel];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(HEIGHT_LFL(30));
            make.top.equalTo(self.contentView).offset(HEIGHT_LFL(7));
            make.centerX.equalTo(self.contentView);
        }];
        
        [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.equalTo(self.contentView);
            make.top.equalTo(self.iconImageView.mas_bottom);
        }];
        
        @weakify(self)
        [[[RACObserve(self, bindDict)
           distinctUntilChanged]
          filter:^BOOL(NSDictionary *dict) {
              return dict ? YES : NO;
          }]
         subscribeNext:^(NSDictionary *dict) {
             @strongify(self)
             [self.iconImageView setImage:[UIImage imageNamed:dict[@"image"]]];
             [self.iconLabel setText:dict[@"title"]];
         }];
    }
    return self;
}

- (void)bindViewModel:(NSDictionary *)viewModel {
    self.bindDict = viewModel;
}

@end
