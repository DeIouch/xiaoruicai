//
//  UpdateBankCardTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "UpdateBankCardTableViewCell.h"

@interface UpdateBankCardTableViewCell ()

/**
 oss银行卡正面
 */
@property(nonatomic, strong)NSString *ossBankCardPositiveString;

/**
 leshua银行卡正面
 */
@property(nonatomic, strong)NSString *leshuaBankCardPositiveString;

@end

@implementation UpdateBankCardTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"拍摄/上传您的银行卡", 2, 51, 51, 51, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 22, 375, 15)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"请用手机横向拍摄以保证图片正常显示", 1, 153, 153, 153, 1, 255, 255, 255, 2, 10, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 109, 42, 200, 10)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_tishi, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 97, 42, 9, 9)];
        
        [self.bankCardPositiveImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateBankCardPositive)]];
    }
    return self;
}

-(void)updateBankCardPositive{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __weak typeof(self) weakSelf = self;
    self.Mgr.didFinishPickingBlock = ^(NSArray<ACMediaModel *> *list) {
        if (list.count > 0) {
            for (ACMediaModel *model in list) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    weakSelf.bankCardPositiveImageView.image = model.image;
                    NSData *imageData = [ACMediaModel imageDataWithImage:model.image];
                    [session POST:[NSString stringWithFormat:@"%@%@",OSSUploadFileURL,UrlUploadFile] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        if (imageData) {
                            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%ld.png",random()] mimeType:@"image/jpeg"];
                        }
                    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        weakSelf.ossBankCardPositiveString = [NSString stringWithFormat:@"http://xrc.oss-cn-hangzhou.aliyuncs.com/%@", responseObject[@"result"]];
                        [session POST:[NSString stringWithFormat:@"%@%@",OSSUploadPhotoURL,UrlUploadPhoto] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                            if (imageData) {
                                [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%ld.png",random()] mimeType:@"image/jpeg"];
                            }
                        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            weakSelf.leshuaBankCardPositiveString = responseObject[@"url"];
                            weakSelf.bankCardPositiveBlock(weakSelf.ossBankCardPositiveString, weakSelf.leshuaBankCardPositiveString);
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        }];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    }];
                }];
            }
        }
    };
    [self.Mgr picker];
}

-(UIImageView *)bankCardPositiveImageView{
    if (!_bankCardPositiveImageView) {
        _bankCardPositiveImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(bg_yh_zm, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 8, 65, 173, 125)];
    }
    return _bankCardPositiveImageView;
}

-(UIButton *)updateCertificateButton{
    if (!_updateCertificateButton) {
        _updateCertificateButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"提交", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 216, 345, 44)];
    }
    return _updateCertificateButton;
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
