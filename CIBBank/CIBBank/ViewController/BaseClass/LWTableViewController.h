//
//  LWTableViewController.h
//  TestProject
//
//  Created by 动感超人 on 2017/11/9.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "LWViewController.h"

@interface LWTableViewController : LWViewController <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;

- (void)reloadData;

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end
