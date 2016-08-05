//
//  TabbarManager.h
//  ZKe
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 金人网络. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@interface TabbarManager : NSObject
@property (nonatomic, strong, readonly) UITabBarController *tabbarController;
@property (nonatomic,strong)UIView * badgeView ;

+(TabbarManager *)sharedManager;

-(void)tabBarSelectButtonWithIndex:(NSUInteger)index;
@end
