//
//  CardManageSearchCardViewController.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/16.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "CardManageSearchCardViewController.h"
#import "CardManageSearchHistoryView.h"
#import "HomePageRepaymentTableViewCell.h"

@interface CardManageSearchCardViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

/**
 搜索输入框
 */
@property(nonatomic, strong)UITextField *searchTextField;

///**
// 关闭搜索
// */
//@property(nonatomic, strong)UIImageView *shutDownSearchButton;

/**
 是否是搜索界面
 */
@property(nonatomic, assign)BOOL isSearchBOOL;

/**
 搜索历史记录界面
 */
@property(nonatomic, strong)UIView *searchHistoryView;

@end

@implementation CardManageSearchCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = [self setTableViewNoBarFrame];
    self.tableView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    (void)[[DelouchView alloc]initView:DelouchViewInfoMake(247, 247, 247, 1, YES, 1, self.headview) setFrame:DelouchFrameMake(FrameNotChange, 15 * self.baseicFloat, 7 + DelouchStatusBarHeight, 296 * self.baseicFloat, 30)];
    self.headview.lineView.hidden = YES;
    self.infoDic = DelouchRightButtonInfomake(@"取消", 102, 102, 102, 1, 255, 255, 255, 2, 15);
    
    (void)[[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_search_xiao, NO, 0, self.view) setFrame:DelouchFrameMake(FrameNotChange, 30 * self.baseicFloat, 15 + DelouchStatusBarHeight, 14, 14)];
    
    self.searchTextField.placeholder = @"可搜索 姓名、银行";
    self.searchTextField.delegate = self;
    
//    [self.shutDownSearchButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shutDownSearch)]];
    self.isSearchBOOL = NO;
}

//-(void)shutDownSearch{
//    self.searchTextField.text = @"";
//    [self.searchTextField resignFirstResponder];
//    self.isSearchBOOL = !self.isSearchBOOL;
//}

-(UIView *)searchHistoryView{
    if (!_searchHistoryView) {
        _searchHistoryView = [[CardManageSearchHistoryView alloc]initWithFrame:[self setTableViewNoBarFrame]];
        [self.view addSubview:_searchHistoryView];
    }
    return _searchHistoryView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 127 * self.baseicFloat;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageRepaymentTableViewCell *homePageRepaymentTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"HomePageRepaymentTableViewCell"];
    if (!homePageRepaymentTableViewCell) {
        homePageRepaymentTableViewCell = [[HomePageRepaymentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePageRepaymentTableViewCell"];
    }
    CardListModel *model = self.dataArray[indexPath.row];
    
    homePageRepaymentTableViewCell.bankIconString = @"";
    
    homePageRepaymentTableViewCell.planStateString = model.card_is_plan;
    homePageRepaymentTableViewCell.bankNameString = model.card_bank;
    homePageRepaymentTableViewCell.bankInfoString = [NSString stringWithFormat:@"%@ %@", model.credit_real_name, [model.card_no substringWithRange:NSMakeRange(model.card_no.length - 4, 4)]];
    homePageRepaymentTableViewCell.remainingString = model.card_usable_amount;
    homePageRepaymentTableViewCell.shouldAsloString = model.card_current_bill_return_amount;
    homePageRepaymentTableViewCell.endDayString = model.dayString;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd"];
    NSString *dateString = [format stringFromDate:[NSDate date]];
    if ([dateString integerValue] > [model.card_bill_day integerValue]) {
        homePageRepaymentTableViewCell.asloStateString = @"0";
        homePageRepaymentTableViewCell.endDayString = [NSString stringWithFormat:@"%ld", [model.card_bill_return_day integerValue] - [dateString integerValue]];
        homePageRepaymentTableViewCell.endTimeString = model.card_bill_day_str;
    }else{
        homePageRepaymentTableViewCell.asloStateString = @"1";
        homePageRepaymentTableViewCell.endDayString = [NSString stringWithFormat:@"%ld", [model.card_bill_day integerValue] - [dateString integerValue]];
        homePageRepaymentTableViewCell.endTimeString = model.card_bill_day_str;
    }
    homePageRepaymentTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return homePageRepaymentTableViewCell;
}

-(UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [[DelouchTextField alloc]initTextField:DelouchTextFieldInfoMake(@"", @"", NO, NO, 51, 51, 51, 1, 0, 15, YES, self.view) setFrame:DelouchFrameMake(FrameNotChange, 45 * self.baseicFloat + 14, 14 + DelouchStatusBarHeight, 252 * self.baseicFloat, 16)];
        _searchTextField.clearButtonMode = UITextFieldViewModeAlways;
        _searchTextField.returnKeyType = UIReturnKeySearch;
    }
    return _searchTextField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self isNum:textField.text]) {
        [self urlHeadStr:AppCardsURL urlStr:UrlCardList parameters:[NSDictionary dictionaryWithObjectsAndKeys:textField.text, @"card_no", self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
            [self.dataArray removeAllObjects];
            if ([obj[@"result"][@"cardData"][@"page"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in obj[@"result"][@"cardData"][@"page"]) {
                    [self.dataArray addObject:[[CardListModel alloc]initModelWithDic:dic]];
                }
                [self.tableView reloadData];
            }
        }];
    }else{
        [self urlHeadStr:AppCardsURL urlStr:UrlCardList parameters:[NSDictionary dictionaryWithObjectsAndKeys:textField.text, @"credit_real_name", self.userInfoModel.user_id, @"user_id", nil] Success:^(NSDictionary *obj) {
            if ([obj[@"result"][@"cardData"][@"page"] isKindOfClass:[NSArray class]]) {
                [self.dataArray removeAllObjects];
                for (NSDictionary *dic in obj[@"result"][@"cardData"][@"page"]) {
                    [self.dataArray addObject:[[CardListModel alloc]initModelWithDic:dic]];
                }
                [self.tableView reloadData];
            }
        }];
    }
    
    if (textField.text.length == 0) {
        self.isSearchBOOL = NO;
    }else{
        self.isSearchBOOL = YES;
    }
    
    [self.searchTextField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    self.isSearchBOOL = NO;
    return YES;
}

-(void)rightSelect{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushViewControl:@"CardManageInfoViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:self.dataArray[indexPath.row], @"cardListModel", nil]];
}

//-(UIImageView *)shutDownSearchButton{
//    if (!_shutDownSearchButton) {
//        _shutDownSearchButton = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(icon_guanbi, NO, 0, self.view) setFrame:DelouchFrameMake(FrameNotChange, 310 * self.baseicFloat - 34, 5 + DelouchStatusBarHeight, 34, 34)];
//        _shutDownSearchButton.contentMode = UIViewContentModeCenter;
//    }
//    return _shutDownSearchButton;
//}

-(void)setIsSearchBOOL:(BOOL)isSearchBOOL{
    _isSearchBOOL = isSearchBOOL;
//    self.shutDownSearchButton.hidden = !isSearchBOOL;
    if (isSearchBOOL) {
        [self.view bringSubviewToFront:self.tableView];
    }else{
        [self.view bringSubviewToFront:self.searchHistoryView];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length == 0) {
        self.isSearchBOOL = NO;
    }else{
        self.isSearchBOOL = YES;
    }
    return YES;
}

- (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

@end
