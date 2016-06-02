//
//  ViewController.h
//  UINavigation-Paging
//
//  Created by Cyfuer on 16/4/14.
//  Copyright © 2016年 Cyfuer. All rights reserved.
//

/*
 *  基于原生导航栏的封装：
        基于原生导航栏的封装就是通过ViewController的navigationItem属性（指向导航栏控制器的navigationItem）自定义导航栏子控件
    同时依据navigationController属性控制导航栏的背景色、显示隐藏等
 *  优点:
        1.不用担心导航栏会被挡住的情况
        2.self.view会自动根据导航栏的显示隐藏调整自己的bounds，可以不用担心导航栏的适配
        3.比起自己写的，确实好看点。。
 
 *  Tag:
 
        translucent：
                当 self.navigationController.navigationBar.translucent = YES 时导航栏有磨砂效果，可以模糊看到下面的视图
                当 self.navigationController.navigationBar.translucent = NO 时导航栏就像普通view一样
 
        原生导航栏显示时内容视图的适配：
                当 self.navigationController.navigationBar.translucent = YES 时,同时self.automaticallyAdjustsScrollViewInsets = YES 时,  以self.view.bounds为frame适配了，底部没有因为导航栏的出现而被遮挡64个像素
                当 self.navigationController.navigationBar.translucent = NO 时以self.view.bounds为frame适配了，底部会被遮挡64个像素
 
        导航栏中的视图排版： 
                添加到导航栏的自定义视图全部以导航栏的44像素部分水平方向的中线对齐
 */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ViewController : BaseViewController

@property (assign, nonatomic) NSInteger type;


@end

