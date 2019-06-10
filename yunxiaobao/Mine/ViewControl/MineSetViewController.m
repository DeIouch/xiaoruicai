//
//  MineSetViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "MineSetViewController.h"
#import "LoginViewController.h"

@interface MineSetViewController ()

/**
 手机号码
 */
@property(nonatomic, strong)UILabel *phoneLabel;

/**
 修改密码
 */
@property(nonatomic, strong)UIImageView *changePwdButton;

/**
 关于我们
 */
@property(nonatomic, strong)UIImageView *aboutUsButton;

/**
 安全退出
 */
@property(nonatomic, strong)UIButton *exitButton;

@end

@implementation MineSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"设置";
}

-(void)createUI{
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"账号设置", 1, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 77, 200, 16)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"关于", 1, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 228, 200, 16)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 105, 375, 110)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 256, 375, 55)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 160, 360, 1)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"手机号码", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 125, 100, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"修改密码", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 180, 100, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"关于我们", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 276, 100, 15)];
    
    [self.changePwdButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePwd)]];
    [self.aboutUsButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aboutUs)]];
    [self.exitButton addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
    
    self.phoneLabel.text = self.userInfoModel.phone;
}

-(void)changePwd{
    [self pushViewControl:@"ChangePwdViewController" propertyDic:nil];
}

-(void)aboutUs{
    
}

-(void)exitLogin{
//    [self urlHeadStr:AppInfoURL urlStr:UrlLoginExit parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", nil] Success:^(NSDictionary *obj) {
        LoginViewController *mainVC = nil;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[LoginViewController class]]) {
                mainVC = (LoginViewController *)vc;
            }
        }
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            sleep(1);
//            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToViewController:mainVC animated:YES];
//            });
//        });
//    }];
}


-(UIImageView *)changePwdButton{
    if (!_changePwdButton) {
        _changePwdButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 345, 173, 26, 29)];
        _changePwdButton.contentMode = UIViewContentModeCenter;
    }
    return _changePwdButton;
}

-(UIImageView *)aboutUsButton{
    if (!_aboutUsButton) {
        _aboutUsButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 345, 269, 26, 29)];
        _aboutUsButton.contentMode = UIViewContentModeCenter;
    }
    return _aboutUsButton;
}

-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 204, 204, 204, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 200, 125, 160, 16)];
    }
    return _phoneLabel;
}

-(UIButton *)exitButton{
    if (!_exitButton) {
        _exitButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"安全退出", 2, 51, 51, 51, 1, 255, 255, 255, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 321, 375, 55)];
    }
    return _exitButton;
}

@end
