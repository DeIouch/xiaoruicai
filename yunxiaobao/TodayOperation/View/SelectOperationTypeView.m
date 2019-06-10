//
//  SelectOperationTypeView.m
//  yunxiaobao
//
//  Created by 戴青 on 2019/5/21.
//  Copyright © 2019年 rzjf. All rights reserved.
//

#import "SelectOperationTypeView.h"

@interface SelectOperationTypeView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UIView *backView;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UILabel *titleLabel;

@end

@implementation SelectOperationTypeView

-(UIView *)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, DelouchWidth, DelouchHeight);
        self.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:0.6];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([[touches anyObject] locationInView:self].y < self.backView.frame.origin.y) {
        self.hidden = YES;
    }
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self) setFrame:DelouchFrameMake(FrameNotChange, 0, DelouchHeight - 381 * (DelouchWidth / 375.0), DelouchWidth, 381 * (DelouchWidth / 375.0))];
    }
    return _backView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 2, 51, 51, 51, 1, 255, 255, 255, 2, 18, YES, self.backView) setFrame:DelouchFrameMake(FrameCellView, 0, 16, 375, 17)];
    }
    return _titleLabel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 49 * (DelouchWidth / 375.0), DelouchWidth, 332 * (DelouchWidth / 375.0))];
        [_backView addSubview:_tableView];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(void)setTitleString:(NSString *)titleString{
    self.titleLabel.text = titleString;
}

-(void)setTypeArray:(NSMutableArray *)typeArray{
    _typeArray = typeArray;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _typeArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 36 * (DelouchWidth / 375.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectTypeAtIndexPath:)]) {
        [self.delegate didSelectTypeAtIndexPath:indexPath];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = _typeArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
