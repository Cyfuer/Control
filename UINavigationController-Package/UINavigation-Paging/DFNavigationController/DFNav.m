//
//  DFNav.m
//  UINavigation-Paging
//
//  Created by Cyfuer on 16/5/31.
//  Copyright © 2016年 Cyfuer. All rights reserved.
//

#import "DFNav.h"

@interface DFNav () <UIGestureRecognizerDelegate>

@end

@implementation DFNav

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //如果当前显示的是第一个子控制器就禁止使用[返回按钮]
    if(self.childViewControllers.count == 1){
        return NO;
    }
    
    return YES;
    
    // 这句话等于上面2句
    // return self.childViewControllers.count > 1;
}

@end
