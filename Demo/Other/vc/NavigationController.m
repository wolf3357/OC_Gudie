//
//  NavigationController.m
//  ZKe
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 金人网络. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count == 2) {
        [((UIViewController *)[self.viewControllers firstObject]) setHidesBottomBarWhenPushed:NO];
    }
    return [super popViewControllerAnimated:YES];
}

-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    [((UIViewController *)[self.viewControllers firstObject]) setHidesBottomBarWhenPushed:NO];
    
    return [super popToRootViewControllerAnimated:animated];
}




@end
