//
//  ZageBar.m
//  ZageBarController
//
//  Created by zhaoyuan on 16/4/13.
//  Copyright © 2016年 赵远. All rights reserved.
//

#import "ZageBar.h"

#define barBtn_width 75
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define navigationBarColor [UIColor colorWithRed:0.000 green:0.627 blue:0.914 alpha:1.00]

@interface ZageBar()<UIScrollViewDelegate>{
    UIView *line;
    UIScrollView *navTabView;
    CGFloat offsetX;
}

@end

@implementation ZageBar


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        navTabView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
        navTabView.delegate=self;
        [navTabView setShowsVerticalScrollIndicator:NO];
        [navTabView setShowsHorizontalScrollIndicator:NO];
        navTabView.backgroundColor=[UIColor colorWithRed:0.969f green:0.973f blue:0.976f alpha:1.00f];
        
        _titles=@[@"菜单一",@"菜单二",@"菜单三",@"菜单四",@"菜单二",@"菜单三",@"菜单四"];
        
        for (int i=0; i<_titles.count; i++) {
            UIButton *navTabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            navTabBtn.frame = CGRectMake(i*barBtn_width, 0, barBtn_width, 40);
            navTabBtn.tag = 100+i;
            navTabBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
            [navTabBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [navTabBtn setTitleColor:navigationBarColor forState:UIControlStateSelected];
            if (i==0) {
                navTabBtn.selected=YES;
            }
            [navTabBtn setTitle:_titles[i] forState:UIControlStateNormal];
            [navTabBtn addTarget:self action:@selector(OnNavTabBtn:) forControlEvents:UIControlEventTouchUpInside];
            [navTabView addSubview:navTabBtn];
        }
        
        [navTabView setContentSize:CGSizeMake(_titles.count*barBtn_width ,40)];
        line=[[UIView alloc] initWithFrame:CGRectMake(0, 37, screen_width/_titles.count-10, 3)];
        line.backgroundColor=navigationBarColor;
        line.center=CGPointMake(barBtn_width/2,line.center.y);
        [navTabView addSubview:line];
        [self addSubview:navTabView];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeNameNotification:) name:@"postIndexUrlNotification" object:nil];
    }
    return self;
}

-(void)OnNavTabBtn:(UIButton *)sender{
    for (int i = 0; i < _titles.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:100+i];
        btn.selected = NO;
    }
    
    if (sender.center.x>screen_width/2&&(navTabView.contentSize.width-screen_width/2)>sender.center.x) {
        
        [navTabView setContentOffset:CGPointMake(sender.center.x-screen_width/2, 0) animated:YES];
        NSLog(@"%f>%f>%f",navTabView.contentSize.width-screen_width/2,sender.center.x,screen_width/2);
        //此处有坑,类型转换会出现问题
    }
    
    if (sender.center.x<screen_width/2) {
        [navTabView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if (sender.center.x>navTabView.contentSize.width-screen_width/2) {
        [navTabView setContentOffset:CGPointMake(navTabView.contentSize.width-screen_width, 0) animated:YES];
    }
    sender.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        line.center=CGPointMake(sender.center.x,line.center.y);
    }];
    
    [self clickedPageTabBarAtIndex:sender.tag-100];
}


- (void)clickedPageTabBarAtIndex:(NSInteger)index{
    
    if ([_delegate respondsToSelector:@selector(didSelectedBar:)]) {
        [_delegate didSelectedBar:index];
    }
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    offsetX=scrollView.contentOffset.x;
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}



//添加通知
-(void)ChangeNameNotification:(NSNotification*)notification{
    NSDictionary *dir = [notification userInfo];
    NSInteger index=[[dir objectForKey:@"focusIndex"] integerValue];
    
    UIButton *sender=(UIButton *)[self viewWithTag:100+index];
    
    [self OnNavTabBtn:sender];
  

        
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
