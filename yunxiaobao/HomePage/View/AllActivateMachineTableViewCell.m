//
//  AllActivateMachineTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/14.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "AllActivateMachineTableViewCell.h"

@interface AllActivateMachineTableViewCell ()

/**
 机器头像
 */
@property(nonatomic, strong)UIImageView *machineIconImageView;

/**
 未激活机器SN
 */
@property(nonatomic, strong)UILabel *machineActiveNotSNLabel;

/**
 激活机器SN
 */
@property(nonatomic, strong)UILabel *machineActiveSNLabel;

/**
 机器用户信息
 */
@property(nonatomic, strong)UILabel *machineActiveNameLabel;

/**
 激活类型
 */
@property(nonatomic, strong)UILabel *machineActiveTypeLabel;

/**
 激活
 */
@property(nonatomic, strong)UIButton *activeMachineButton;

/**
 激活中
 */
@property(nonatomic, strong)UIButton *activeingMachineButton;

/**
 已激活
 */
@property(nonatomic, strong)UIButton *activedMachineButton;

/**
 重新激活
 */
@property(nonatomic, strong)UIButton *activeFailMachineButton;

@end

@implementation AllActivateMachineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        (void)[[DelouchView alloc]initView:DelouchViewInfoMake(250, 250, 250, 1, NO, 0, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 0, 71, 375, 1)];
        
        self.machineIconImageView.image = [UIImage imageNamed:icon_leshua];
    }
    return self;
}


-(UIImageView *)machineIconImageView{
    if (!_machineIconImageView) {
        _machineIconImageView = [[DelouchImageView alloc]initImageView:DelouchImageViewInfoMake(@"", YES, 16, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 15, 20, 32, 32)];
    }
    return _machineIconImageView;
}

-(UILabel *)machineActiveNotSNLabel{
    if (!_machineActiveNotSNLabel) {
        _machineActiveNotSNLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 16, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 57, 20, 200, 32)];
    }
    return _machineActiveNotSNLabel;
}

-(UILabel *)machineActiveSNLabel{
    if (!_machineActiveSNLabel) {
        _machineActiveSNLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 51, 51, 51, 1, 255, 255, 255, 2, 14, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 57, 20, 200, 14)];
    }
    return _machineActiveSNLabel;
}

-(UILabel *)machineActiveNameLabel{
    if (!_machineActiveNameLabel) {
        _machineActiveNameLabel = [[DelouchLabel alloc]initLabel:DelouchLabelInfoMake(@"", 1, 153, 153, 153, 1, 255, 255, 255, 2, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 57, 40, 200, 14)];
    }
    return _machineActiveNameLabel;
}

-(UIButton *)activeMachineButton{
    if (!_activeMachineButton) {
        _activeMachineButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"激活", 2, 255, 255, 255, 1, 86, 112, 254, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_activeMachineButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(13 * (DelouchWidth / 375.0), 13 * (DelouchWidth / 375.0))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _activeMachineButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _activeMachineButton.layer.mask = maskLayer;
    }
    return _activeMachineButton;
}

-(UIButton *)activeingMachineButton{
    if (!_activeingMachineButton) {
        _activeingMachineButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"激活中", 2, 255, 255, 255, 1, 149, 165, 253, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_activeingMachineButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(13 * (DelouchWidth / 375.0), 13 * (DelouchWidth / 375.0))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _activeingMachineButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _activeingMachineButton.layer.mask = maskLayer;
    }
    return _activeingMachineButton;
}

-(UIButton *)activedMachineButton{
    if (!_activedMachineButton) {
        _activedMachineButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"已激活", 2, 255, 255, 255, 1, 204, 204, 204, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_activedMachineButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(13 * (DelouchWidth / 375.0), 13 * (DelouchWidth / 375.0))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _activedMachineButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _activedMachineButton.layer.mask = maskLayer;
    }
    return _activedMachineButton;
}

-(UIButton *)activeFailMachineButton{
    if (!_activeFailMachineButton) {
        _activeFailMachineButton = [[DelouchTitleButton alloc]initButton:DelouchTitleButtonInfoMake(@"重新激活", 2, 255, 255, 255, 1, 255, 68, 32, 1, 12, YES, self.contentView) setFrame:DelouchFrameMake(FrameCellView, 292, 23, 68, 26)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_activeFailMachineButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(13 * (DelouchWidth / 375.0), 13 * (DelouchWidth / 375.0))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _activeFailMachineButton.bounds;
        maskLayer.path = maskPath.CGPath;
        _activeFailMachineButton.layer.mask = maskLayer;
    }
    return _activeFailMachineButton;
}

-(void)setMachineIconString:(NSString *)machineIconString{
    [self.machineIconImageView sd_setImageWithURL:[NSURL URLWithString:machineIconString]];
}

-(void)setMachineActiveTypeString:(NSString *)machineActiveTypeString{
    switch ([machineActiveTypeString intValue]) {
        case 0:
            {
                [self.activeMachineButton addTarget:self action:@selector(activeMachine) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        case 1:
            {
                [self.activeingMachineButton addTarget:self action:@selector(activeingMachine) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        case 2:
            {
                [self.activedMachineButton addTarget:self action:@selector(activedMachine) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        case 3:
            {
                [self.activeFailMachineButton addTarget:self action:@selector(activeFailMachine) forControlEvents:UIControlEventTouchUpInside];
            }
            break;
            
        default:
            break;
    }
}

-(void)setMachineActiveNotSNString:(NSString *)machineActiveNotSNString{
    self.machineActiveNotSNLabel.text = machineActiveNotSNString;
}

-(void)setMachineActiveSNString:(NSString *)machineActiveSNString{
    self.machineActiveSNLabel.text = machineActiveSNString;
}

-(void)setMachineActiveNameString:(NSString *)machineActiveNameString{
    self.machineActiveNameLabel.text = machineActiveNameString;
}

-(void)activeMachine{
    [DelouchLibrary pushViewControl:@"ActivateMachineInfoViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:_appPosModel, @"appPosModel", nil]];
}

-(void)activeingMachine{
    
}

-(void)activedMachine{
    
}

-(void)activeFailMachine{
    [DelouchLibrary pushViewControl:@"ActivateMachineInfoViewController" propertyDic:[NSDictionary dictionaryWithObjectsAndKeys:_appPosModel, @"appPosModel", nil]];
}

-(void)setAppPosModel:(AppPosModel *)appPosModel{
    _appPosModel = appPosModel;
}

@end
