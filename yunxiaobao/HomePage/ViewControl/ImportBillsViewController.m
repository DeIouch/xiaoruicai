//
//  ImportBillsViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ImportBillsViewController.h"

@interface ImportBillsViewController ()

@property(nonatomic, strong)UIImageView *importButton;

@property(nonatomic, strong)NSArray *bankIconArray;

@property(nonatomic, strong)NSArray *bankNameArray;

@end

@implementation ImportBillsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"导入账单";
    
    
    
//    self.bankIconArray = [NSArray arrayWithObjects:logo_icbc, logo_zg, logo_nh, logo_jh, logo_zx, logo_pa, logo_zs, logo_jt, icon_All_Banks, nil];
//    self.bankNameArray = [NSArray arrayWithObjects:@"工商银行", @"中国银行", @"农业银行", @"建设银行", @"中信银行", @"平安银行", @"招商银行", @"交通银行", @"全部银行", nil];
//
//    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 1)];
//
//    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(230, 230, 230, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 134, 375, 1)];
//
//    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"通过网银查询账单", 1, 51, 51, 51, 1, 255, 255, 255, 2, 20, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 79, 230, 19)];
//
//    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"实时获取账单、额度、消费明细", 1, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 16, 108, 230, 12)];
//
//    [self.importButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(importBill)]];
//
//    [self createBankList];
}

-(void)receiveMoxieSDKResult:(NSDictionary *)resultDictionary{
    //任务结果code，详细参考文档
    int code = [resultDictionary[@"code"] intValue];
    //是否登录成功
    BOOL loginDone = [resultDictionary[@"loginDone"] boolValue];
    //任务类型
    NSString *taskType = resultDictionary[@"taskType"];
    //任务Id
    NSString *taskId = resultDictionary[@"taskId"];
    //描述
    NSString *message = resultDictionary[@"message"];
    //当前账号
    NSString *account = resultDictionary[@"account"];
    //用户在该业务平台上的userId，例如支付宝上的userId（目前支付宝，淘宝，京东支持）
    NSString *businessUserId = resultDictionary[@"businessUserId"]?resultDictionary[@"businessUserId"]:@"";
    NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,message:%@,account:%@,loginDone:%d，businessUserId:%@",code,taskType,taskId,message,account,loginDone,businessUserId);
    //【登录中】假如code是2且loginDone为false，表示正在登录中
    if(code == 2 && loginDone == false){
        NSLog(@"任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
    else if(code == 2 && loginDone == true){
        NSLog(@"任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【采集成功】假如code是1则采集成功（不代表回调成功）
    else if(code == 1){
        NSLog(@"任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
    }
    //【未登录】假如code是-1则用户未登录
    else if(code == -1){
        NSLog(@"用户未登录");
    }
    //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
    else{
        NSLog(@"任务失败");
    }
}

-(void)createBankList{
    for (int i = 0; i < 9; i ++) {
        UIImageView *bankImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(self.bankIconArray[i], NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, (i % 3) * 128 + 40, (i / 3) * 87 + 154, 40, 40)];
        bankImageView.tag = i;
        [bankImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBank:)]];
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(self.bankNameArray[i], 2, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, (i % 3) * 128 + 20, (i / 3) * 87 + 204, 80, 12)];
    }
}

-(void)selectBank:(UITapGestureRecognizer *)tap{
    switch ([tap view].tag) {
        case 8:
            {
                [self pushViewControl:@"AllbankListViewController" propertyDic:nil];
            }
            break;
            
        default:
            {
                [self pushViewControl:@"ImportbankInfoViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.bankNameArray[[tap view].tag], @"bankNameString", nil]];
            }
            break;
    }
}

-(void)importBill{
    
}

-(UIImageView *)importButton{
    if (!_importButton) {
        _importButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_HeadFor, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 343, 83, 28, 33)];
        _importButton.contentMode = UIViewContentModeCenter;
    }
    return _importButton;
}

@end
