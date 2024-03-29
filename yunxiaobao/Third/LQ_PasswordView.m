//
//  LQ_PasswordView.m
//  验证码输入框
//
//  Created by chongzu20 on 2018/8/3.
//  Copyright © 2018年 chongzu20. All rights reserved.
//

#import "LQ_PasswordView.h"

@implementation LQ_PasswordView{
    NSString *_errorOrclean;
    NSMutableArray *_labelArray;
    NSMutableArray *_lineViewArray;
    NSMutableArray *_lineArray;//光标
}

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //设置属性默认颜色
        self.lineColor = [UIColor colorWithRed:86 / 255.0 green:112 / 255.0 blue:254 / 255.0 alpha:1];
        self.lineViewColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1];
        self.selectlineViewColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1];
        self.errorlineViewColor = [UIColor redColor];
        self.labelFont = [UIFont systemFontOfSize:17];
        self.textLabelColor = [UIColor blackColor];
    }
    return self;
}

- (void)creatView{
    
    self.textField = [[UITextField alloc]init];
    [self.textField becomeFirstResponder];
    self.textField.delegate = self;
     self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
     [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.textField];
    
    _labelArray = [[NSMutableArray alloc]init];
    _lineViewArray = [[NSMutableArray alloc]init];
    _lineArray = [[NSMutableArray alloc]init];
    for (int i =0 ; i<_num; i++) {
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(i*40+i*((self.frame.size.width-_num*40)/(_num-1)), self.frame.size.height-2, 40, 2)];
        if(i == 0){
            lineView.backgroundColor = [UIColor blackColor];
        }else{
            lineView.backgroundColor = self.lineViewColor;
        }
        
         [self addSubview:lineView];
         [_lineViewArray addObject:lineView];
    }
    
    for (int i =0 ; i<_num; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*40+i*((self.frame.size.width-_num*40)/(_num-1)),0, 40, self.frame.size.height-2)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = self.labelFont;
        label.textColor = self.textLabelColor;
        [self addSubview:label];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake((CGRectGetWidth(label.frame)-2)/2,5,2,(CGRectGetHeight(label.frame)-10))];
        CAShapeLayer *line = [CAShapeLayer layer];
        line.path = path.CGPath;
        line.fillColor =  self.lineColor.CGColor;
        
        [label.layer addSublayer:line];
        [line addAnimation:[self opacityAnimation] forKey:@"kOpacityAnimation"];
        if (i == 0) {
            line.hidden = NO;
            
        }else{
            
             line.hidden = YES;

        }
        [_lineArray addObject:line];
        [_labelArray addObject:label];
       
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }else if(string.length == 0){
        return YES;
    }else if(textField.text.length >= self.num){
        return NO;
    }else{
        return YES;
    }
    
}

-(void)cleanPassword:(NSString *)error{
    _errorOrclean = error;
    self.textField.text = @"";
    [self textFieldDidChange:self.textField];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    for (UILabel *codeL in _labelArray) {
        
        codeL.text = nil;
    }
    for (int i = 0; i < textField.text.length; i++) {
        
        ((UILabel *)[_labelArray objectAtIndex:i]).hidden = NO;
        ((UILabel *)[_labelArray objectAtIndex:i]).text =[textField.text substringWithRange:NSMakeRange(i, 1)];
    }
    
    if ([_errorOrclean isEqualToString:@"error"]) {
        
        for (UIView *lineV in _lineViewArray) {
            
            lineV.backgroundColor = self.errorlineViewColor;
            
            [self loadShakeAnimationForView:lineV];
        }
        
        [UIView animateWithDuration:1 animations:^{
            
            for (UIView *lineV in _lineViewArray) {
                lineV.backgroundColor = self.lineViewColor;
            }
            
//            ((UIView *)[_lineViewArray objectAtIndex:textField.text.length]).backgroundColor = self.selectlineViewColor;

            for (int i = 0; i < textField.text.length; i++) {
                ((UIView *)[_lineViewArray objectAtIndex:i]).backgroundColor = self.lineViewColor;
            }
        }];
       
        _errorOrclean = nil;//
    }else{
    
    for (UIView *lineV in _lineViewArray) {
        lineV.backgroundColor = self.lineViewColor;
    }
    
        if (textField.text.length == 0){
            ((UIView *)[_lineViewArray objectAtIndex:0]).backgroundColor = [UIColor blackColor];
        }
        
        if (textField.text.length < 6){
            ((UIView *)[_lineViewArray objectAtIndex:textField.text.length]).backgroundColor = [UIColor blackColor];
        }
        
    for (int i = 0; i < textField.text.length; i++) {
            ((UIView *)[_lineViewArray objectAtIndex:i]).backgroundColor = self.lineViewColor;
        }
    }
    for ( CAShapeLayer *line in _lineArray) {
       
        line.hidden = YES;
        
    }
    
    if (textField.text.length<_num) {
        
        ((CAShapeLayer *)[_lineArray objectAtIndex:textField.text.length]).hidden = NO;
    
    }
    
//    if (textField.text.length == _num) {
    
          self.callBackBlock(textField.text);
//    }
  
}

- (void)setNum:(int)num{
    _num = num;
}

//此方法在设置完所有属性之后调用
- (void)showPassword{
    
    [self creatView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
     [self.textField becomeFirstResponder];
}

//光标闪烁动画
- (CABasicAnimation *)opacityAnimation {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.duration = 1;
    opacityAnimation.repeatCount = HUGE_VALF;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return opacityAnimation;
}

//底部横线抖动动画
-(void)loadShakeAnimationForView:(UIView*)view
{
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-2, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+2, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.1];
    [animation setRepeatCount:1];
    [lbl addAnimation:animation forKey:nil];
}
@end
