//
//  BaseViewController.h
//  UINavigation-Paging
//
//  Created by Cyfuer on 16/4/14.
//  Copyright © 2016年 Cyfuer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

#pragma mark  -  导航栏 ( 7.0 ~ 9.3 )

// 隐藏导航栏
- (void)hideNav;

// 显示导航栏
- (void)showNav;

// 设置自定义的返回按钮
- (void)setBackBtn;

// 设置导航栏名称
- (void)setTitle:(NSString *)title;


// 左侧：通过名称自定义单个按钮
- (UIButton *)setLeftNavBarItemWithTitle:(NSString *)title action:(SEL)action;

// 左侧：通过图片自定义单个按钮
- (UIButton *)setLeftNavBarItemWithImage:(UIImage *)image action:(SEL)action;

// 左侧：通过自定义视图定义单个按钮
- (void)setLeftNavBarItemWithView:(UIView *)view;

// 左侧：通过自定义视图数组定义多个按钮
- (void)setLeftNavBarItemsWithViews:(NSArray *)views;


// 右侧：通过名称自定义单个按钮
- (UIButton *)setRightNavBarItemWithTitle:(NSString *)title action:(SEL)action;

// 右侧：通过图片自定义单个按钮
- (UIButton *)setRightNavBarItemWithImage:(UIImage *)image action:(SEL)action;

// 右侧：通过自定义视图定义单个按钮
- (void)setRightNavBarItemWithView:(UIView *)view;

// 右侧：通过自定义视图数组定义多个按钮
- (void)setRightNavBarItemsWithViews:(NSArray *)views;


// 自定义titleView
- (void)setNavBarTitleViewWithView:(UIView *)view;

@end
