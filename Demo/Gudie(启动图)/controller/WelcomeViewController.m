//
//  WelcomeViewController.m
//  ZKe
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 金人网络. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UIPageControl * pageControl;
@property (nonatomic,strong)UIButton * startButton;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏状态栏
    if([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]){
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    //判断是否是第一次启动
    BOOL isFirstLaunch = [self isFirstLaunch];
    if (isFirstLaunch) {
        [self setScrollViewUp];
    }else{
        [self setAdvertisView];
    }
    
}

-(BOOL)prefersStatusBarHidden{
    return  YES;
}

//自动跳转
-(void)createCountdown{
    double countdown = 3;
    dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, countdown *NSEC_PER_SEC);
    dispatch_after(poptime, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0 animations:^{
            self.view.alpha = 0.00;
            self.view.backgroundColor = [UIColor grayColor];
        } completion:^(BOOL finished) {
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SQChangeDefaultNotification" object:nil];
        }];
    });
}

//当不是第一次启动时
-(void)setAdvertisView{
    UIView * view = [[UIView alloc]initWithFrame:self.view.frame];
    [self.view addSubview: view];
    
    view.backgroundColor = [UIColor grayColor];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    button.center= CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-100) ;
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"button" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(clickBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:button];
    
    [self createCountdown];
}


//第一次启动时
-(void)setScrollViewUp{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.backgroundColor= [UIColor orangeColor];
    NSArray * array = @[@"_firstLable",@"_secondLable",@"_thirdLable",@"_fourLable",@"_fiveLable"];
    
    for (NSInteger i = 0 ; i<5; i++) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        view.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.f green:arc4random()%255/256.f blue:arc4random()%255/256.f alpha:1];
        [_scrollView addSubview:view];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        label.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        label.text = array[i];
        label.textColor = [UIColor grayColor];
        label.backgroundColor =[UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
        if (i == 4) {
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
            button.center= CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-100) ;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:@"button" forState:(UIControlStateNormal)];
            [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [button addTarget:self action:@selector(clickBtn) forControlEvents:(UIControlEventTouchUpInside)];
            [view addSubview:button];
        }
    }
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, self.view.frame.size.height);
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate  = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:self.scrollView];
    
}

-(void)clickBtn{
    NSLog(@"btn");
    
    static  dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        [UIView animateWithDuration:1.0 animations:^{
            self.view.alpha = 0.00;
            self.view.backgroundColor = [UIColor grayColor];
        } completion:^(BOOL finished) {
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SQChangeDefaultNotification" object:nil];
        }];
    });
}

#pragma mark - 应用是否为第一次启动
- (BOOL)isFirstLaunch
{
    NSString *versionKey = (NSString *)kCFBundleVersionKey;
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
    NSString *currentVersion =[[[NSBundle mainBundle] infoDictionary] objectForKey:versionKey];
    if ([lastVersion isEqualToString:currentVersion])
    {
        return NO;
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
