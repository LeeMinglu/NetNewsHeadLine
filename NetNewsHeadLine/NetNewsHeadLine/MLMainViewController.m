//
//  MLMainViewController.m
//  NetNewsHeadLine
//
//  Created by 李明禄 on 15/11/22.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLMainViewController.h"
#import "MLHeadLineViewController.h"

@interface MLMainViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@end

@implementation MLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setupChildVCes];
    
    
    //设置标题
    [self setupTitles];
    
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
    CGFloat labelW = 80;
    CGFloat labelH = 30;
    
    for (NSUInteger i = 0 ; i < count; i++) {
        UILabel *label = [[UILabel alloc] init];
        
        CGFloat labelX = i * labelW;
        NSLog(@"%f",labelX);
        //设置frame
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        [self.titleScrollView addSubview:label];
        
        UIViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
        NSLog(@"%@",label.text);
        
    }
    
    //设置ScrollView的contentsize
    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
