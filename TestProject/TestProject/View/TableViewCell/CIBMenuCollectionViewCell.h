//
//  CIBMenuCollectionViewCell.h
//  TestProject
//
//  Created by 动感超人 on 2017/11/13.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWReactiveView.h"

@interface CIBMenuCollectionViewCell : UICollectionViewCell <LWReactiveView>

@property (nonatomic, strong) NSDictionary *bindDict;

@end
