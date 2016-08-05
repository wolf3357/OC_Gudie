//
//  TabbarManager.m
//  ZKe
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 金人网络. All rights reserved.
//

#import "TabbarManager.h"
#import "HomeViewController.h"
#import "LocalViewController.h"
#import "MakeMoneyViewController.h"
#import "SpendMoneyViewController.h"
#import "MineViewController.h"
#import "NavigationController.h"

#define GC_TABBAR_SUB_VIEW_BUTTON_DEFAULT_TAG           80000
@interface TabbarManager()
{
    UIView *_tabBarSubView;
    
}

@property (nonatomic, strong) NSArray *normalImages;
@property (nonatomic, strong) NSArray *selectImages;
@property (nonatomic ,strong)NSMutableArray * titleArray;
@property (nonatomic,strong)NSMutableArray * tidArray;
@end


@implementation TabbarManager
static TabbarManager *_manager = nil;


+(TabbarManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[TabbarManager alloc] init];
    });
    return _manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
        _tabbarController = [[UITabBarController alloc] init];
        
        _tabbarController.viewControllers = [self viewControllers];
        
        [_tabbarController.tabBar addSubview:[self tabBarView]];
        
        
        [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1] Size:_tabbarController.tabBar.bounds.size]];
        [[UITabBar appearance] setShadowImage:[self imageWithColor:[UIColor colorWithRed:236/255.f green:236/255.f blue:236/255.f alpha:1] Size:CGSizeMake([UIApplication sharedApplication].keyWindow.bounds.size.width, 1)]];
        // [UITabBarItem appearance].badgeValue = @"2";
        
        //        [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
        //                                                              [UIColor whiteColor],
        //                                                              UITextAttributeTextColor,
        //                                                              [UIColor clearColor],
        //                                                              UITextAttributeTextShadowColor,
        //                                                              nil]
        //                                                    forState:UIControlStateNormal];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
        UIImage *image = [self imageWithColor:[UIColor colorWithRed:206/255.f green:16/255.f blue:42/255.f alpha:1] Size:CGSizeMake(1, 1)];
        [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:image];
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              [UIColor whiteColor],
                                                              UITextAttributeTextColor,
                                                              [UIColor clearColor],
                                                              UITextAttributeTextShadowColor,
                                                              [UIFont systemFontOfSize:20],UITextAttributeFont,
                                                              nil]];
        //
    }
    return self;
}



-(NSArray *)normalImages
{
    if (!_normalImages) {
        _normalImages = @[@"home_icon",
                          @"home_icon",
                          @"home_icon",
                          @"home_icon",
                          @"home_icon"];
    }
    return _normalImages;
}

-(NSArray *)selectImages
{
    if (!_selectImages) {
        _selectImages = @[@"home_icon_select",
                          @"home_icon_select",
                          @"home_icon_select",
                          @"home_icon_select",
                          @"home_icon_select"];
    }
    return _selectImages;
}

-(NSArray *)viewControllers
{
    HomeViewController * homeVc = [[HomeViewController alloc] init];
    LocalViewController * localvc = [[LocalViewController alloc] init];
    MakeMoneyViewController * makeMoneyvc = [[MakeMoneyViewController alloc] init];
    SpendMoneyViewController * spendvc = [[SpendMoneyViewController alloc] init];
    MineViewController * minevc = [[MineViewController alloc] init];
    
    
    
    NavigationController *hNav = [[NavigationController alloc] initWithRootViewController:homeVc];
    NavigationController *cNav = [[NavigationController alloc] initWithRootViewController:localvc];
    NavigationController *eNav = [[NavigationController alloc] initWithRootViewController:makeMoneyvc];
    NavigationController *bNav = [[NavigationController alloc] initWithRootViewController:spendvc];
    NavigationController *mNav = [[NavigationController alloc] initWithRootViewController:minevc];
    return @[hNav,cNav,eNav,bNav,mNav];
}



#define BUTTONLABELTAG                          10000
#define BUTTONIMAGEVIEWTAG                      10001
#define BUTTONTITLENORMALTITLECOLOR             [UIColor colorWithRed:107/255.f green:107/255.f blue:107/255.f alpha:1]
#define BUTTONTITLESELECTEDTITLECOLOR           [UIColor colorWithRed:206/255.f green:16/255.f blue:42/255.f alpha:1]


-(UIView *)tabBarView
{
    CGRect frame = _tabbarController.tabBar.bounds;
    
    _tabBarSubView = [[UIView alloc] initWithFrame:frame];
    _tabBarSubView.backgroundColor = [UIColor clearColor];
    
    NSArray *titleArray = @[@"首页",@"本地",@"赚呗",@"花呗",@"我的"];
    
    int total = (int)MIN(MIN(self.normalImages.count, self.selectImages.count),titleArray.count);
    
    int iconWith = frame.size.width / total;
    int iconHeight = frame.size.height;
    
    for (int i = 0; i< total; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * iconWith, 0, iconWith, iconHeight)];
        [button setTag:GC_TABBAR_SUB_VIEW_BUTTON_DEFAULT_TAG + i];
        [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarSubView addSubview:button];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((iconWith - 25) / 2, 5, 25, 25)];
        imageView.image = [UIImage imageNamed:self.normalImages[i]];
        imageView.tag = BUTTONIMAGEVIEWTAG;
        [button addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, iconWith, 15)];
        [label setFont:[UIFont systemFontOfSize:11]];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titleArray[i];
        label.tag = BUTTONLABELTAG;
        [label setTextColor:BUTTONTITLENORMALTITLECOLOR];
        //label.textColor = BUTTONTITLESELECTEDTITLECOLOR;
        [button addSubview:label];
    
    }
    [self tabBarSelectButtonWithIndex:0];
    
    return _tabBarSubView;
}

-(void)tabBarSelectButtonWithIndex:(NSUInteger)index
{
    [self tabBarButtonClick:(UIButton *)[_tabBarSubView viewWithTag:index + GC_TABBAR_SUB_VIEW_BUTTON_DEFAULT_TAG]];
}

-(void)tabBarButtonClick:(UIButton *)aButton
{
    for (UIView *view in _tabBarSubView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (button == aButton && button.selected) {
                return;
            }else{
                button.selected = NO;
                button.userInteractionEnabled = YES;
                
                ((UILabel *)[button viewWithTag:BUTTONLABELTAG]).textColor = BUTTONTITLENORMALTITLECOLOR;
                ((UIImageView *)[button viewWithTag:BUTTONIMAGEVIEWTAG]).image = [UIImage imageNamed:self.normalImages[button.tag - GC_TABBAR_SUB_VIEW_BUTTON_DEFAULT_TAG]];
            }
        }
    }
    aButton.selected = YES;
    aButton.userInteractionEnabled = NO;
    ((UILabel *)[aButton viewWithTag:BUTTONLABELTAG]).textColor = BUTTONTITLESELECTEDTITLECOLOR;
    ((UIImageView *)[aButton viewWithTag:BUTTONIMAGEVIEWTAG]).image = [UIImage imageNamed:self.selectImages[aButton.tag - GC_TABBAR_SUB_VIEW_BUTTON_DEFAULT_TAG]];
    
    if(self.tabbarController){
        self.tabbarController.selectedIndex = aButton.tag - GC_TABBAR_SUB_VIEW_BUTTON_DEFAULT_TAG;
    }else{
        NSLog(@"123123123213123124124124");
    }
}



#pragma mark - 颜色 to 图片
- (UIImage *)imageWithColor:(UIColor *)aColor Size:(CGSize)aSize
{
    CGRect aFrame = CGRectMake(0, 0, aSize.width, aSize.height);
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
