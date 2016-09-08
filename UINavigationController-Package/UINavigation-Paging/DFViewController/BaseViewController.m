//
//  BaseViewController.m
//  UINavigation-Paging
//
//  Created by Cyfuer on 16/4/14.
//  Copyright © 2016年 Cyfuer. All rights reserved.
//

#import "baseViewController.h"

float const nav_barItem_horizontalSpacing = 16;
float const nav_barItem_horizontalMargin  = 0;
float const nav_barItem_buttonFont = 16;
float const nav_barItem_titleFont = 16;

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark  -  导航栏

- (void)hideNav {
    if (!self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)showNav {
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)setBackBtn {
    
    // 显示导航栏
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
    // 隐藏原生返回按钮
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    // 填充块，让按钮贴近左侧
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width =  nav_barItem_horizontalMargin;
    
    // 返回按钮
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    backBtn.imageView.contentMode = UIViewContentModeCenter;
    [backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,backItem] animated:YES];
}

- (void)setTitle:(NSString *)title {
    // 显示导航栏
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
    self.navigationItem.titleView = [self getNavLabelWithString:title];
}

// 通过名称自定义单个按钮
- (UIButton *)setLeftNavBarItemWithTitle:(NSString *)title action:(SEL)action {
    
    if (title && ![title isEqual:[NSNull null]] && title.length) {
        // 显示导航栏
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        /*
            BUG:如果调用这行代码，在手势返回又取消的时候，原生返回按钮会以三个点的形式显示在导航栏上面，那是因为返回按钮的宽度不够，文字被压缩
            Request:我觉得是因为这句代码的调用让返回按钮初始化存在了，在手势返回又取消的时候，导航栏重新刷新，显示出了原生返回按钮
         */
        // 隐藏原生返回按钮
        //[self.navigationItem setHidesBackButton:YES animated:NO];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIButton *button = [self getNavButtonWithString:title sel:action];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,barItem] animated:YES];
        
        return button;
    }
    else {
        return nil;
    }
}

- (UIButton *)setLeftNavBarItemWithImage:(UIImage *)image action:(SEL)action {
    if (image) {
        // 显示导航栏
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        // 隐藏原生返回按钮
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIButton *button = [self getNavButtonWithImage:image sel:action];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,barItem] animated:YES];
        
        return button;
    }
    else {
        return nil;
    }
}

// 通过自定义视图定义单个按钮
- (void)setLeftNavBarItemWithView:(UIView *)view {
    if (view) {
        // 显示导航栏
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        // 隐藏原生返回按钮
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        
        [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,barButtonItem] animated:YES];
    }
}

// 通过自定义视图数组定义多个按钮
- (void)setLeftNavBarItemsWithViews:(NSArray *)views {
    if (views && views.count) {
        // 显示导航栏
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        // 隐藏原生返回按钮
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
        // 生成barButtonItem数组
        NSMutableArray *barButtonItems = [NSMutableArray array];
        
        for (UIView *view in views) {
            if (barButtonItems.count) {
                UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
                spaceBarButtonItem.width = nav_barItem_horizontalSpacing;
                [barButtonItems addObject:spaceBarButtonItem];
            }
            else {
                UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                   target:nil action:nil];
                negativeSpacer.width = nav_barItem_horizontalMargin;
                [barButtonItems addObject:negativeSpacer];
            }
            
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
            [barButtonItems addObject:barButtonItem];
        }
        
        // 添入navgationItem
        [self.navigationItem setLeftBarButtonItems:barButtonItems animated:YES];
    }
}

// 通过名称自定义单个按钮
- (UIButton *)setRightNavBarItemWithTitle:(NSString *)title action:(SEL)action {
    if (title && ![title isEqual:[NSNull null]] && title.length) {
        // 显示导航栏
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        // 隐藏原生返回按钮
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIButton *button = [self getNavButtonWithString:title sel:action];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        [self.navigationItem setRightBarButtonItems:@[negativeSpacer,barItem] animated:YES];
        
        return button;
    }
    else {
        return nil;
    }
}

- (UIButton *)setRightNavBarItemWithImage:(UIImage *)image action:(SEL)action {
    if (image) {
        // 显示导航栏
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        // 隐藏原生返回按钮
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIButton *button = [self getNavButtonWithImage:image sel:action];
        
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        [self.navigationItem setRightBarButtonItems:@[negativeSpacer,barItem] animated:YES];
        
        return button;
    }
    else {
        return nil;
    }
}

// 通过自定义视图定义单个按钮
- (void)setRightNavBarItemWithView:(UIView *)view {
    if (view) {
        // 显示导航栏
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        // 隐藏原生返回按钮
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = nav_barItem_horizontalMargin;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        
        [self.navigationItem setRightBarButtonItems:@[negativeSpacer,barButtonItem] animated:YES];
    }
}

// 通过自定义视图数组定义多个按钮
- (void)setRightNavBarItemsWithViews:(NSArray *)views {
    if (views && views.count) {
        // 显示导航栏
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        // 隐藏原生返回按钮
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
        // 生成barButtonItem数组
        NSMutableArray *barButtonItems = [NSMutableArray array];
        
        for (UIView *view in views) {
            if (barButtonItems.count) {
                UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
                spaceBarButtonItem.width = nav_barItem_horizontalSpacing;
                [barButtonItems addObject:spaceBarButtonItem];
            }
            else {
                UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                   target:nil action:nil];
                negativeSpacer.width = nav_barItem_horizontalMargin;
                [barButtonItems addObject:negativeSpacer];
            }
            
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
            [barButtonItems addObject:barButtonItem];
        }
        
        // 添入navgationItem
        [self.navigationItem setRightBarButtonItems:barButtonItems animated:YES];
    }
}

// 自定义titleView
- (void)setNavBarTitleViewWithView:(UIView *)view {
    if (view) {
        // 显示导航栏
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        
        // 隐藏原生返回按钮
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
        self.navigationItem.titleView = view;
    }
}

- (UIButton *)getNavButtonWithString:(NSString *)string sel:(SEL)selector {
    UIFont* titleFont = [UIFont systemFontOfSize:nav_barItem_titleFont];
    CGSize requestedTitleSize = [string sizeWithFont:titleFont];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, requestedTitleSize.width, 44)];
    
    button.titleLabel.font = [UIFont systemFontOfSize:nav_barItem_titleFont];
    
    [button setTitle:string forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setAdjustsImageWhenHighlighted:NO];
    
    return button;
}

- (UIButton *)getNavButtonWithImage:(UIImage *)image sel:(SEL)selector {
    CGRect rect = CGRectZero;
    rect.size = image.size;
    
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    [button setImage:image forState:UIControlStateNormal];
    [button setAdjustsImageWhenHighlighted:NO];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UILabel *)getNavLabelWithString:(NSString *)string {
    CGFloat  titleMaxWidth = 300.0f;
    CGSize   shadowOffset = CGSizeMake(0.0, 2.0);
    
    UIColor *titleColor = [UIColor whiteColor];
    UIColor *titleShadowColor = [UIColor whiteColor];
    UIFont  *titleFont = [UIFont boldSystemFontOfSize:nav_barItem_titleFont];
    
    CGSize requestedTitleSize = [string sizeWithFont:titleFont];
    CGFloat titleWidth = MIN(titleMaxWidth, requestedTitleSize.width);
    
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth + 10, 44)];
    navLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.textColor = titleColor;
    navLabel.font = titleFont;
    navLabel.text = string;
    
    navLabel.layer.shadowColor = titleShadowColor.CGColor;
    navLabel.layer.shadowOffset = shadowOffset;
    navLabel.layer.masksToBounds = NO;
    
    return navLabel;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
