//
//  ZageBar.h
//  ZageBarController
//
//  Created by zhaoyuan on 16/4/13.
//  Copyright © 2016年 赵远. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol selectedBarDelegate <NSObject>

@required

-(void)didSelectedBar:(NSInteger)index;

@end

@interface ZageBar : UIView


@property(nonatomic,strong)NSArray *titles;

@property(nonatomic,readonly)NSInteger selecttedIndex;


@property(nonatomic,weak)id<selectedBarDelegate> delegate;


-(instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)array;
-(void)didChangeZageBar:(NSInteger)index;





@end
