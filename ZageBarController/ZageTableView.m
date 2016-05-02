//
//  ZageTableView.m
//  ZageBarController
//
//  Created by zhaoyuan on 16/5/2.
//  Copyright © 2016年 赵远. All rights reserved.
//

#import "ZageTableView.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define navigationBarColor [UIColor colorWithRed:0.000 green:0.627 blue:0.914 alpha:1.00]

@interface ZageTableView()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic)UITableView *tableView;

@end

@implementation ZageTableView


-(instancetype)initWithFrame:(CGRect)frame andControllerViews:(NSArray *)array{
    
    if (self = [super initWithFrame:frame]) {
        _viewControllers=array;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.width)];
        self.tableView.center = CGPointMake(screen_width * 0.5, self.frame.size.height * 0.5);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.pagingEnabled = YES;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.bounces = NO;
        [self addSubview:self.tableView];
        
    }
    
    return self;

}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated{
    [self.tableView setContentOffset:contentOffset animated:animated];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewControllers.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetWidth(self.frame);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIViewController *controller = _viewControllers[indexPath.row];
    controller.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:controller.view];
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat screenWidth=self.frame.size.width;
    CGFloat horizonalOffset = self.tableView.contentOffset.y;

    CGFloat offsetRatio = (NSUInteger)horizonalOffset % (NSUInteger)screenWidth / screenWidth;
    NSUInteger focusIndex = (horizonalOffset + screenWidth / 2) / screenWidth;

    if (offsetRatio==0) {
        [self clickedPageTableViewAtIndex:focusIndex];
    }


}


- (void)clickedPageTableViewAtIndex:(NSInteger)index{
    
    if ([_delegate respondsToSelector:@selector(didSelectedPageTableView:)]) {
        [_delegate didSelectedPageTableView:index];
    }
    
}




@end
