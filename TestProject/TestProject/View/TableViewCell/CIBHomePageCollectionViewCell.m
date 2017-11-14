//
//  CIBHomePageCollectionViewCell.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/13.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBHomePageCollectionViewCell.h"
#import "CIBMenuCollectionViewCell.h"

@implementation CIBTileCollectionView

@end

@implementation CIBHomePageCollectionViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((KSCREEN_WIDTH - 30)/4, (HEIGHT_LFL(144)-25)/2);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[CIBTileCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[CIBMenuCollectionViewCell class] forCellWithReuseIdentifier:MenuCollectionViewCell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.cornerRadius = 4;
    self.collectionView.masksToBounds = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectionView];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.collectionView.frame = self.contentView.bounds;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath {
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.indexPath = indexPath;
    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
    
    [self.collectionView reloadData];
}

@end

