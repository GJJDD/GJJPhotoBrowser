//
//  GJJInCollectionViewCell.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJInCollectionViewCell.h"
#import "GJJPhotoBrowserCollectionView.h"
#import "GJJPhotoBrowerLayoutModel.h"


@interface GJJInCollectionViewCell ()
@property (nonatomic, weak) GJJPhotoBrowserCollectionView *collectionView;
@end

@implementation GJJInCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        GJJPhotoBrowserCollectionView *collectionView = [[GJJPhotoBrowserCollectionView alloc] init];
        [self.contentView addSubview:collectionView];
        self.collectionView = collectionView;
    }
    
    return self;
}


- (void)setLayoutModel:(GJJPhotoBrowerLayoutModel *)layoutModel
{
    _layoutModel = layoutModel;
    [self.collectionView setLayoutModel:layoutModel];
}






@end
