//
//  ViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, assign)BOOL isCanUseSideBack;

@property(nonatomic, strong)UIViewController *homePageVC;

@property(nonatomic, strong)UIViewController *cardManageVC;

@property(nonatomic, strong)UIViewController *todayOperationVC;

@property(nonatomic, strong)UIViewController *mineVC;

@property(nonatomic, strong)UIViewController *currentVC;

@property(nonatomic, strong)UIButton *homePageButton;

@property(nonatomic, strong)UIButton *cardManageButton;

@property(nonatomic, strong)UIButton *todayOperationButton;

@property(nonatomic, strong)UIButton *mineButton;

@property(nonatomic, strong)NotVipView *notVipView;

@property(nonatomic, strong)VipOverdueView *vipOverdueView;

@end

@implementation MainViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self cancelSideBack];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self startSideBack];
}

/**
 * 关闭ios右滑返回
 */
-(void)cancelSideBack{
    self.isCanUseSideBack = NO;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate=self;
    }
}

/*
 开启ios右滑返回
 */
- (void)startSideBack {
    self.isCanUseSideBack=YES;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanUseSideBack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.homePageButton addTarget:self action:@selector(vcChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.cardManageButton addTarget:self action:@selector(vcChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.todayOperationButton addTarget:self action:@selector(vcChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.mineButton addTarget:self action:@selector(vcChange:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addChildViewController:self.homePageVC];
    
    [self.view addSubview:self.homePageVC.view];
    [self.homePageVC didMoveToParentViewController:self];
    self.currentVC = self.homePageVC;
    [self.homePageButton setTitleColor:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self.homePageButton setImage:[UIImage imageNamed:icon_Home_selected] forState:UIControlStateNormal];
}

- (void)getFontNames
{
    NSArray *familyNames = [UIFont familyNames];
    
    for (NSString *familyName in familyNames) {
        printf("familyNames = %s\n",[familyName UTF8String]);
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        
        for (NSString *fontName in fontNames) {
            printf("\tfontName = %s\n",[fontName UTF8String]);
        }
    }
}

-(void)vcChange:(UIButton *)button{
    NSInteger buttontag = button.tag;
    switch (buttontag) {
        case 1:
            {
                if (self.currentVC == self.cardManageVC) {
                    [self.cardManageButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.cardManageButton setImage:[UIImage imageNamed:icon_card_unselected] forState:UIControlStateNormal];
                }else if (self.currentVC == self.todayOperationVC) {
                    [self.todayOperationButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.todayOperationButton setImage:[UIImage imageNamed:icon_Operation_unselected] forState:UIControlStateNormal];
                }else if (self.currentVC == self.mineVC){
                    [self.mineButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.mineButton setImage:[UIImage imageNamed:icon_my_unselected] forState:UIControlStateNormal];
                }
                if (self.currentVC != self.homePageVC) {
                    [self transitionFromViewController:self.currentVC toViewController:self.homePageVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.homePageVC;
                        [self.homePageButton setTitleColor:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forState:UIControlStateNormal];
                        [self.homePageButton setImage:[UIImage imageNamed:icon_Home_selected] forState:UIControlStateNormal];
                    }];
                }
            }
            break;
            
        case 2:
            {
                if (self.currentVC == self.homePageVC) {
                    [self.homePageButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.homePageButton setImage:[UIImage imageNamed:icon_Home_unselected] forState:UIControlStateNormal];
                }else if (self.currentVC == self.todayOperationVC) {
                    [self.todayOperationButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.todayOperationButton setImage:[UIImage imageNamed:icon_Operation_unselected] forState:UIControlStateNormal];
                }else if (self.currentVC == self.mineVC) {
                    [self.mineButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.mineButton setImage:[UIImage imageNamed:icon_my_unselected] forState:UIControlStateNormal];
                }
                if (self.currentVC != self.cardManageVC) {
                    [self transitionFromViewController:self.currentVC toViewController:self.cardManageVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.cardManageVC;
                        [self.cardManageButton setTitleColor:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forState:UIControlStateNormal];
                        [self.cardManageButton setImage:[UIImage imageNamed:icon_card_selected] forState:UIControlStateNormal];
                    }];
                }
            }
            break;
            
        case 3:
            {
                if (self.currentVC == self.homePageVC) {
                    [self.homePageButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.homePageButton setImage:[UIImage imageNamed:icon_Home_unselected] forState:UIControlStateNormal];
                }else if (self.currentVC == self.cardManageVC) {
                    [self.cardManageButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.cardManageButton setImage:[UIImage imageNamed:icon_card_unselected] forState:UIControlStateNormal];
                }else if (self.currentVC == self.mineVC) {
                    [self.mineButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.mineButton setImage:[UIImage imageNamed:icon_my_unselected] forState:UIControlStateNormal];
                }
                if (self.currentVC != self.todayOperationVC) {
                    [self transitionFromViewController:self.currentVC toViewController:self.todayOperationVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.todayOperationVC;
                        [self.todayOperationButton setTitleColor:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forState:UIControlStateNormal];
                        [self.todayOperationButton setImage:[UIImage imageNamed:icon_Operation_selected] forState:UIControlStateNormal];
                    }];
                }
            }
            break;
            
        case 4:
            {
                if (self.currentVC == self.homePageVC) {
                    [self.homePageButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.homePageButton setImage:[UIImage imageNamed:icon_Home_unselected] forState:UIControlStateNormal];
                }else if (self.currentVC == self.cardManageVC) {
                    [self.cardManageButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.cardManageButton setImage:[UIImage imageNamed:icon_card_unselected] forState:UIControlStateNormal];
                }else if (self.currentVC == self.todayOperationVC) {
                    [self.todayOperationButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
                    [self.todayOperationButton setImage:[UIImage imageNamed:icon_Operation_unselected] forState:UIControlStateNormal];
                }
                if (self.currentVC != self.mineVC) {
                    [self transitionFromViewController:self.currentVC toViewController:self.mineVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.mineVC;
                        [self.mineButton setTitleColor:[UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1] forState:UIControlStateNormal];
                        [self.mineButton setImage:[UIImage imageNamed:icon_my_selected] forState:UIControlStateNormal];
                    }];
                }
            }
            break;
            
        default:
            break;
    }
}

-(UIButton *)homePageButton{
    if (!_homePageButton) {
        _homePageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, DelouchHeight - DelouchTabbarHeight, DelouchWidth * 0.25, DelouchTabbarHeight)];
        _homePageButton.tag = 1;
        [_homePageButton setTitle:@"首页" forState:UIControlStateNormal];
        [_homePageButton setImage:[UIImage imageNamed:icon_Home_selected] forState:UIControlStateNormal];
        _homePageButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_homePageButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
        [self adjustButtonImageViewUPTitleDownWithButton:_homePageButton];
        [self.view addSubview:_homePageButton];
    }
    return _homePageButton;
}

-(UIButton *)cardManageButton{
    if (!_cardManageButton) {
        _cardManageButton = [[UIButton alloc]initWithFrame:CGRectMake(DelouchWidth * 0.25, DelouchHeight - DelouchTabbarHeight, DelouchWidth * 0.25, DelouchTabbarHeight)];
        _cardManageButton.tag = 2;
        [_cardManageButton setTitle:@"卡片管理" forState:UIControlStateNormal];
        [_cardManageButton setImage:[UIImage imageNamed:icon_card_unselected] forState:UIControlStateNormal];
        _cardManageButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_cardManageButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
        [self adjustButtonImageViewUPTitleDownWithButton:_cardManageButton];
        [self.view addSubview:_cardManageButton];
    }
    return _cardManageButton;
}

-(UIButton *)todayOperationButton{
    if (!_todayOperationButton) {
        _todayOperationButton = [[UIButton alloc]initWithFrame:CGRectMake(DelouchWidth * 0.5, DelouchHeight - DelouchTabbarHeight, DelouchWidth * 0.25, DelouchTabbarHeight)];
        _todayOperationButton.tag = 3;
        [_todayOperationButton setTitle:@"今日操作" forState:UIControlStateNormal];
        [_todayOperationButton setImage:[UIImage imageNamed:icon_Operation_unselected] forState:UIControlStateNormal];
        _todayOperationButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_todayOperationButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
        [self adjustButtonImageViewUPTitleDownWithButton:_todayOperationButton];
        [self.view addSubview:_todayOperationButton];
    }
    return _todayOperationButton;
}

-(UIButton *)mineButton{
    if (!_mineButton) {
        _mineButton = [[UIButton alloc]initWithFrame:CGRectMake(DelouchWidth * 0.75, DelouchHeight - DelouchTabbarHeight, DelouchWidth * 0.25, DelouchTabbarHeight)];
        _mineButton.tag = 4;
        [_mineButton setTitle:@"我的" forState:UIControlStateNormal];
        [_mineButton setImage:[UIImage imageNamed:icon_my_unselected] forState:UIControlStateNormal];
        _mineButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_mineButton setTitleColor:[UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1] forState:UIControlStateNormal];
        [self adjustButtonImageViewUPTitleDownWithButton:_mineButton];
        [self.view addSubview:_mineButton];
    }
    return _mineButton;
}

-(UIViewController *)homePageVC{
    if (!_homePageVC) {
        _homePageVC = [self createVC:@"HomePageViewController"];
        _homePageVC.view.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight - DelouchTabbarHeight);
        [self addChildViewController:_homePageVC];
    }
    return _homePageVC;
}

-(UIViewController *)cardManageVC{
    if (!_cardManageVC) {
        _cardManageVC = [self createVC:@"CardManageViewController"];
        _cardManageVC.view.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight - DelouchTabbarHeight);
        [self addChildViewController:_cardManageVC];
    }
    return _cardManageVC;
}

-(UIViewController *)todayOperationVC{
    if (!_todayOperationVC) {
        _todayOperationVC = [self createVC:@"TodayOperationViewController"];
        _todayOperationVC.view.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight - DelouchTabbarHeight);
        [self addChildViewController:_todayOperationVC];
    }
    return _todayOperationVC;
}

-(UIViewController *)mineVC{
    if (!_mineVC) {
        _mineVC = [self createVC:@"MineViewController"];
        _mineVC.view.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight - DelouchTabbarHeight);
        [self addChildViewController:_mineVC];
    }
    return _mineVC;
}

- (void)adjustButtonImageViewUPTitleDownWithButton:(UIButton *)button {
    [button.superview layoutIfNeeded];
    //使图片和文字居左上角
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    CGFloat buttonHeight = CGRectGetHeight(button.frame);
    CGFloat buttonWidth = CGRectGetWidth(button.frame);

    CGFloat ivHeight = CGRectGetHeight(button.imageView.frame);
    CGFloat ivWidth = CGRectGetWidth(button.imageView.frame);

    CGFloat titleHeight = CGRectGetHeight(button.titleLabel.frame);
    CGFloat titleWidth = CGRectGetWidth(button.titleLabel.frame);
    //调整图片
    float iVOffsetY = buttonHeight / 2.0 - (ivHeight + titleHeight) / 2.0;
    float iVOffsetX = buttonWidth / 2.0 - ivWidth / 2.0;
    [button setImageEdgeInsets:UIEdgeInsetsMake(iVOffsetY, iVOffsetX, 0, 0)];

    //调整文字
    float titleOffsetY = iVOffsetY + CGRectGetHeight(button.imageView.frame) + 3;
    float titleOffsetX = 0;
    if (CGRectGetWidth(button.imageView.frame) >= (CGRectGetWidth(button.frame) / 2.0)) {
        //如果图片的宽度超过或等于button宽度的一半
        titleOffsetX = -(ivWidth + titleWidth - buttonWidth / 2.0 - titleWidth / 2.0);
    }else {
        titleOffsetX = buttonWidth / 2.0 - ivWidth - titleWidth / 2.0;
    }
    [button setTitleEdgeInsets:UIEdgeInsetsMake(titleOffsetY , titleOffsetX, 0, 0)];
}

-(NotVipView *)notVipView{
    if (!_notVipView) {
        _notVipView = [[NotVipView alloc]init];
        [[[UIApplication sharedApplication] keyWindow]addSubview:_notVipView];
        __weak typeof(self) weakSelf = self;
        _notVipView.notVipBlock = ^{
            weakSelf.notVipView.hidden = YES;
        };
    }
    return _notVipView;
}

-(VipOverdueView *)vipOverdueView{
    if (!_vipOverdueView) {
        _vipOverdueView = [[VipOverdueView alloc]init];
        [[[UIApplication sharedApplication] keyWindow]addSubview:_vipOverdueView];
        __weak typeof(self) weakSelf = self;
        _vipOverdueView.vipOverdueBlock = ^{
            weakSelf.vipOverdueView.hidden = YES;
        };
    }
    return _vipOverdueView;
}

@end
