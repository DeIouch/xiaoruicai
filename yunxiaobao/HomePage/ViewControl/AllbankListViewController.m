//
//  AllbankListViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "AllbankListViewController.h"
#import "AllBankListTableViewCell.h"

@interface AllbankListViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation AllbankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"选择银行";
    
    self.tableView.frame = [self setTableViewNoBarFrame];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllBankListTableViewCell *allBankListTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"AllBankListTableViewCell"];
    if (!allBankListTableViewCell) {
        allBankListTableViewCell = [[AllBankListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AllBankListTableViewCell"];
        allBankListTableViewCell.bankNameString = @"工商银行";
    }
    
    allBankListTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return allBankListTableViewCell;
}

@end
