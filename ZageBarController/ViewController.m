//
//  ViewController.m
//  ZageBarController
//
//  Created by zhaoyuan on 16/4/12.
//  Copyright © 2016年 赵远. All rights reserved.
//

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define navigationBarColor [UIColor colorWithRed:0.000 green:0.627 blue:0.914 alpha:1.00]

#import "exampleViewController.h"

#import "ViewController.h"

#import "ZageTableView.h"
#import "ZageBar.h"

@interface ViewController()<selectedBarDelegate,pageTableViewDelegate>{
    
    ZageBar *_view;
    ZageTableView *_tableView;
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavView];
    [self setupTableView];
    
}

- (void)setupNavView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor=navigationBarColor;
    [self.view addSubview:backView];
    UILabel *navTitle=[[UILabel alloc] init];
    navTitle.frame=CGRectMake(screen_width/2-100, 30, 200, 25);
    navTitle.text=@"ZageBarController";
    navTitle.textAlignment=1;
    navTitle.textColor=[UIColor whiteColor];
    navTitle.font = [UIFont boldSystemFontOfSize:17.0f];
    [backView addSubview:navTitle];
}

- (void)setupTableView {
    
    _view=[[ZageBar alloc] initWithFrame:CGRectMake(0, 64, screen_width, 40) andTitles:@[@"菜单一",@"菜单二",@"菜单三",@"菜单四",@"菜单三",@"菜单四"]];
    _view.backgroundColor=navigationBarColor;
    _view.delegate=self;
    [self.view addSubview:_view];
    
    exampleViewController* VC  = [[exampleViewController alloc] init];
    VC.view.backgroundColor=[UIColor grayColor];
    exampleViewController* VC1  = [[exampleViewController alloc] init];
    VC1.view.backgroundColor=[UIColor yellowColor];
    
    _tableView=[[ZageTableView alloc] initWithFrame:CGRectMake(0, 104, screen_width, screen_height - 104) andControllerViews:@[VC,VC1,VC,VC1,VC,VC1]];
    _tableView.delegate=self;

    _tableView.backgroundColor=navigationBarColor;
    [self.view addSubview:_tableView];
    
}


#pragma mark - ZageTableViewDelegate
-(void)didSelectedPageTableView:(NSInteger)index{
    [_view didChangeZageBar:index];
}

#pragma mark - ZageBarDelegate
-(void)didSelectedBar:(NSInteger)index{
    [_tableView setContentOffset:CGPointMake(0, index*screen_width) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

