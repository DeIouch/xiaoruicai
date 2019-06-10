//
//  UpdateIdCardTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "UpdateIdCardTableViewCell.h"

@interface UpdateIdCardTableViewCell ()

/**
 oss手持身份证地址
 */
@property(nonatomic, strong)NSString *ossidCardPictureString;

/**
 leshua手持身份证地址
 */
@property(nonatomic, strong)NSString *leshuaidCardPictureString;

/**
 oss身份证正面地址
 */
@property(nonatomic, strong)NSString *ossIdCardPositiveString;

/**
 leshua身份证正面地址
 */
@property(nonatomic, strong)NSString *leshuaIdCardPositiveString;

/**
 oss身份证反面地址
 */
@property(nonatomic, strong)NSString *ossIdCardReverseString;

/**
 leshua身份证反面地址
 */
@property(nonatomic, strong)NSString *leshuaIdCardReverseString;

@end

@implementation UpdateIdCardTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"拍摄/上传您的二代身份证", 2, 51, 51, 51, 1, 255, 255, 255, 2, 15, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 22, 375, 15)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"请用手机横向拍摄以保证图片正常显示", 1, 153, 153, 153, 1, 255, 255, 255, 2, 10, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 109, 42, 200, 10)];
        
        (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_tishi, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 97, 42, 9, 9)];
        
        [self.idCardPositiveImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateIdCardPositive)]];
        [self.idCardReverseImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateIdCardReverse)]];
        [self.idCardPictureImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateIdCardPicture)]];

       
        
    }
    return self;
}

-(void)updateIdCardPositive{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __weak typeof(self) weakSelf = self;
    self.Mgr.didFinishPickingBlock = ^(NSArray<ACMediaModel *> *list) {
        if (list.count > 0) {
            for (ACMediaModel *model in list) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    weakSelf.idCardPositiveImageView.image = model.image;
                    NSData *imageData = [ACMediaModel imageDataWithImage:model.image];
                    [session POST:[NSString stringWithFormat:@"%@%@",OSSUploadFileURL,UrlUploadFile] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        if (imageData) {
                            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%ld.png",random()] mimeType:@"image/jpeg"];
                        }
                    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        weakSelf.ossIdCardPositiveString = [NSString stringWithFormat:@"http://xrc.oss-cn-hangzhou.aliyuncs.com/%@", responseObject[@"result"]];
                        [session POST:[NSString stringWithFormat:@"%@%@",OSSUploadPhotoURL,UrlUploadPhoto] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                            if (imageData) {
                                [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%ld.png",random()] mimeType:@"image/jpeg"];
                            }
                        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            weakSelf.leshuaIdCardPositiveString = responseObject[@"url"];
                            weakSelf.updateIdCardPositiveBlock(weakSelf.ossIdCardPositiveString, weakSelf.leshuaIdCardPositiveString);
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

-(void)updateIdCardReverse{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __weak typeof(self) weakSelf = self;
    self.Mgr.didFinishPickingBlock = ^(NSArray<ACMediaModel *> *list) {
        if (list.count > 0) {
            for (ACMediaModel *model in list) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    weakSelf.idCardReverseImageView.image = model.image;
                    NSData *imageData = [ACMediaModel imageDataWithImage:model.image];
                    [session POST:[NSString stringWithFormat:@"%@%@",OSSUploadFileURL,UrlUploadFile] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        if (imageData) {
                            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%ld.png",random()] mimeType:@"image/jpeg"];
                        }
                    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        weakSelf.ossIdCardReverseString = [NSString stringWithFormat:@"http://xrc.oss-cn-hangzhou.aliyuncs.com/%@", responseObject[@"result"]];
                        [session POST:[NSString stringWithFormat:@"%@%@",OSSUploadPhotoURL,UrlUploadPhoto] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                            if (imageData) {
                                [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%ld.png",random()] mimeType:@"image/jpeg"];
                            }
                        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            weakSelf.leshuaIdCardReverseString = responseObject[@"url"];
                            weakSelf.updateIdCardReverseBlock(weakSelf.ossIdCardReverseString, weakSelf.leshuaIdCardReverseString);
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

-(void)updateIdCardPicture{

    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];

    __weak typeof(self) weakSelf = self;
    self.Mgr.didFinishPickingBlock = ^(NSArray<ACMediaModel *> *list) {
        if (list.count > 0) {
            for (ACMediaModel *model in list) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    weakSelf.idCardPictureImageView.image = model.image;
                    NSData *imageData = [ACMediaModel imageDataWithImage:model.image];
                    [session POST:[NSString stringWithFormat:@"%@%@",OSSUploadFileURL,UrlUploadFile] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        if (imageData) {
                            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%ld.png",random()] mimeType:@"image/jpeg"];
                        }
                    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        weakSelf.ossidCardPictureString = [NSString stringWithFormat:@"http://xrc.oss-cn-hangzhou.aliyuncs.com/%@", responseObject[@"result"]];
                        [session POST:[NSString stringWithFormat:@"%@%@",OSSUploadPhotoURL,UrlUploadPhoto] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                            if (imageData) {
                                [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%ld.png",random()] mimeType:@"image/jpeg"];
                            }
                        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            weakSelf.leshuaidCardPictureString = responseObject[@"url"];
                            weakSelf.updateIdCardPictureBlock(weakSelf.ossidCardPictureString, weakSelf.leshuaidCardPictureString);
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

-(UIImageView *)idCardPositiveImageView{
    if (!_idCardPositiveImageView) {
        _idCardPositiveImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(bg_sfz_zm, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 12, 69, 173, 125)];
    }
    return _idCardPositiveImageView;
}

-(UIImageView *)idCardReverseImageView{
    if (!_idCardReverseImageView) {
        _idCardReverseImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(bg_sfz_fm, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 192, 69, 173, 125)];
    }
    return _idCardReverseImageView;
}

-(UIImageView *)idCardPictureImageView{
    if (!_idCardPictureImageView) {
        _idCardPictureImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(bg_sfz_scz, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 12, 206, 173, 125)];
    }
    return _idCardPictureImageView;
}



-(void)setIdCardPositiveString:(NSString *)idCardPositiveString{
    _idCardPositiveString = idCardPositiveString;
    [self.idCardPositiveImageView sd_setImageWithURL:[NSURL URLWithString:idCardPositiveString] placeholderImage:[UIImage imageNamed:bg_sfz_zm]];
}

-(void)setIdCardReverseString:(NSString *)idCardReverseString{
    _idCardReverseString = idCardReverseString;
    [self.idCardReverseImageView sd_setImageWithURL:[NSURL URLWithString:idCardReverseString] placeholderImage:[UIImage imageNamed:bg_sfz_fm]];
}

-(void)setIdCardPictureString:(NSString *)idCardPictureString{
    _idCardPictureString = idCardPictureString;
    [self.idCardPictureImageView sd_setImageWithURL:[NSURL URLWithString:idCardPictureString] placeholderImage:[UIImage imageNamed:bg_sfz_scz]];
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
