//
//  ActivationCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/30.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "ActivationCell.h"

@implementation ActivationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, DelouchWidth - 120, 25)];
        [self addSubview:self.textField];
        self.textField.textAlignment = NSTextAlignmentRight;
        
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectBtn.frame = CGRectMake(DelouchWidth - 90, 10, 80, 25);
        [self.selectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.selectBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.selectBtn];
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 10, DelouchWidth - 120, 25)];
        [self addSubview:_detailLabel];
    }
    return self;
}

@end
