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
//    self.navigationController.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.view setBackgroundColor:colorViewBackGround];
    
//    UILabel *copyrightLabel = [UILabel label].normalColor(colorFont).normalFont(ECFont(12)).normalTextAlignment(NSTextAlignmentCenter);
//    [self.view addSubview:copyrightLabel];
//
//    copyrightLabel.text = @"兴业银行版权所有 闽ICP备05017231";
//
//    [copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view).offset(-20);
//        make.left.and.right.equalTo(self.view);
//        make.height.mas_equalTo(HEIGHT_LFL(20));
//    }];
}

- (void)bindViewModel {
    [self.viewModel.errors subscribeNext:^(LWError *error) {
        if ([error.domain isEqualToString:@"暂无数据"]) {
            return;
        }
        if (error) {
            
        }
        
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
