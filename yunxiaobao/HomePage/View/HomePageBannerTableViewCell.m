//
//  HomePageBannerTableViewCell.m
//  yunxiaobao
//
//  Created by 睿子金服 on 2019/5/10.
//  Copyright © 2019 rzjf. All rights reserved.
//

#import "HomePageBannerTableViewCell.h"

@interface HomePageBannerTableViewCell ()<SDCycleScrollViewDelegate>

@property(nonatomic, strong)SDCycleScrollView *sDCycleScrollView;

@property(nonatomic, strong)NSMutableArray *imageArray;

@end

@implementation HomePageBannerTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(SDCycleScrollView *)sDCycleScrollView{
    if(!_sDCycleScrollView){
        _sDCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, DelouchWidth, (DelouchWidth / 375.0) * 170) delegate:self placeholderImage:nil];
        _sDCycleScrollView.delegate = self;
        _sDCycleScrollView.pageDotImage = [UIImage imageNamed:icon_banner_white];
        _sDCycleScrollView.currentPageDotImage = [UIImage imageNamed:icon_banner_blue];
        [self.contentView addSubview:_sDCycleScrollView];
    }
    return _sDCycleScrollView;
}

-(void)setImageUrlGroup:(NSArray *)imageUrlGroup{
    _imageUrlGroup = imageUrlGroup;
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for (HomepageBannerModel *model in imageUrlGroup) {
        [array addObject:[NSString stringWithFormat:@"http://xrc.oss-cn-hangzhou.aliyuncs.com/%@", model.banner_img_src]];
    }
        
    if (![array isEqualToArray:self.imageArray]) {
        self.imageArray = array;
    }
    
    self.sDCycleScrollView.imageURLStringsGroup = self.imageArray;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
}

@end
