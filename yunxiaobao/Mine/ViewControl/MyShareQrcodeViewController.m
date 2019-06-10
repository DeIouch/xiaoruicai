//
//  MyShareQrcodeViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "MyShareQrcodeViewController.h"

@interface MyShareQrcodeViewController ()

/**
 立即分享按钮
 */
@property(nonatomic, strong)UIButton *shareQrCodeButton;

/**
 要分享图片
 */
@property(nonatomic, strong)UIImageView *shareImageView;

/**
 分享图片1
 */
@property(nonatomic, strong)UIImageView *shareListOneImageView;

/**
 分享图片2
 */
@property(nonatomic, strong)UIImageView *shareListTwoImageView;

/**
 分享图片3
 */
@property(nonatomic, strong)UIImageView *shareListThreeImageView;

/**
 分享弹窗
 */
@property(nonatomic, strong)ShareView *shareView;

@end

@implementation MyShareQrcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"推荐好友";
    self.view.backgroundColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
    
    [self.shareQrCodeButton addTarget:self action:@selector(shareQrCode) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareImageView.image = [UIImage imageNamed:xuanchauntu];
    
//    self.shareListOneImageView.image = [UIImage imageNamed:xuanchauntu];
//
//    self.shareListTwoImageView.image = [UIImage imageNamed:xuanchauntu];
//
//    self.shareListThreeImageView.image = [UIImage imageNamed:xuanchauntu];
    
    self.shareListOneImageView.alpha = 1;
    self.shareListOneImageView.backgroundColor = [UIColor clearColor];
    
    self.shareListTwoImageView.alpha = 0.5;
    self.shareListTwoImageView.backgroundColor = [UIColor blackColor];
    
    self.shareListThreeImageView.alpha = 0.5;
    self.shareListThreeImageView.backgroundColor = [UIColor blackColor];
    
    [self.shareListOneImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareListOne)]];
    [self.shareListTwoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareListTwo)]];
    [self.shareListThreeImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareListThree)]];
}


-(void)shareQrCode{
//    UIImage *image = self.shareListOneImageView.image;
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
//
//    WXImageObject *imageObject = [WXImageObject object];
//    imageObject.imageData = imageData;
//
//    WXMediaMessage *message = [WXMediaMessage message];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res5"
//                                                         ofType:@"jpg"];
//    message.thumbData = [NSData dataWithContentsOfFile:filePath];
//    message.mediaObject = imageObject;
//
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    req.scene = WXSceneTimeline;
//    [WXApi sendReq:req];
    self.shareView.hidden = NO;
}

-(void)shareWxFriend{
    self.shareView.hidden = YES;
    UIImage *image = self.shareListOneImageView.image;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res5"
                                                         ofType:@"jpg"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
}

-(void)shareWxCircle{
    self.shareView.hidden = YES;
    UIImage *image = self.shareListOneImageView.image;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res5"
                                                         ofType:@"jpg"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

-(void)shareListOne{
    self.shareListOneImageView.alpha = 1;
    self.shareListOneImageView.backgroundColor = [UIColor clearColor];
    self.shareListTwoImageView.alpha = 0.5;
    self.shareListTwoImageView.backgroundColor = [UIColor blackColor];
    self.shareListThreeImageView.alpha = 0.5;
    self.shareListThreeImageView.backgroundColor = [UIColor blackColor];
}

-(void)shareListTwo{
    self.shareListOneImageView.alpha = 0.5;
    self.shareListOneImageView.backgroundColor = [UIColor blackColor];
    
    self.shareListTwoImageView.alpha = 1;
    self.shareListTwoImageView.backgroundColor = [UIColor clearColor];
    
    self.shareListThreeImageView.alpha = 0.5;
    self.shareListThreeImageView.backgroundColor = [UIColor blackColor];
}

-(void)shareListThree{
    self.shareListOneImageView.alpha = 0.5;
    self.shareListOneImageView.backgroundColor = [UIColor blackColor];
    
    self.shareListTwoImageView.alpha = 0.5;
    self.shareListTwoImageView.backgroundColor = [UIColor blackColor];
    
    self.shareListThreeImageView.alpha = 1;
    self.shareListThreeImageView.backgroundColor = [UIColor clearColor];
}

-(UIButton *)shareQrCodeButton{
    if (!_shareQrCodeButton) {
        _shareQrCodeButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"0", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchHeight - 49 * self.baseicFloat - DelouchTabbarSafeBottomMargin, DelouchWidth, 49 * self.baseicFloat + DelouchTabbarSafeBottomMargin)];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"立即分享", 2, 255, 255, 255, 1, 86, 112, 254, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchHeight - 49 * self.baseicFloat - DelouchTabbarSafeBottomMargin, DelouchWidth, 49 * self.baseicFloat)];
    }
    return _shareQrCodeButton;
}

-(UIImage *)maskLayerImage:(UIImage *)image{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    [blurFilter setValue:@(50) forKey:@"inputRadius"];
    CIImage * outCiImage = [blurFilter valueForKey:kCIOutputImageKey];
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef outCGImageRef = [context createCGImage:outCiImage fromRect:[outCiImage extent]];
    UIImage * resultImage = [UIImage imageWithCGImage:outCGImageRef];
    CGImageRelease(outCGImageRef);
    return resultImage;
}

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    CGImageRelease(mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:masked ];
    CGImageRelease(masked);
    return maskedImage;
}

-(UIImageView *)shareListOneImageView{
    if (!_shareListOneImageView) {
        _shareListOneImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(xuanchauntu, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 60, 470, 68, 121)];
        _shareListThreeImageView.tag = 1;
    }
    return _shareListOneImageView;
}

-(UIImageView *)shareListTwoImageView{
    if (!_shareListTwoImageView) {
        _shareListTwoImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(xuanchauntu, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 154, 470, 68, 121)];
        _shareListTwoImageView.tag = 2;
    }
    return _shareListTwoImageView;
}

-(UIImageView *)shareListThreeImageView{
    if (!_shareListThreeImageView) {
        _shareListThreeImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(xuanchauntu, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 248, 470, 68, 121)];
        _shareListThreeImageView.tag = 3;
    }
    return _shareListThreeImageView;
}

-(UIImageView *)shareImageView{
    if (!_shareImageView) {
        _shareImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(xuanchauntu, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 94, 104, 188, 334)];
    }
    return _shareImageView;
}

-(ShareView *)shareView{
    if (!_shareView) {
        _shareView = [[ShareView alloc]init];
        [[[UIApplication sharedApplication] keyWindow]addSubview:_shareView];
        __weak typeof(self) weakSelf = self;
        _shareView.shareWxCircleBlock = ^{
            weakSelf.shareView.hidden = YES;
            [weakSelf shareWxCircle];
        };
        _shareView.shareWxFriendBlock = ^{
            weakSelf.shareView.hidden = YES;
            [weakSelf shareWxFriend];
        };
    }
    return _shareView;
}

@end
