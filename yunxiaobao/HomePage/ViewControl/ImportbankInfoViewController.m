//
//  ImportbankInfoViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ImportbankInfoViewController.h"

@interface ImportbankInfoViewController ()

/**
 信用卡登陆
 */
@property(nonatomic, strong)UIButton *creditCardLoginButton;

/**
 手机号登陆
 */
@property(nonatomic, strong)UIButton *phoneLoginButton;

/**
 身份证登陆
 */
@property(nonatomic, strong)UIButton *idNumberLoginButton;

/**
 用户名登陆
 */
@property(nonatomic, strong)UIButton *nameLoginButton;

/**
 下划线
 */
@property(nonatomic, strong)UIView *lineView;

/**
 信用卡登陆
 */
@property(nonatomic, strong)UIViewController *creditCardLoginVC;

/**
 手机号登陆
 */
@property(nonatomic, strong)UIViewController *phoneLoginVC;

/**
 身份证登陆
 */
@property(nonatomic, strong)UIViewController *idNumberLoginVC;

/**
 用户名登陆
 */
@property(nonatomic, strong)UIViewController *nameLoginVC;

@property(nonatomic, strong)UIViewController *currentVC;

@end

@implementation ImportbankInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = [NSString stringWithFormat:@"导入%@", self.bankNameString];
    
    [self.creditCardLoginButton addTarget:self action:@selector(selectloginType:) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneLoginButton addTarget:self action:@selector(selectloginType:) forControlEvents:UIControlEventTouchUpInside];
    [self.idNumberLoginButton addTarget:self action:@selector(selectloginType:) forControlEvents:UIControlEventTouchUpInside];
    [self.nameLoginButton addTarget:self action:@selector(selectloginType:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addChildViewController:self.creditCardLoginVC];
    
    [self.view addSubview:self.creditCardLoginVC.view];
    [self.creditCardLoginVC didMoveToParentViewController:self];
    self.currentVC = self.creditCardLoginVC;
    [self.creditCardLoginButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    self.lineView.frame = CGRectMake(36 * self.baseicFloat, 36 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 28 * self.baseicFloat, 2 * self.baseicFloat);
}

-(void)selectloginType:(UIButton *)button{
    switch (button.tag) {
        case 1:
            {
                if (self.currentVC != self.creditCardLoginVC) {
                    if (self.currentVC == self.phoneLoginVC) {
                        [self.phoneLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.idNumberLoginVC) {
                        [self.idNumberLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.nameLoginVC){
                        [self.nameLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.creditCardLoginVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.creditCardLoginVC;
                        [self.creditCardLoginButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.lineView.frame = CGRectMake(36 * self.baseicFloat, 38 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 28 * self.baseicFloat, 2 * self.baseicFloat);
                    }];
                }
            }
            break;
            
        case 2:
            {
                if (self.currentVC != self.phoneLoginVC) {
                    if (self.currentVC == self.creditCardLoginVC) {
                        [self.creditCardLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.idNumberLoginVC) {
                        [self.idNumberLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.nameLoginVC){
                        [self.nameLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.phoneLoginVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.phoneLoginVC;
                        [self.phoneLoginButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.lineView.frame = CGRectMake(131 * self.baseicFloat, 38 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 28 * self.baseicFloat, 2 * self.baseicFloat);
                    }];
                }
            }
            break;
            
            
        case 3:
            {
                if (self.currentVC != self.idNumberLoginVC) {
                    if (self.currentVC == self.phoneLoginVC) {
                        [self.phoneLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.creditCardLoginVC) {
                        [self.creditCardLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.nameLoginVC){
                        [self.nameLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.idNumberLoginVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.idNumberLoginVC;
                        [self.idNumberLoginButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.lineView.frame = CGRectMake(234 * self.baseicFloat, 38 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 28 * self.baseicFloat, 2 * self.baseicFloat);
                    }];
                }
            }
            break;
            
            
        case 4:
            {
                if (self.currentVC != self.nameLoginVC) {
                    if (self.currentVC == self.phoneLoginVC) {
                        [self.phoneLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.idNumberLoginVC) {
                        [self.idNumberLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }else if (self.currentVC == self.creditCardLoginVC){
                        [self.creditCardLoginButton setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }
                    [self transitionFromViewController:self.currentVC toViewController:self.nameLoginVC duration:0.3 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
                        self.currentVC = self.nameLoginVC;
                        [self.nameLoginButton setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
                    }];
                    [UIView animateWithDuration:0.3 animations:^{
                        self.lineView.frame = CGRectMake(331 * self.baseicFloat, 38 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, 28 * self.baseicFloat, 2 * self.baseicFloat);
                    }];
                }
            }
            break;
            
            
        default:
            break;
    }
}

-(UIViewController *)creditCardLoginVC{
    if (!_creditCardLoginVC) {
        _creditCardLoginVC = [self createVC:@"CreditCardLoginViewController"];
        _creditCardLoginVC.view.frame = CGRectMake(0, 40 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 40 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
        [self addChildViewController:_creditCardLoginVC];
    }
    return _creditCardLoginVC;
}

-(UIViewController *)phoneLoginVC{
    if (!_phoneLoginVC) {
        _phoneLoginVC = [self createVC:@"PhoneLoginViewController"];
        _phoneLoginVC.view.frame = CGRectMake(0, 40 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 40 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
        [self addChildViewController:_phoneLoginVC];
    }
    return _phoneLoginVC;
}

-(UIViewController *)idNumberLoginVC{
    if (!_idNumberLoginVC) {
        _idNumberLoginVC = [self createVC:@"IdNumberLoginViewController"];
        _idNumberLoginVC.view.frame = CGRectMake(0, 40 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 40 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
        [self addChildViewController:_idNumberLoginVC];
    }
    return _idNumberLoginVC;
}


-(UIViewController *)nameLoginVC{
    if (!_nameLoginVC) {
        _nameLoginVC = [self createVC:@"NameLoginViewController"];
        _nameLoginVC.view.frame = CGRectMake(0, 40 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 40 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
        [self addChildViewController:_nameLoginVC];
    }
    return _nameLoginVC;
}

-(UIButton *)creditCardLoginButton{
    if (!_creditCardLoginButton) {
        _creditCardLoginButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"信用卡", 2, 102, 102, 102, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 27, 80, 67, 15)];
        _creditCardLoginButton.tag = 1;
    }
    return _creditCardLoginButton;
}

-(UIButton *)phoneLoginButton{
    if (!_phoneLoginButton) {
        _phoneLoginButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"手机号", 2, 102, 102, 102, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 122, 80, 67, 15)];
        _phoneLoginButton.tag = 2;
    }
    return _phoneLoginButton;
}

-(UIButton *)idNumberLoginButton{
    if (!_idNumberLoginButton) {
        _idNumberLoginButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"身份证", 2, 102, 102, 102, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 217, 80, 67, 15)];
        _idNumberLoginButton.tag = 3;
    }
    return _idNumberLoginButton;
}

-(UIButton *)nameLoginButton{
    if (!_nameLoginButton) {
        _nameLoginButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"用户名", 2, 102, 102, 102, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 312, 80, 67, 15)];
        _nameLoginButton.tag = 4;
    }
    return _nameLoginButton;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[DelouchView alloc]initView:DelouchViewInfoMake(86, 112, 254, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 36, 102, 28, 2)];
    }
    return _lineView;
}

@end
