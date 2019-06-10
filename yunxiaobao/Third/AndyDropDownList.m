//
//  AndyDropDownList.m
//  AndyDropDownList
//
//  Created by 933 on 16/1/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AndyDropDownList.h"

/**
 *  主屏的宽
 */
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface AndyDropDownList ()
<UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,assign)CGFloat rowHeight;   // 行高
@property(nonatomic,strong)UILabel *button;    //从Controller传过来的控制器
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,assign)NSInteger index;    //记录选中行

@end


@implementation AndyDropDownList

-(id)initWithListDataSource:(NSArray *)array
                  rowHeight:(CGFloat)rowHeight
                       view:(UIView *)v
{
    self = [super initWithFrame:CGRectMake(0, DelouchStatusBarAndNavigationBarHeight, DEF_SCREEN_WIDTH, DelouchHeight)];
    if (self)
    {
        self.arr = array;
        self.rowHeight = rowHeight;
        self.button = (UILabel *)v;
    }
    return self;
}

-(UIView *)bgView{
    if (!_bgView)
    {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DelouchHeight)];
        _bgView.backgroundColor = [UIColor colorWithRed:127 / 255.0 green:127 / 255.0 blue:127 / 255.0 alpha:0.2];
    }
    return _bgView;
}

-(UITableView *)tableView{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 132) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:0.2];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSArray *)arr{
    if (!_arr)
    {
        _arr = [[NSArray alloc]init];
    }
    return _arr;
}

-(UIImageView *)arrow{
    if (!_arrow)
    {
        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 35, 10, 20, 20)];
        _arrow.image = [UIImage imageNamed:icon_selected];
        _arrow.contentMode = UIViewContentModeCenter;
    }
    return _arrow;
}
/**
 *   显示下拉列表
 */
-(void)showList
{
    [self addSubview:self.bgView];
    [self addSubview:self.tableView];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.25f animations:^{
        self.bgView.alpha = 1;
        self.bgView.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, DelouchHeight);
        self.tableView.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, DelouchHeight);
    }];
}
/**
 *  隐藏
 */
-(void)hiddenList
{
    [UIView animateWithDuration:0.25f animations:^{
        self.bgView.alpha = 0;
        self.bgView.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 0);
        self.tableView.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
        self.hidden = YES;
    }];
}
#pragma mark - UITableViewDelegateAndUITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.arr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    if (self.index == indexPath.row)
    {
        if ([cell.textLabel.text isEqualToString:self.button.text])
        {
            [cell addSubview:self.arrow];
        }
    }
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ----------------UITableView  表的选中方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hiddenList];
    self.index = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(dropDownListParame:)])
    {
        [self.delegate dropDownListParame:self.arr[indexPath.row]];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}


@end
