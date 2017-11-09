//
//  LWViewController.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/8.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "LWViewController.h"


@interface LWViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite) LWViewModel *viewModel;

@end

@implementation LWViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    LWViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    
    return viewController;
}

- (LWViewController *)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.view setBackgroundColor:colorViewBackGround];
}

- (void)bindViewModel {
    [self.viewModel.errors subscribeNext:^(LWError *error) {
        MRCLogError(error);
        if ([error.domain isEqualToString:@"暂无数据"]) {
            return;
        }
        if (error) {
            
        }
        
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
