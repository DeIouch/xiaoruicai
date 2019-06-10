//
//  LongContentTextView.m
//  HeartNest
//
//  Created by Mac on 2018/12/28.
//  Copyright © 2018 Mac. All rights reserved.
//

#import "LongContentTextView.h"

@implementation LongContentTextView{
    BOOL isChangeBool;
    NSString *placeholderText;
}

#pragma mark -- 初始化时调用 --
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        isChangeBool = NO;
        
        self.font = [UIFont systemFontOfSize:15 * (DelouchWidth / 375.0)];
        self.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        /**
         *  用textVeiw添加通知，当textView发生变化的时候会调用textChanged方法
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEndEdit) name:UITextViewTextDidEndEditingNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textbegin) name:UITextViewTextDidBeginEditingNotification object:nil];
    }
    return self;
}

-(void)setPlaceholder:(NSString *)placeholder{
    self.text = placeholder;
    placeholderText = placeholder;
    isChangeBool = NO;
}

-(void)textEndEdit{
    NSLog(@"停止输入");
    if (self.text.length == 0) {
        self.text = placeholderText;
        isChangeBool = NO;
        self.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    }else{
        isChangeBool = YES;
    }
}

-(void)textbegin{
    if (!isChangeBool) {
        self.text = @"";
    }
}

#pragma mark -- 文字改变的时候会调用该方法
- (void)textChanged:(NSNotification *)notification {
    if (self.text.length > 0) {
        isChangeBool = YES;
        self.textColor = [UIColor blackColor];
    }else{
        isChangeBool = NO;
    }
}

#pragma mark -- 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
