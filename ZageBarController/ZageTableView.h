//
//  ZageTableView.h
//  ZageBarController
//
//  Created by zhaoyuan on 16/5/2.
//  Copyright © 2016年 赵远. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol pageTableViewDelegate <NSObject>

@required

-(void)didSelectedPageTableView:(NSInteger)index;

@end

@interface ZageTableView : UIView


@property(nonatomic,strong)NSArray *viewControllers;


-(instancetype)initWithFrame:(CGRect)frame andControllerViews:(NSArray *)array;
- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;  


@property(nonatomic,weak)id<pageTableViewDelegate> delegate;





@end
