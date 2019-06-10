//
//  IntelligentPlanViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/13.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "IntelligentPlanViewController.h"
#import "IntelligentPlanTableViewCell.h"

@interface IntelligentPlanViewController ()<UITableViewDelegate, UITableViewDataSource, AndyDropDownDelegate>

@property(nonatomic, strong)AndyDropDownList *list;

@property(nonatomic, strong)NSArray *array;

@property(nonatomic, strong)UIImageView *choosePlanStyleImageView;

@property(nonatomic, assign)BOOL listShowBOOL;

@end

@implementation IntelligentPlanViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.refreshIndex = 1;
    [self freshTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"智能规划";
    self.array = [NSArray arrayWithObjects:@"全部",@"已规划",@"未规划",nil];
    [self.view addSubview:self.list];
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(204, 212, 255, 1, NO, 0, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 0, 64, 375, 28)];
    (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"只显示账单日和还款日之间的卡片", 1, 51, 51, 51, 1, 255, 255, 255, 2, 12, YES, self.view) setFrame:DelouchFrameMake(FrameStatusBar, 25, 72, 300, 12)];
    
    
    self.tableView.frame = CGRectMake(0, 33 * self.baseicFloat + DelouchStatusBarAndNavigationBarHeight, DelouchWidth, DelouchHeight - 33 * self.baseicFloat - DelouchStatusBarAndNavigationBarHeight);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.listShowBOOL = NO;
    self.refreshIndex = 1;
    self.freshBOOL = YES;
}

-(void)freshTableView{
    [self urlHeadStr:AppCardPlanURL urlStr:UrlNeedToPlan parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.userInfoModel.user_id, @"user_id", [NSString stringWithFormat:@"%ld", self.refreshIndex], @"page", nil] Success:^(NSDictionary *obj) {
        NSLog(@"obj  ==  %@", obj);
//        if (self.refreshIndex == 1) {
            [self.dataArray removeAllObjects];
//        }
        if ([obj[@"result"][@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in obj[@"result"][@"data"]) {
                [self.dataArray addObject:[[NeedToPlanModel alloc]initModelWithDic:dic]];
            }
        }
        [self.tableView reloadData];
    }];
}

-(void)choosePlanStyle{
    self.listShowBOOL = !self.listShowBOOL;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 127 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IntelligentPlanTableViewCell *intelligentPlanTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"IntelligentPlanTableViewCell"];
    if (!intelligentPlanTableViewCell) {
        intelligentPlanTableViewCell = [[IntelligentPlanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntelligentPlanTableViewCell"];
    }
    NeedToPlanModel *model = self.dataArray[indexPath.row];
    
    
    intelligentPlanTableViewCell.bankNameString = model.card_bank;
    
    intelligentPlanTableViewCell.bankIconString = [NSString stringWithFormat:@"logo_%@80.png", model.card_bank];
    
    intelligentPlanTableViewCell.userNameString = [NSString stringWithFormat:@"%@ %@", model.card_web_user_name, [model.card_no substringWithRange:NSMakeRange(model.card_no.length - 4, 4)]];
    intelligentPlanTableViewCell.shouldAlsoString = model.card_current_bill_return_amount;
    intelligentPlanTableViewCell.orderDayString = model.card_bill_day;
    intelligentPlanTableViewCell.planStateString = model.card_is_plan;
    intelligentPlanTableViewCell.needToPlanModel = model;
    intelligentPlanTableViewCell.setIntelligentPlanBlock = ^(NeedToPlanModel * _Nonnull needToPlanModel) {
        [self pushViewControl:@"SetIntelligentPlanViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:needToPlanModel, @"needToPlanModel", nil]];
    };
    intelligentPlanTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return intelligentPlanTableViewCell;
}

-(AndyDropDownList *)list
{
    if (!_list)
    {
        _list = [[AndyDropDownList alloc]initWithListDataSource:self.array rowHeight:44 view:self.headview.titleLabel];
        _list.delegate = self;
    }
    return _list;
}

-(void)dropDownListParame:(NSString *)aStr
{
    self.titleString = aStr;
}

-(UIImageView *)choosePlanStyleImageView{
    if(!_choosePlanStyleImageView){
        _choosePlanStyleImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_sj_xl, NO, 0, self.view) setFrame:DelouchFrameMake(FrameHeadView, 216, 31, 27, 25)];
        _choosePlanStyleImageView.contentMode = UIViewContentModeCenter;
    }
    return _choosePlanStyleImageView;
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

@end
