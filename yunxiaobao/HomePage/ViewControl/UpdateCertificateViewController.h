//
//  UpdateCertificateViewController.h
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "DelouchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdateCertificateViewController : DelouchViewController

@property(nonatomic, strong) NSDictionary *parameters;

@property(nonatomic, strong)NSString *e_sn;

@property(nonatomic, strong)NSString *linkman;

@property(nonatomic, strong)NSString *phoneNo;

@property(nonatomic, strong)NSString *orgCode;

@property(nonatomic, strong)NSString *receiveAddress;

@property(nonatomic, strong)NSString *province;

@property(nonatomic, strong)NSString *city;

@property(nonatomic, strong)NSString *bankAccountName;

@property(nonatomic, strong)NSString *identityNo;

@property(nonatomic, strong)NSString *bankAccountNo;

@property(nonatomic, strong)NSString *bankCode;

@property(nonatomic, strong)NSString *bankInfoId;

@property(nonatomic, strong)NSString *mobile;

@property(nonatomic, strong)NSString *idcardStart;

@property(nonatomic, strong)NSString *idcardEnd;

@property(nonatomic, strong)NSString *fullName;

@property(nonatomic, strong)NSString *kaihuName;

@end

NS_ASSUME_NONNULL_END
