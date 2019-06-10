//
//  MemberInfoViewController.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/18.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "MemberInfoViewController.h"
#import "MemberVipInfoTableViewCell.h"
#import "MemberVipPrivilegeTableViewCell.h"
#import "MemberVipPackageTableViewCell.h"
#import "MemberOpenVipTableViewCell.h"
#import "VipPackageModel.h"
#import <StoreKit/StoreKit.h>


@interface MemberInfoViewController ()<UITableViewDelegate, UITableViewDataSource,SKPaymentTransactionObserver,SKProductsRequestDelegate>

/**
 价格
 */
@property(nonatomic, strong)UILabel *prieLabel;

/**
 立即开通
 */
@property(nonatomic, strong)UIButton *goPaymentButton;

@property(nonatomic, strong)NSMutableArray *vipInfoArr;

@property(nonatomic, copy)NSString *productId;

@end

@implementation MemberInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"会员中心";
    self.vipInfoArr = [NSMutableArray array];
}

-(void)createUI{
    [self.headview.leftButton setImage:[UIImage imageNamed:icon_return_white] forState:UIControlStateNormal];
    self.headview.lineView.hidden = YES;
    self.headview.backgroundColor = [UIColor colorWithRed:64 / 255.0 green:64 / 255.0 blue:64 / 255.0 alpha:1];
    self.headview.titleLabel.textColor = [UIColor whiteColor];

    self.tableView.frame = CGRectMake(0, DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - DelouchStatusBarAndNavigationBarHeight - 49 * self.baseicFloat);
    self.tableView.backgroundColor = [UIColor colorWithRed:64 / 255.0 green:64 / 255.0 blue:64 / 255.0 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"总计", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 15 * self.baseicFloat, DelouchHeight - 32 * self.baseicFloat, DelouchWidth, 16 * self.baseicFloat)];
    
    [self.goPaymentButton addTarget:self action:@selector(goPayment) forControlEvents:UIControlEventTouchUpInside];
    
    self.prieLabel.text = @"¥218";
    self.productId = @"9";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeVipPackagePrice:) name:@"changeVipPackagePrice" object:nil];
    
    [self getVipPackageList];
    
    
    
}

-(void)changeVipPackagePrice:(NSNotification *) noti {
    NSDictionary *dic = noti.object;
    NSString *real_price = dic[@"real_price"];
    self.prieLabel.text = [NSString stringWithFormat:@"¥ %@",real_price];
    self.productId = dic[@"productId"];
    
}

-(void)getVipPackageList{
    
    [self urlHeadStr:VipPackageListURL urlStr:UrlVipPackageList parameters:nil Success:^(NSDictionary *obj) {
        NSLog(@"%@",obj);
        NSDictionary *dict = (NSDictionary *)obj;
        for (NSDictionary *dic in dict[@"result"]) {
            VipPackageModel *packageModel = [[VipPackageModel alloc] initModelWithDic:dic];
            [self.vipInfoArr addObject:packageModel];
            
        }
       
        [self.tableView reloadData];
        
        
    }];
    
}

-(void)goPayment{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 154 * self.baseicFloat;
            break;
            
        case 1:
            return 153 * self.baseicFloat;
            break;
            
        case 2:
            return 206 * self.baseicFloat;
            break;
            
        case 3:
            return 236 * self.baseicFloat;
            break;
            
        default:
            break;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            {
                MemberVipInfoTableViewCell *memberVipInfoTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"MemberVipInfoTableViewCell"];
                if (!memberVipInfoTableViewCell) {
                    memberVipInfoTableViewCell = [[MemberVipInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MemberVipInfoTableViewCell"];
                }
                memberVipInfoTableViewCell.userIconString = icon_heads;
                memberVipInfoTableViewCell.nickNameString = @"王欣（130****8888）";
                memberVipInfoTableViewCell.endDateString = @"2010-03-20到期";
                memberVipInfoTableViewCell.userNoString = @"NO.4561 1211 1211 1211";
                cell = memberVipInfoTableViewCell;
            }
            break;
            
        case 1:
            {
                MemberVipPrivilegeTableViewCell *memberVipPrivilegeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"MemberVipPrivilegeTableViewCell"];
                if (!memberVipPrivilegeTableViewCell) {
                    memberVipPrivilegeTableViewCell = [[MemberVipPrivilegeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MemberVipPrivilegeTableViewCell"];
                }
                cell = memberVipPrivilegeTableViewCell;
            }
            break;
            
        case 2:
            {
                MemberVipPackageTableViewCell *memberVipPackageTableViewCell = [tableView  dequeueReusableCellWithIdentifier:@"MemberVipPackageTableViewCell"];
                if (!memberVipPackageTableViewCell) {
                    memberVipPackageTableViewCell = [[MemberVipPackageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MemberVipPackageTableViewCell"];
                }
                memberVipPackageTableViewCell.vipInfoArray = self.vipInfoArr;
                cell = memberVipPackageTableViewCell;
            }
            break;
            
        case 3:
            {
                MemberOpenVipTableViewCell *memberOpenVipTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"MemberOpenVipTableViewCell"];
                if (!memberOpenVipTableViewCell) {
                    memberOpenVipTableViewCell = [[MemberOpenVipTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MemberOpenVipTableViewCell"];
                }
                cell = memberOpenVipTableViewCell;
            }
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UILabel *)prieLabel{
    if (!_prieLabel) {
        _prieLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 172, 102, 16, 1, 255, 255, 255, 2, 23, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 51 * self.baseicFloat, DelouchHeight - 34 * self.baseicFloat, DelouchWidth, 17 * self.baseicFloat)];
    }
    return _prieLabel;
}

-(UIButton *)goPaymentButton{
    if (!_goPaymentButton) {
        _goPaymentButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"立即开通", 2, 255, 255, 255, 1, 229, 173, 89, 1, 16, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 245 * self.baseicFloat, DelouchHeight - 49 * self.baseicFloat, 130 * self.baseicFloat, 49 * self.baseicFloat)];
        [_goPaymentButton addTarget:self action:@selector(payByApplePurchase) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _goPaymentButton;
}

-(void)payByApplePurchase{

    if ([SKPaymentQueue canMakePayments]) {

        NSString * selectProductID = [NSString stringWithFormat:@"%@",self.productId];
        //[self requestProductID:selectProductID];
        // 1.拿到所有可卖商品的ID数组
        NSArray *productIDArray = [[NSArray alloc]initWithObjects:selectProductID, nil];
        NSSet *sets = [[NSSet alloc]initWithArray:productIDArray];
        // 2.向苹果发送请求，请求所有可买的商品
        // 2.1.创建请求对象
        SKProductsRequest *sKProductsRequest = [[SKProductsRequest alloc]initWithProductIdentifiers:sets];
        // 2.2.设置代理(在代理方法里面获取所有的可卖的商品)
        sKProductsRequest.delegate = self;
        // 2.3.开始请求
        [sKProductsRequest start];
    }

}

    -(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
        NSLog(@"可卖商品的数量=%ld",response.products.count);
        NSArray *product = response.products;
        if([product count] == 0){
            NSLog(@"没有商品");
            return;
        }
        for (SKProduct *sKProduct in product) {
            NSLog(@"pro info");
            NSLog(@"SKProduct 描述信息：%@", sKProduct.description);
            NSLog(@"localizedTitle 产品标题：%@", sKProduct.localizedTitle);
            NSLog(@"localizedDescription 产品描述信息：%@",sKProduct.localizedDescription);
            NSLog(@"price 价格：%@",sKProduct.price);
            NSLog(@"productIdentifier Product id：%@",sKProduct.productIdentifier);
            if([sKProduct.productIdentifier isEqualToString: @""]){
                [self buyProduct:sKProduct];
                break;
            }else{
                //NSLog(@"不不不相同");
            }
        }
    }
    
    -(void)buyProduct:(SKProduct *)product{
        // 1.创建票据
        SKPayment *skpayment = [SKPayment paymentWithProduct:product];
        // 2.将票据加入到交易队列
        [[SKPaymentQueue defaultQueue] addPayment:skpayment];
        // 3.添加观察者，监听用户是否付钱成功(不在此处添加观察者)
        //[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    - (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
        /*
         SKPaymentTransactionStatePurchasing, 正在购买
         SKPaymentTransactionStatePurchased, 已经购买
         SKPaymentTransactionStateFailed, 购买失败
         SKPaymentTransactionStateRestored, 回复购买中
         SKPaymentTransactionStateDeferred 交易还在队列里面，但最终状态还没有决定
         */
        for (SKPaymentTransaction *transaction in transactions) {
            switch (transaction.transactionState) {
                case SKPaymentTransactionStatePurchasing:{
                    NSLog(@"正在购买");
                }break;
                case SKPaymentTransactionStatePurchased:{
                    NSLog(@"购买成功");
                    // 购买后告诉交易队列，把这个成功的交易移除掉
                    [queue finishTransaction:transaction];
                    NSLog(@"交易完成");
                    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
                    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
                    //                NSString* log = [[NSString alloc] initWithData:receiptData encoding:NSUTF8StringEncoding];
                    //                NSLog(@"%@", log);
                    
                    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                    NSString *sendString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", encodeStr];
                    //NSString* str = [Config getOwnID];
                    //NSString *sendString =  [NSString stringWithFormat:@"{\"receipt-data\":\"%@\",\"userid\":\"%@\"}", encodeStr, str];
                    //                NSLog(@"_______%@", sendString);
                    
                    //NSURL *storeURL = [[NSURL alloc] initWithString:verify];
                    NSURL *storeURL = [[NSURL alloc] initWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
                    NSData* post = [NSData dataWithBytes:[sendString UTF8String] length:[sendString length]];
                    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:storeURL];
                    [request setHTTPMethod:@"POST"];
                    [request setTimeoutInterval:50.0];
                    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
                    [request setHTTPBody:post];
                    NSError *error = nil;
                    NSData* response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
                    if(error){
                        NSLog(@"error acc");
                        
                        return;
                    }
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
                    NSLog(@"data:%@",dic);
                    
//                    NSDictionary *tempDic1 = @{@"1001":@"100",@"1002":@"500",@"1003":@"1000",@"1004":@"5000",@"1005":@"10000"};
//                    NSDictionary *tempDic2 = @{@"1001":@"12",@"1002":@"50",@"1003":@"98",@"1004":@"518",@"1005":@"998"};
//
//                    NSString *prodect_id = dic[@"receipt"][@"in_app"][0][@"product_id"];
//                    NSString *coin = tempDic1[prodect_id];
//                    NSString *money = tempDic2[prodect_id];
                    //AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
                    //NSString *url = [purl stringByAppendingFormat:@"?service=charge.AppStoreCharge&uid=%@&coin=%@&money=%@",[Config getOwnID],coin,money];
//                    NSString *url = @"";
//                    [session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//                        NSNumber *number = [responseObject valueForKey:@"ret"] ;
//                        if([number isEqualToNumber:[NSNumber numberWithInt:200]])
//                        {
//                            //[self getcoins];
//
//                        }
//                    }failure:^(NSURLSessionDataTask *task, NSError *error){
//
//                    }];
                    
                }break;
                case SKPaymentTransactionStateFailed:{
                    NSLog(@"购买失败");
                    // 购买失败也要把这个交易移除掉
                    [queue finishTransaction:transaction];
                }break;
                case SKPaymentTransactionStateRestored:{
                    NSLog(@"回复购买中,也叫做已经购买");
                    // 回复购买中也要把这个交易移除掉
                    [queue finishTransaction:transaction];
                }break;
                case SKPaymentTransactionStateDeferred:{
                    NSLog(@"交易还在队列里面，但最终状态还没有决定");
                }break;
                default:
                    break;
            }
        }
    }
    
    /******************   内购  ********************/
    -(void)applePayHUD{
         [LSProgressHUD hideForView:self.view];
    }
    -(void)applePayShowHUD{
        [LSProgressHUD showToView:self.view message:nil];
    }
    
    //内购成功
    -(void)applePaySuccess{
        NSLog(@"苹果支付成功");
        //[self getMyCoin];
    }

@end
