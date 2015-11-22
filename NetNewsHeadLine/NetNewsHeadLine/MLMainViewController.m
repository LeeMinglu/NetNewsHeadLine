//
//  MLMainViewController.m
//  NetNewsHeadLine
//
//  Created by 李明禄 on 15/11/22.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLMainViewController.h"
#import "MLHeadLineViewController.h"
#import "MLHomeLabel.h"

@interface MLMainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@end

@implementation MLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    
    
    //添加子控制器
    [self setupChildVCes];
    
    
    //设置标题
    [self setupTitles];
    
    //设置contentScrollView的滚动范围
    CGFloat contentScrollWidth = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.contentScrollView.contentSize = CGSizeMake(contentScrollWidth, 0);
    
    MLHomeLabel *label = self.titleScrollView.subviews.firstObject;
    label.scale = 1.0;
    
    
    //添加默认控制器
    MLHeadLineViewController *defaultVC = self.childViewControllers.firstObject;
    
    defaultVC.view.frame = self.contentScrollView.bounds;
    
    [self.contentScrollView addSubview:defaultVC.view];
    
}

- (void)setupChildVCes {
    
    MLHeadLineViewController *vc1 = [[MLHeadLineViewController alloc] init];
    vc1.title = @"测试1";
    [self addChildViewController:vc1];
    
    MLHeadLineViewController *vc2 = [[MLHeadLineViewController alloc] init];
    vc2.title = @"测试2";
    [self addChildViewController:vc2];
    
    MLHeadLineViewController *vc3 = [[MLHeadLineViewController alloc] init];
    vc3.title = @"测试3";
    [self addChildViewController:vc3];
    
    MLHeadLineViewController *vc4 = [[MLHeadLineViewController alloc] init];
    vc4.title = @"测试4";
    [self addChildViewController:vc4];

    
    MLHeadLineViewController *vc5 = [[MLHeadLineViewController alloc] init];
    vc5.title = @"测试5";
    [self addChildViewController:vc5];
    
    MLHeadLineViewController *vc6 = [[MLHeadLineViewController alloc] init];
    vc6.title = @"测试6";
    [self addChildViewController:vc6];
    
}

- (void)setupTitles {
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat labelY = 0;
    CGFloat labelW = 120;
    CGFloat labelH = 30;
    
    for (NSUInteger i = 0 ; i < count; i++) {
        MLHomeLabel *label = [[MLHomeLabel alloc] init];
        
        CGFloat labelX = i * labelW;
//        NSLog(@"%f",labelX);
        //设置frame
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        [self.titleScrollView addSubview:label];
        
        UIViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
//        NSLog(@"%@",label.text);
        
        //添加点击label的手势方法
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLabel:)]];
        
        label.tag = i;
        
        
    }
    
    //设置ScrollView的contentsize
    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
}

//实现手势的方法
- (void)clickLabel:(UITapGestureRecognizer *)recognizer {
//    NSLog(@"%@", recognizer.view);
    //获取点击了第几个label
    MLHomeLabel *label = (MLHomeLabel *)recognizer.view;
    
    //计算label的偏移量
    CGFloat offSetX = label.tag * self.contentScrollView.frame.size.width;
    
//    设置contentScrollView的偏移量
    [self.contentScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
}


#pragma mark 实现scrollView的代理方法

//当滚动结束时执行的运作,当点击标题后contentView才能看到界面数据,是因为系统的View使用了懒加载.
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat contentScrollViewWidth = scrollView.frame.size.width;
    //获取当前要显示控制器的索引
    NSUInteger index = scrollView.contentOffset.x / contentScrollViewWidth;

    
    //滚动标题栏
    MLHomeLabel *label = self.titleScrollView.subviews[index];
    
    //设置frame
    CGFloat width = self.titleScrollView.frame.size.width;
    //计算偏移量
    CGFloat offSetX = label.center.x - width * 0.5;
    
    //最大偏移量
    CGFloat maxOffSetX = self.titleScrollView.contentSize.width - width;
    
    if (offSetX < 0) {
        offSetX = 0;
    }else if (offSetX > maxOffSetX) {
        offSetX = maxOffSetX;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    
    [self.titleScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index != idx) {
            MLHomeLabel *label = self.titleScrollView.subviews[idx];
            label.scale = 0.0;
        }
    }];
    
    
//    获得控制器
    UIViewController *vc = self.childViewControllers[index];
    
    //如果contentScollView中有内容说明在这个view已经存在了,直接返回.
    if (vc.view.superview) return;
    
    CGFloat vcH = scrollView.frame.size.height;
    CGFloat vcW = scrollView.frame.size.width;
    CGFloat vcY = 0;
    CGFloat vcX = index * vcW;
    vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
    
    [self.contentScrollView addSubview:vc.view];
}

//用户拖动contentView结束的时候执行的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];

}

//scrollView滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //左右标题的索引
    NSUInteger leftIndex = (NSUInteger)(value);
    NSUInteger rightIndex = leftIndex + 1;
    
    //右边文字比例
    CGFloat rightScale = value - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    
    MLHomeLabel *LeftLabel = self.titleScrollView.subviews[leftIndex];
    
    LeftLabel.scale = leftScale;
    
    if (rightIndex < self.titleScrollView.subviews.count) {
        MLHomeLabel *rightLabel = self.titleScrollView.subviews[rightIndex];
        rightLabel.scale = rightScale;
    }
    
}


@end
