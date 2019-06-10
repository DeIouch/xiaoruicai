//
//  HomePageActivateMachineViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageActivateMachineViewController.h"

@interface HomePageActivateMachineViewController ()

/**
 未激活
 */
@property(nonatomic, strong)UIButton *activateNotButton;

/**
 已激活
 */
@property(nonatomic, strong)UIButton *activatedButton;

/**
 激活中
 */
@property(nonatomic, strong)UIButton *activatingButton;

/**
 激活失败
 */
@property(nonatomic, strong)UIButton *activateFailButton;

/**
 下划线
 */
@property(nonatomic, strong)UIView *lineView;

/**
 未激活
 */
@property(nonatomic, strong)UIViewController *activateNotVC;

/**
 已激活
 */
@property(nonatomic, strong)UIViewController *activatedVC;

/**
 激活中
 */
@property(nonatomic, strong)UIViewController *activatingVC;

/**
 激活失败
 */
@property(nonatomic, strong)UIViewController *activateFailVC;

@property(nonatomic, strong)UIViewController *currentVC;

@end

@implementation HomePageActivateMachineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"激活POS";
    
    [self.activateNotButton addTarget:self action:@selector(activateMatchType:) forControlEvents:UIControlEventTouchUpInside];
    [self.activatedButton addTarget:self action:@selector(activateMatchType:) forControlEvents:UIControlEventTouchUpInside];
    [self.activatingButton addTarget:self action:@selector(activateMatchType:) forControlEvents:UIControlEventTouchUpInside];
    [self.activateFailButton addTarget:self action:@selector(activateMatchType:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addChildViewController:self.activateNotVC];
    
    [self.view addSubview:self.activateNotVC.view];
    [self.activateNotVC didMoveToParentViewController:self];
    self.currentVC = self.activateNotVC;
    [self.activateNotButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.lineView.frame = CGRectMake(40 * self.baseicFloat, 36 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 28 * self.baseicFloat, 2 * self.baseicFloat);
}

-(void)activateMatchType:(UIButton *)button{
    switch (button.tag) {
        case 1:
            {
                if (self.currentVC != self.activateNotVC) {
                    if (self.currentVC == self.activatedVC) {
                        [self.activatedButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.activatingVC) {
                        [self.activatingButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.activateFailVC){
                        [self.activateFailButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.activateNotVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.activateNotVC;
                        [self.activateNotButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.lineView.frame = CGRectMake(40 * self.baseicFloat, 38 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 28 * self.baseicFloat, 2 * self.baseicFloat);
                    }];
                }
            }
            break;
            
        case 2:
            {
                if (self.currentVC != self.activatedVC) {
                    if (self.currentVC == self.activateNotVC) {
                        [self.activateNotButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.activatingVC) {
                        [self.activatingButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.activateFailVC){
                        [self.activateFailButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.activatedVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.activatedVC;
                        [self.activatedButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.lineView.frame = CGRectMake(127 * self.baseicFloat, 38 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 28 * self.baseicFloat, 2 * self.baseicFloat);
                    }];
                }
            }
            break;
            
            
        case 3:
            {
                if (self.currentVC != self.activatingVC) {
                    if (self.currentVC == self.activateNotVC) {
                        [self.activateNotButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.activatedVC) {
                        [self.activatedButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.activateFailVC){
                        [self.activateFailButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.activatingVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.activatingVC;
                        [self.activatingButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.lineView.frame = CGRectMake(214 * self.baseicFloat, 38 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 28 * self.baseicFloat, 2 * self.baseicFloat);
                    }];
                }
            }
            break;
            
            
        case 4:
            {
                if (self.currentVC != self.activateFailVC) {
                    if (self.currentVC == self.activateNotVC) {
                        [self.activateNotButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.activatedVC) {
                        [self.activatedButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.activatingVC){
                        [self.activatingButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.activateFailVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.activateFailVC;
                        [self.activateFailButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.lineView.frame = CGRectMake(306 * self.baseicFloat, 38 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 28 * self.baseicFloat, 2 * self.baseicFloat);
                    }];
                }
            }
            break;
            
            
        default:
            break;
    }
}

-(UIButton *)activateNotButton{
    if (!_activateNotButton) {
        _activateNotButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"未激活", 2, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 21, 80, 65, 15)];
        _activateNotButton.tag = 1;
    }
    return _activateNotButton;
}

-(UIButton *)activatedButton{
    if (!_activatedButton) {
        _activatedButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"激活中", 2, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 108, 80, 65, 15)];
        _activatedButton.tag = 2;
    }
    return _activatedButton;
}

-(UIButton *)activatingButton{
    if (!_activatingButton) {
        _activatingButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"已激活", 2, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 196, 80, 65, 15)];
        _activatingButton.tag = 3;
    }
    return _activatingButton;
}

-(UIButton *)activateFailButton{
    if (!_activateFailButton) {
        _activateFailButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"激活失败", 2, 102, 102, 102, 1, 255, 255, 255, 2, 14, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 288, 80, 65, 15)];
        _activateFailButton.tag = 4;
    }
    return _activateFailButton;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[DelouchView alloc]initView:DelouchViewInfoMake(86, 112, 254, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 40, 102, 28, 2)];
    }
    return _lineView;
}

-(UIViewController *)activateNotVC{
    if (!_activateNotVC) {
        _activateNotVC = [self createVC:@"ActivateNotMatchViewController"];
        _activateNotVC.view.frame = CGRectMake(0, 40 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 40 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
        [self addChildViewController:_activateNotVC];
    }
    return _activateNotVC;
}

-(UIViewController *)activatedVC{
    if (!_activatedVC) {
        _activatedVC = [self createVC:@"ActivatedMatchViewController"];
        _activatedVC.view.frame = CGRectMake(0, 40 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 40 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
        [self addChildViewController:_activatedVC];
    }
    return _activatedVC;
}

-(UIViewController *)activatingVC{
    if (!_activatingVC) {
        _activatingVC = [self createVC:@"ActivatingMatchViewController"];
        _activatingVC.view.frame = CGRectMake(0, 40 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 40 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
        [self addChildViewController:_activatingVC];
    }
    return _activatingVC;
}


-(UIViewController *)activateFailVC{
    if (!_activateFailVC) {
        _activateFailVC = [self createVC:@"ActivateFailMatchViewController"];
        _activateFailVC.view.frame = CGRectMake(0, 40 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 40 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
        [self addChildViewController:_activateFailVC];
    }
    return _activateFailVC;
}

@end
