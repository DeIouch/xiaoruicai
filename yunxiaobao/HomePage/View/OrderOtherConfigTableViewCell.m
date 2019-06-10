//
//  OrderOtherConfigTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/15.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "OrderOtherConfigTableViewCell.h"

@interface OrderOtherConfigTableViewCell ()

@end

@implementation OrderOtherConfigTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(255, 255, 255, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 0, 345, 203)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 0, 325, 1)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 50, 325, 1)];
        
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 100, 325, 1)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"配送方式：", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 18, 100, 14)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"普通快递", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 200, 18, 150, 15)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"配送说明：", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 68, 100, 14)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"7日工作日内安排发货", 3, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 200, 68, 150, 15)];
        
        (void)[[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"买家留言：", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 25, 118, 100, 14)];
        
        self.textField.placeholder = @"可输入您的留言";
        self.textField.delegate = (id)self;
        
        self.numberLabel.text = @"(0/30)";
    }
    return self;
}

- (void)textViewDidChange:(UITextField *)textView{
    
    if (textView.text.length > 30) {
        textView.text = [textView.text substringToIndex:30];
    }
    //这里的_strLengthLbl为动态显示已输入字数，可按情况添加
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/30",textView.text.length];
}

-(LongContentTextView *)textField{
    if (!_textField) {
        _textField = [[LongContentTextView alloc]initWithFrame:CGRectMake(105 * (DelouchWidth / 375.0), 110 * (DelouchWidth / 375.0), 247 * (DelouchWidth / 375.0), 30 * (DelouchWidth / 375.0))];
        _textField.text = @"安徽省-合肥市-庐阳区 某某某街道阜阳北 路与北城大道交口创智天地 安徽省-合肥市-庐阳区 某某某街道阜阳北 路与北城大道交口创智天地 ";
        _textField.scrollEnabled = NO;
        [self.contentView addSubview:_textField];
        [_textField sizeToFit];
    }
    return _textField;
}

-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 3, 153, 153, 153, 1, 255, 255, 255, 2, 13, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 213, 146, 138, 13)];
    }
    return _numberLabel;
}

@end
