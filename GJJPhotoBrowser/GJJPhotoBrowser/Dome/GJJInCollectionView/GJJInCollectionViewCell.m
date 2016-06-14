//
//  GJJInCollectionViewCell.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJInCollectionViewCell.h"


@interface GJJInCollectionViewCell ()
@property (nonatomic, weak) GJJPhotoBrowserCollectionView *collectionView;
@property (nonatomic, weak) UIView *circleView;
@end

@implementation GJJInCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        UIView *circleView = [[UIView alloc] init];
        [self.contentView addSubview:circleView];
        [circleView setBackgroundColor:[UIColor whiteColor]];
        self.circleView = circleView;
        circleView.layer.masksToBounds = YES;
        circleView.layer.cornerRadius = 10;
        
        
        GJJPhotoBrowserCollectionView *collectionView = [[GJJPhotoBrowserCollectionView alloc] init];
        [circleView addSubview:collectionView];
        self.collectionView = collectionView;
    }
    
    return self;
}


- (void)setLayoutModel:(GJJPhotoBrowerLayoutModel *)layoutModel
{
    _layoutModel = layoutModel;
    [self.collectionView setLayoutModel:layoutModel];
    [self.circleView setFrame:CGRectMake(10, 10, layoutModel.contentWidth, layoutModel.contentHeight+150)];
}






@end
