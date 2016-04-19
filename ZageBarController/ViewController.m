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
#import "ZageBar.h"



@interface ViewController()<UITableViewDataSource,UITableViewDelegate,selectedBarDelegate>

@property (strong,nonatomic)UITableView *tableView;


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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_height - 64, screen_width)];
    self.tableView.center = CGPointMake(screen_width * 0.5, screen_height * 0.5+(64+40)*0.5);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.pagingEnabled = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
    exampleViewController* VC  = [[exampleViewController alloc] init];
    VC.view.backgroundColor=[UIColor grayColor];
    exampleViewController* VC1  = [[exampleViewController alloc] init];
    VC1.view.backgroundColor=[UIColor yellowColor];
    _viewControllers=@[VC,VC1];
    [self.tableView reloadData];
    
    ZageBar *_view=[[ZageBar alloc] initWithFrame:CGRectMake(0, 64, screen_width, 40)];
    _view.backgroundColor=navigationBarColor;
    _view.delegate=self;
    _view.titles=@[@"菜单一",@"菜单二",@"菜单三",@"菜单四",@"菜单二",@"菜单三",@"菜单四"];
    [self.view addSubview:_view];    
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if (indexPath.row%2==0) {
        cell.backgroundColor=[UIColor greenColor];
    }
    
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIViewController *controller = _viewControllers[indexPath.row];
    controller.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:controller.view];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Height retrun the width of screen
    return CGRectGetWidth(self.view.frame);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat screenWidth=self.view.frame.size.width;
    CGFloat horizonalOffset = self.tableView.contentOffset.y;
    
//    CGFloat offsetRatio = (NSUInteger)horizonalOffset % (NSUInteger)screenWidth / screenWidth;
//    NSUInteger focusIndex = (horizonalOffset + screenWidth / 2) / screenWidth;
//    
//    if (offsetRatio==0) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"postIndexUrlNotification"
//                                                            object:self
//                                                          userInfo:@{@"focusIndex":@(focusIndex)}];
//    }
//     
//    [self didScrolldPagAtIndex:focusIndex];


}

- (void)didScrolldPagAtIndex:(NSInteger)index{
    
    if ([_delegate respondsToSelector:@selector(didScrolldPage:)]) {
        [_delegate didScrolldPage:index];
    }
    
}


#pragma mark - ZageBarDelegate
-(void)didSelectedBar:(NSInteger)index{
    [self.tableView setContentOffset:CGPointMake(0, index*screen_width) animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

