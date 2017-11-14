//
//  CIBHomePageCollectionViewCell.h
//  TestProject
//
//  Created by 动感超人 on 2017/11/13.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CIBTileCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *MenuCollectionViewCell = @"CIBMenuCollectionViewCell";

@interface CIBHomePageCollectionViewCell : UITableViewCell

@property (nonatomic, strong) CIBTileCollectionView *collectionView;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end
