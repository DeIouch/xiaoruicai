//
//  UserInfoViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

/**
 修改头像
 */
@property(nonatomic, strong)UIImageView *changeIconButton;

/**
 修改昵称
 */
@property(nonatomic, strong)UIImageView *changeNickNameButton;

/**
 地址管理
 */
@property(nonatomic, strong)UIImageView *addressManageButton;

/**
 用户头像
 */
@property(nonatomic, strong)UIImageView *iconImageView;

/**
 修改昵称
 */
@property(nonatomic, strong)UILabel *nickNameLabel;

/**
 推荐码
 */
@property(nonatomic, strong)UILabel *recommendedCodeLabel;

@property(nonatomic, strong)ACMediaPickerManager *Mgr;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"个人资料";
}

-(void)createUI{
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 105, 375, 180)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 326, 375, 55)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"基本资料", 1, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 77, 200, 16)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"地址管理", 1, 153, 153, 153, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 298, 200, 16)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 175, 360, 1)];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 230, 360, 1)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"头像", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 133, 100, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"昵称", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 195, 100, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"推荐码", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 250, 100, 15)];
    
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"收货地址", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 15, 346, 100, 15)];
    
    [self.changeIconButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeIcon)]];
    [self.changeNickNameButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeNickName)]];
    [self.addressManageButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressManage)]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfoModel.user_head_img_path] placeholderImage:[UIImage imageNamed:icon_heads]];
    self.nickNameLabel.text = self.userInfoModel.user_name;
    self.recommendedCodeLabel.text = self.userInfoModel.phone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changedNickName:) name:@"changeNickName" object:nil];
    [self.iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeIcon)]];
}

-(void)changedNickName:(NSNotification *)noti{
    NSString *str = noti.object;
    self.nickNameLabel.text = str;
    [self urlHeadStr:AppInfoURL urlStr:UrlMyList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"id", nil] Success:^(NSDictionary *obj) {
        [self preservationUserinfo:obj[@"result"][@"list"]];
    }];
}

-(void)changeIcon{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __weak typeof(self) weakSelf = self;
    self.Mgr.didFinishPickingBlock = ^(NSArray<ACMediaModel *> *list) {
        if (list.count > 0) {
            for (ACMediaModel *model in list) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    weakSelf.iconImageView.image = model.image;
                    NSData *imageData = [ACMediaModel imageDataWithImage:model.image];
                    [session POST:[NSString stringWithFormat:@"%@%@",OSSUploadFileURL,UrlUploadFile] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        if (imageData) {
                            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%ld.png",random()] mimeType:@"image/jpeg"];
                        }
                    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        NSString *iconString = [NSString stringWithFormat:@"http://xrc.oss-cn-hangzhou.aliyuncs.com/%@", responseObject[@"result"]];
                        [weakSelf urlHeadStr:MyinfoIPURL urlStr:UrlUpdateImmg parameters:[NSDictionary dictionaryWithObjectsAndKeys:iconString, @"tupian", weakSelf.userInfoModel.user_id, @"id", nil] Success:^(NSDictionary *obj) {
                            [weakSelf urlHeadStr:AppInfoURL urlStr:UrlMyList parameters:[NSDictionary dictionaryWithObjectsAndKeys:weakSelf.userInfoModel.user_id, @"id", nil] Success:^(NSDictionary *obj) {
                                [weakSelf preservationUserinfo:obj[@"result"][@"list"]];
                                weakSelf.notiString = @"修改成功";
                            }];
                        }];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    }];
                }];
            }
        }
    };
    [self.Mgr picker];
}

-(void)changeNickName{
    [self pushViewControl:@"ChangeNickNameViewController" propertyDic:nil];
}

-(void)addressManage{
    [self pushViewControl:@"ShippingAddressListViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:@"not", @"onVc", nil]];
}

-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", YES, 22.5, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 295, 118, 45, 45)];
    }
    return _iconImageView;
}

-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 145, 195, 200, 16)];
    }
    return _nickNameLabel;
}

-(UILabel *)recommendedCodeLabel{
    if (!_recommendedCodeLabel) {
        _recommendedCodeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 51, 51, 51, 1, 255, 255, 252, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 145, 250, 200, 16)];
    }
    return _recommendedCodeLabel;
}

-(UIImageView *)changeIconButton{
    if (!_changeIconButton) {
        _changeIconButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 345, 126, 25, 29)];
        _changeIconButton.contentMode = UIViewContentModeCenter;
    }
    return _changeIconButton;
}

-(UIImageView *)changeNickNameButton{
    if (!_changeNickNameButton) {
        _changeNickNameButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 345, 188, 25, 29)];
        _changeNickNameButton.contentMode = UIViewContentModeCenter;
    }
    return _changeNickNameButton;
}

-(UIImageView *)addressManageButton{
    if (!_addressManageButton) {
        _addressManageButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 345, 339, 25, 29)];
        _addressManageButton.contentMode = UIViewContentModeCenter;
    }
    return _addressManageButton;
}


-(ACMediaPickerManager *)Mgr{
    if (!_Mgr) {
        _Mgr = [[ACMediaPickerManager alloc] init];
        _Mgr.naviBgColor = [UIColor whiteColor];
        _Mgr.naviTitleColor = [UIColor blackColor];
        _Mgr.naviTitleFont = [UIFont boldSystemFontOfSize:18.0f];
        _Mgr.barItemTextColor = [UIColor blackColor];
        _Mgr.barItemTextFont = [UIFont systemFontOfSize:15.0f];
        _Mgr.statusBarStyle = UIStatusBarStyleDefault;
        _Mgr.allowPickingImage = YES;
        _Mgr.allowPickingGif = YES;
        _Mgr.maxImageSelected = 1;
    }
    return _Mgr;
}

@end
