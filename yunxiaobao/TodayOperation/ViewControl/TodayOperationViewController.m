//
//  TodayOperationViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "TodayOperationViewController.h"
#import "TodayOperationAllTableViewCell.h"
#import "TodayOperationCardTableViewCell.h"

@interface TodayOperationViewController ()<UITableViewDelegate, UITableViewDataSource, AndyDropDownDelegate>

/**
 操作类型
 */
@property(nonatomic, strong)UILabel *operationTypeLabel;

/**
 选择操作类型
 */
@property(nonatomic, strong)UIImageView *chooseOperationButton;

@property(nonatomic, strong)AndyDropDownList *list;

@property(nonatomic, assign)BOOL listShowBOOL;

@property(nonatomic, strong)NSArray *array;

@property(nonatomic, strong)NSMutableArray *moneyArray;

@property(nonatomic, strong)NSString *typeString;

@end

@implementation TodayOperationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.refreshIndex = 1;
    [self freshTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"今日操作", 1, 51, 51, 51, 1, 255, 255, 255, 2, 22, NO, self.headview) setFrame:DelouchFrameMake(FrameHeadView, 15, 31, 140, 23)];
    self.headview.leftButton.hidden = YES;
    
    self.tableView.frame = [self setTableViewNoBarTabbarFrame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.infoDic = DelouchRightButtonInfomake(@"操作记录", 51, 51, 51, 1, 255, 255, 255, 2, 13);
    
    self.headview.lineView.hidden = YES;
    
    self.operationTypeLabel.text = @"未消费";
    [self.chooseOperationButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseOperation)]];
    
    self.array = [NSArray arrayWithObjects:@"全部",@"未消费",@"未还款",nil];
    
    self.typeString = @"";
    
    [self.view addSubview:self.list];
    self.listShowBOOL = NO;
    self.freshBOOL = YES;
}

-(void)freshTableView{
    [self urlHeadStr:AppOperationTodayURL urlStr:UrlTodayPlanList parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", @"1", @"flag", [NSString stringWithFormat:@"%ld", self.refreshIndex], @"page", nil] Success:^(NSDictionary *obj) {
        if (self.refreshIndex == 1) {
            [self.dataArray removeAllObjects];
        }
        if ([obj[@"result"][@"planData"][@"page"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"result"][@"planData"][@"page"]) {
                [self.dataArray addObject:[[TodayPlanListModel alloc]initModelWithDic:dic]];
            }
            if ([obj[@"result"][@"countData"] isKindOfClass:[NSArray class]]) {
                self.moneyArray = obj[@"result"][@"countData"];
            }
            [self.tableView reloadData];
        }
    }];
}

-(void)chooseOperation{
    self.listShowBOOL = !self.listShowBOOL;
}

-(void)rightSelect{
    [self pushViewControl:@"TodayOperationRecordsListViewController" propertyDic:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            {
                return 120 * self.baseicFloat;
            }
            break;
            
        default:
            {
                return 127 * self.baseicFloat;
            }
            break;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            {
                TodayOperationAllTableViewCell *todayOperationAllTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TodayOperationAllTableViewCell"];
                if (!todayOperationAllTableViewCell) {
                    todayOperationAllTableViewCell = [[TodayOperationAllTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TodayOperationAllTableViewCell"];
                }
                todayOperationAllTableViewCell.totalConsumptionString = @"0";
                todayOperationAllTableViewCell.reimbursementAmountString = @"0";
                for (NSDictionary *dic in self.moneyArray) {
                    switch ([[dic[@"plan_kind"] stringValue] intValue]) {
                        case 1:
                            todayOperationAllTableViewCell.reimbursementAmountString = [dic[@"plan_amount"] stringValue];
                            break;
                            
                        case 2:
                            todayOperationAllTableViewCell.totalConsumptionString = [dic[@"plan_amount"] stringValue];
                            break;
                            
                        default:
                            break;
                    }
                }
                cell = todayOperationAllTableViewCell;
            }
            break;
            
        default:
            {
                TodayOperationCardTableViewCell *todayOperationCardTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"TodayOperationCardTableViewCell"];
                if (!todayOperationCardTableViewCell) {
                    todayOperationCardTableViewCell = [[TodayOperationCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TodayOperationCardTableViewCell"];
                }
                TodayPlanListModel *model = self.dataArray[indexPath.row - 1];
                
//                todayOperationCardTableViewCell.bankIconString = @"";
                todayOperationCardTableViewCell.bankNameString = model.card_bank;
                
                todayOperationCardTableViewCell.bankInfoString = [NSString stringWithFormat:@"%@ %@", model.credit_real_name.length == 0 ? @"" : model.credit_real_name, [model.card_no substringWithRange:NSMakeRange(model.card_no.length - 4 , 4)]];
                todayOperationCardTableViewCell.limitString = model.plan_amount;
                todayOperationCardTableViewCell.numberString = model.plan_count;
                todayOperationCardTableViewCell.operationStateString = model.plan_kind;
                todayOperationCardTableViewCell.todayPlanListModel = model;
                
                //  立即还款
                todayOperationCardTableViewCell.todayOperationCardImmediateRepaymentBlock = ^(TodayPlanListModel * _Nonnull todayPlanListModel) {
                    [self pushViewControl:@"TodayOperationImmediateRepaymentViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:todayPlanListModel, @"todayPlanListModel", nil]];
                };
                
                //  立即消费
                todayOperationCardTableViewCell.todayOperationCardImmediateConsumptionBlock = ^(TodayPlanListModel * _Nonnull todayPlanListModel) {
                    [self pushViewControl:@"TodayOperationCardImmediateConsumptionViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:todayPlanListModel, @"todayPlanListModel", nil]];
                };
                
                cell = todayOperationCardTableViewCell;
            }
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(UILabel *)operationTypeLabel{
    if(!_operationTypeLabel){
        _operationTypeLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"全部", 2, 51, 51, 51, 1, 255, 255, 255, 2, 13, NO, self.view) setFrame:DelouchFrameMake(FrameHeadView, 246, 36, 40, 13)];
    }
    return _operationTypeLabel;
}

-(UIImageView *)chooseOperationButton{
    if(!_chooseOperationButton){
        _chooseOperationButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_sj_xl, NO, 0, self.view) setFrame:DelouchFrameMake(FrameHeadView, 286, 31, 27, 25)];
        _chooseOperationButton.contentMode = UIViewContentModeLeft;
    }
    return _chooseOperationButton;
}

-(AndyDropDownList *)list{
    if (!_list){
            _list = [[AndyDropDownList alloc]initWithListDataSource:self.array rowHeight:44 view:self.headview.titleLabel];
            _list.delegate = self;
        }
    return _list;
}

-(void)dropDownListParame:(NSString *)aStr
{
    self.operationTypeLabel.text = aStr;
    if ([aStr isEqualToString:@"全部"]) {
        self.typeString = @"";
    }else if ([aStr isEqualToString:@"未消费"]) {
        self.typeString = @"2";
    }else if ([aStr isEqualToString:@"未还款"]) {
        self.typeString = @"1";
    }
}

-(void)setListShowBOOL:(BOOL)listShowBOOL{
    _listShowBOOL = listShowBOOL;
    if(listShowBOOL){
        [self.list showList];
        self.list.hidden = NO;
    }else{
        [self.list hiddenList];
    }
    [self.view bringSubviewToFront:self.list];
}

-(NSMutableArray *)moneyArray{
    if (!_moneyArray) {
        _moneyArray = [[NSMutableArray alloc]init];
    }
    return _moneyArray;
}

@end
