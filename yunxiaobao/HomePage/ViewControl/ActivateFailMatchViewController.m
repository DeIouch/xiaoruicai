//
//  ActivateFailMatchViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ActivateFailMatchViewController.h"
#import "AllActivateMachineTableViewCell.h"

@interface ActivateFailMatchViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ActivateFailMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight - 40 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.freshBOOL = YES;
}

-(void)freshTableView{
    [self urlHeadStr:AppPosTypeURL urlStr:UrlAppPosType parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"a_user_id", @"3", @"a_type", nil] Success:^(NSDictionary *obj) {
        [self.dataArray removeAllObjects];
        
        if ([obj[@"result"][@"data"][@"page"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"result"][@"data"][@"page"]) {
                [self.dataArray addObject:[[AppPosModel alloc]initModelWithDic:dic]];
            }
            [self.tableView reloadData];
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71 * self.baseicFloat;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllActivateMachineTableViewCell *allActivateMachineTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"AllActivateMachineTableViewCell"];
    if (!allActivateMachineTableViewCell) {
        allActivateMachineTableViewCell = [[AllActivateMachineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AllActivateMachineTableViewCell"];
    }
    AppPosModel *model = self.dataArray[indexPath.row];
    allActivateMachineTableViewCell.machineActiveSNString = [NSString stringWithFormat:@"SN：%@", model.a_sn];
    allActivateMachineTableViewCell.machineActiveNameString = [NSString stringWithFormat:@"%@", model.user_real_name];
    allActivateMachineTableViewCell.machineActiveTypeString = model.a_type;
    allActivateMachineTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return allActivateMachineTableViewCell;
}


@end
