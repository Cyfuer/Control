//
//  ViewController.m
//  UINavigation-Paging
//
//  Created by Cyfuer on 16/4/14.
//  Copyright © 2016年 Cyfuer. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *tableData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    tableData = @[
                  // 1.原生返回按钮的控制比较方便，在当前控制器随便什么地方想隐藏就隐藏，想显示就显示
                  @"1.原生返回按钮的控制",
                  
                  // 2.添加左侧按钮时原生返回按钮会被覆盖掉，所以不用担心返回按钮的显示
                  @"2.自定义左侧按钮",
                  
                  // 3.不管自定义的视图height有多高，视图的center的y的值都是 （状态栏20 + 导航栏中点22）
                  @"3.自定义左侧视图",
                  
                  // 4.根据视图数组从左往右依次添加
                  @"4.自定义多个左侧视图",
                  
                  // 5.titleView的 center.x 是导航栏的中点，center.y 是 44（状态栏20 + 导航栏中点22）
                  @"5.自定义titleview",
                  
                  // 6.
                  @"6.自定义右侧按钮",
                  
                  // 7.
                  @"7.自定义右侧视图",
                  
                  // 8.根据视图数组从右往左依次添加
                  @"8.自定义多个右侧视图",
                  
                  // 9.动画显示prompt文字，导航栏高度变高，在title的上面显示prompt，如果想要隐藏，必须设prompt为nil
                  @"9.prompt",
                  
                  // 10.后添加的会把前面的覆盖掉，都是在同一个navigationItem，它只有三个位置：leftBarButtonItems、rightBarButtonItems、titleView，就像小轿车一样，一个座位被另一人占了，前一个人就没座位得滚下车了
                  @"10.重复自定义左侧按钮",
                  
                  // 11.根据图片大小生成对应大小的按钮
                  @"11.自定义左侧图片按钮",
                  
                  // 12.想怎么藏怎么藏，但存在一种特例，界面A不显示导航栏，跳转到B后显示了导航栏，返回回来的时候得记得隐藏
                  @"12.导航栏显示隐藏的控制",
                  
                  // 13.translucent 为 YES 时有半透明效果
                  @"13.导航栏背景色",
                  
                  // 14.默认返回按钮被覆盖了
                  @"14.不隐藏默认返回按钮时添加自定义左侧按钮",
                  
                  // 15.视图A跳转至视图B时，A的导航栏的设置会自动清空
                  @"15.连续两层视图的修改会互相影响吗？不会",
                  
                  // 16.也是会被覆盖掉的，一个萝卜一个坑，不管是左侧按钮还是左侧自定义视图，都需要leftBarButtonItems这个坑，但只能坐一个
                  @"16.自定义左侧按钮自定义左侧视图列表"
                  ];
    switch (self.type) {
        case 0:
        {
            CGRect rect = self.view.bounds;
            rect.size.height -= 64;
            
            self.navigationController.navigationBar.translucent = YES;
            UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds];
            table.delegate = self;
            table.dataSource = self;
            [self.view addSubview:table];
        }
            break;
        case 1://原生返回按钮的控制
        {
            [self.navigationItem setHidesBackButton:YES animated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationItem setHidesBackButton:NO animated:YES];
            });
        }
            break;
        case 2:// 自定义左侧按钮
        {
            [self setLeftNavBarItemWithTitle:@"返回" action:@selector(back)];
            
            [self setBackButton];
        }
            break;
        case 3:// 自定义左侧视图
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 64)];
            view.backgroundColor = [UIColor orangeColor];
            
            [self setLeftNavBarItemWithView:view];
            
            [self setBackButton];
        }
            break;
        case 4:// 自定义多个左侧视图
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            view.backgroundColor = [UIColor cyanColor];
            
            UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            view0.backgroundColor = [UIColor purpleColor];
            
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            view1.backgroundColor = [UIColor orangeColor];
            
            [self setLeftNavBarItemsWithViews:@[view,view0,view1]];
            
            [self setBackButton];
        }
            break;
        case 5:// 自定义titleview
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            view.backgroundColor = [UIColor redColor];
            
            [self setNavBarTitleViewWithView:view];
            
            [self setBackButton];
        }
            break;
            
        case 6:// 自定义右侧按钮
        {
            [self setRightNavBarItemWithTitle:@"右侧" action:@selector(back)];
        }
            break;
            
        case 7:// 自定义右侧视图
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
            view.backgroundColor = [UIColor cyanColor];
            
            [self setRightNavBarItemWithView:view];
            
            [self setBackButton];
        }
            break;
            
        case 8:// 自定义多个右侧视图
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            view.backgroundColor = [UIColor cyanColor];
            
            UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            view0.backgroundColor = [UIColor brownColor];
            
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
            view1.backgroundColor = [UIColor greenColor];
            
            [self setRightNavBarItemsWithViews:@[view,view0,view1]];
            
            self.navigationItem.prompt = @"dfashdaia";
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.navigationItem.prompt = nil;
            });
            
            [self setBackButton];
        }
            break;
            
        case 9://prompt
        {
            self.navigationItem.prompt = @"dfashdaia";
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.navigationItem.prompt = nil;
            });
            self.title = @"prompt";
        }
            break;
        case 10://重复自定义左侧按钮
        {
            [self setLeftNavBarItemWithTitle:@"aaaaa" action:@selector(back)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self setLeftNavBarItemWithTitle:@"bbbbbb" action:@selector(back)];
            });
        }
            break;
        case 11://自定义左侧图片按钮
        {
            [self setLeftNavBarItemWithImage:[UIImage imageNamed:@"closeButton"] action:@selector(back)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self setLeftNavBarItemWithImage:[UIImage imageNamed:@"goodsDetail_fanhui"] action:@selector(back)];
            });
        }
            break;
        case 12://导航栏显示隐藏的控制
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController setNavigationBarHidden:YES animated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController setNavigationBarHidden:NO animated:YES];
                });
            });
        }
            break;
        case 13://导航栏背景色
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.navigationController.navigationBar.translucent = YES;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationController.navigationBar.translucent = NO;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
                        });
                    });
                });
            });
        }
            break;
        case 14://不隐藏默认返回按钮时添加自定义左侧按钮
        {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = 0;
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
            button.backgroundColor = [UIColor clearColor];
            
            UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
            
            [self.navigationItem setLeftBarButtonItems:@[negativeSpacer,barItem] animated:YES];
        }
            break;
            
        case 15:// 进入第一层自定义视图
        {
            [self setLeftNavBarItemWithTitle:@"aaaaa" action:@selector(back)];
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
            [button setTitle:@"返回" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(goSecondVC) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
            break;
            
        case 16://自定义左侧按钮在自定义左侧视图列表
        {
            [self setRightNavBarItemWithTitle:@"back" action:@selector(back)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
                view.backgroundColor = [UIColor cyanColor];
                
                UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
                view0.backgroundColor = [UIColor cyanColor];
                
                UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
                view1.backgroundColor = [UIColor cyanColor];
                
                [self setRightNavBarItemsWithViews:@[view,view0,view1]];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self setRightNavBarItemWithTitle:@"back" action:@selector(back)];
                });
            });
        }
            break;
        case 150:// 进入第二层自定义视图
        {
            [self setRightNavBarItemWithTitle:@"bbbbbb" action:@selector(back)];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Private

- (void)setBackButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)goSecondVC {
    ViewController *vc = [ViewController new];
    vc.type = 150;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = tableData[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewController *vc = [ViewController new];
    vc.type = indexPath.row + 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
