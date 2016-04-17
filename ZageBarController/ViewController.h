//
//  ViewController.h
//  ZageBarController
//
//  Created by zhaoyuan on 16/4/12.
//  Copyright © 2016年 赵远. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol pageBarDelegate <NSObject>

@required

-(void)didScrolldPage:(NSInteger)index;

@end

@interface ViewController : UIViewController


@property(nonatomic,strong)NSArray *viewControllers;

@property(nonatomic,weak)id<pageBarDelegate> delegate;


@property (nonatomic, copy) void (^changeIndex)(NSUInteger index);


@end

