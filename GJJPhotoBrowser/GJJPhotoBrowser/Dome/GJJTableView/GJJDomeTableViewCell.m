//
//  GJJDomeTableViewCell.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJDomeTableViewCell.h"
#import "GJJPhotoBrowserCollectionView.h"
#import "GJJDomeTableViewCell.h"
#import "GJJPhotoBrowerLayoutModel.h"


@interface GJJDomeTableViewCell ()
@property (nonatomic, weak) GJJPhotoBrowserCollectionView *collectionView;
@end

@implementation GJJDomeTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
