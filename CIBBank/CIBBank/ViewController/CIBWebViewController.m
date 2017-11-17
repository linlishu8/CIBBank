//
//  CIBWebViewController.m
//  TestProject
//
//  Created by 动感超人 on 2017/11/14.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import "CIBWebViewController.h"
#import <WebKit/WebKit.h>
#import <objc/runtime.h>

@interface CIBWebViewController () <WKUIDelegate, WKNavigationDelegate>

@property(nonatomic, assign) BOOL enabledWebViewUIDelegate;
@property(nonatomic, assign) CIBWebViewControllerNavigationType navigationType;

@property(nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, strong) WKWebView *webView;



@end

@interface UIProgressView (WebKit)
/// Hidden when progress approach 1.0 Default is NO.
@property(assign, nonatomic) BOOL cib_hiddenWhenProgressApproachFullSize;
/// The web view controller.
@property(strong, nonatomic) CIBWebViewController *cib_webViewController;

@end

@implementation CIBWebViewController {
    WKWebViewConfiguration *_configuration;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (WKWebView *)webView {
    if (_webView) return _webView;
    WKWebViewConfiguration *config = _configuration;
    if (!config) {
        config = [[WKWebViewConfiguration alloc] init];
        config.preferences.minimumFontSize = 9.0;
        if ([config respondsToSelector:@selector(setAllowsInlineMediaPlayback:)]) {
            [config setAllowsInlineMediaPlayback:YES];
        }
        if (@available(iOS 9.0, *)) {
            if ([config respondsToSelector:@selector(setApplicationNameForUserAgent:)]) {
                
                [config setApplicationNameForUserAgent:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
            }
        } else {
            // Fallback on earlier versions
        }
        
        if (@available(iOS 10.0, *)) {
            if ([config respondsToSelector:@selector(setMediaTypesRequiringUserActionForPlayback:)]){
                [config setMediaTypesRequiringUserActionForPlayback:WKAudiovisualMediaTypeNone];
            }
        } else if (@available(iOS 9.0, *)) {
            if ( [config respondsToSelector:@selector(setRequiresUserActionForMediaPlayback:)]) {
                [config setRequiresUserActionForMediaPlayback:NO];
            }
        } else {
            if ( [config respondsToSelector:@selector(setMediaPlaybackRequiresUserAction:)]) {
                [config setMediaPlaybackRequiresUserAction:NO];
            }
        }
        
    }
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    _webView.allowsBackForwardNavigationGestures = YES;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.scrollView.backgroundColor = [UIColor clearColor];
    // Set auto layout enabled.
    _webView.translatesAutoresizingMaskIntoConstraints = NO;
    if (_enabledWebViewUIDelegate) _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    // Obverse the content offset of the scroll view.
    [_webView addObserver:self forKeyPath:@"scrollView.contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    // Obverse title. Fix issue: https://github.com/devedbox/AXWebViewController/issues/35
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    return _webView;
}

- (UIProgressView *)progressView {
    if (_progressView) return _progressView;
    CGFloat progressBarHeight = 2.0f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[UIProgressView alloc] initWithFrame:barFrame];
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.cib_hiddenWhenProgressApproachFullSize = YES;
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    // Set the web view controller to progress view.
    __weak typeof(self) wself = self;
    _progressView.cib_webViewController = wself;
    return _progressView;
}

//- (void)updateToolbarItems {
//    self.backBarButtonItem.enabled = self.self.webView.canGoBack;
//    self.forwardBarButtonItem.enabled = self.self.webView.canGoForward;
//    self.actionBarButtonItem.enabled = !self.self.webView.isLoading;
//
//    UIBarButtonItem *refreshStopBarButtonItem = self.self.webView.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
//
//    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        fixedSpace.width = 35.0f;
//        NSArray *items = [NSArray arrayWithObjects:fixedSpace, refreshStopBarButtonItem, fixedSpace, self.backBarButtonItem, fixedSpace, self.forwardBarButtonItem, fixedSpace, self.actionBarButtonItem, nil];
//
//        self.navigationItem.rightBarButtonItems = items.reverseObjectEnumerator.allObjects;
//    } else {
//        NSArray *items = [NSArray arrayWithObjects: fixedSpace, self.backBarButtonItem, flexibleSpace, self.forwardBarButtonItem, flexibleSpace, refreshStopBarButtonItem, flexibleSpace, self.actionBarButtonItem, fixedSpace, nil];
//
//        self.navigationController.toolbar.barStyle = self.navigationController.navigationBar.barStyle;
//        self.navigationController.toolbar.tintColor = self.navigationController.navigationBar.tintColor;
//        self.navigationController.toolbar.barTintColor = self.navigationController.navigationBar.barTintColor;
//        self.toolbarItems = items;
//    }
//}
//
//- (void)updateNavigationItems {
//    [self.navigationItem setLeftBarButtonItems:nil animated:NO];
//    if (self.webView.canGoBack/* || self.webView.backForwardList.backItem*/) {// Web view can go back means a lot requests exist.
//        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        spaceButtonItem.width = -6.5;
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//        if (self.navigationController.viewControllers.count == 1) {
//            NSMutableArray *leftBarButtonItems = [NSMutableArray arrayWithArray:@[spaceButtonItem,self.navigationBackBarButtonItem]];
//            // If the top view controller of the navigation controller is current vc, the close item is ignored.
//            if (self.showsNavigationCloseBarButtonItem && self.navigationController.topViewController != self){
//                [leftBarButtonItems addObject:self.navigationCloseBarButtonItem];
//            }
//
//            [self.navigationItem setLeftBarButtonItems:leftBarButtonItems animated:NO];
//        } else {
//            if (self.showsNavigationCloseBarButtonItem){
//                [self.navigationItem setLeftBarButtonItems:@[self.navigationCloseBarButtonItem] animated:NO];
//            }else{
//                [self.navigationItem setLeftBarButtonItems:@[] animated:NO];
//            }
//        }
//    } else {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        [self.navigationItem setLeftBarButtonItems:nil animated:NO];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

@implementation UIProgressView (WebKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Inject "-popViewControllerAnimated:"
        Method originalMethod = class_getInstanceMethod(self, @selector(setProgress:));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(ax_setProgress:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
        originalMethod = class_getInstanceMethod(self, @selector(setProgress:animated:));
        swizzledMethod = class_getInstanceMethod(self, @selector(ax_setProgress:animated:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (void)ax_setProgress:(float)progress {
    [self ax_setProgress:progress];
    
    [self checkHiddenWhenProgressApproachFullSize];
}

- (void)ax_setProgress:(float)progress animated:(BOOL)animated {
    [self ax_setProgress:progress animated:animated];
    
    [self checkHiddenWhenProgressApproachFullSize];
}

- (void)checkHiddenWhenProgressApproachFullSize {
    if (!self.cib_hiddenWhenProgressApproachFullSize) {
        return;
    }
    
    float progress = self.progress;
    if (progress < 1) {
        if (self.hidden) {
            self.hidden = NO;
        }
    } else if (progress >= 1) {
        [UIView animateWithDuration:0.35 delay:0.15 options:7 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                self.hidden = YES;
                self.progress = 0.0;
                self.alpha = 1.0;
                // Update the navigation itmes if the delegate is not being triggered.
//                if (self.cib_webViewController.navigationType == CIBWebViewControllerNavigationBarItem) {
//                    [self.cib_webViewController updateNavigationItems];
//                } else {
//                    [self.cib_webViewController updateToolbarItems];
//                }
            }
        }];
    }
}

- (BOOL)cib_hiddenWhenProgressApproachFullSize {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCib_hiddenWhenProgressApproachFullSize:(BOOL)cib_hiddenWhenProgressApproachFullSize {
    objc_setAssociatedObject(self, @selector(cib_hiddenWhenProgressApproachFullSize), @(cib_hiddenWhenProgressApproachFullSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CIBWebViewController *)cib_webViewController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCib_webViewController:(CIBWebViewController *)cib_webViewController {
    objc_setAssociatedObject(self, @selector(cib_webViewController), cib_webViewController, OBJC_ASSOCIATION_ASSIGN);
}

@end
