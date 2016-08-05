//
//  TabBarViewController.m
//  ZKe
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 金人网络. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "LocalViewController.h"
#import "MakeMoneyViewController.h"
#import "SpendMoneyViewController.h"
#import "MineViewController.h"
#import "NavigationController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  SetupAllControllers];
}

- (void)SetupAllControllers{
    NSArray *titles = @[@"首页", @"本地", @"赚呗", @"花呗",@"我的"];
    NSArray *images = @[@"home_icon1",@"home_icon1",@"home_icon1",@"home_icon1",@"home_icon1"];
    NSArray *selectedImages = @[@"home_icon_select1",@"home_icon_select1",@"home_icon_select1",@"home_icon_select1",@"home_icon_select1"];
    
    HomeViewController * homeVc = [[HomeViewController alloc] init];
    LocalViewController * localvc = [[LocalViewController alloc] init];
    MakeMoneyViewController * makeMoneyvc = [[MakeMoneyViewController alloc] init];
    SpendMoneyViewController * spendvc = [[SpendMoneyViewController alloc] init];
    MineViewController * minevc = [[MineViewController alloc] init];
    
    NSArray *viewControllers = @[homeVc, localvc, makeMoneyvc, spendvc,minevc];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}


- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.title = title;
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
