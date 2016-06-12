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
@property (nonatomic, strong) GJJPhotoBrowserCollectionView *collectionView;
@end

@implementation GJJDomeTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
    }
    return self;
}

- (void)setLayoutModel:(GJJPhotoBrowerLayoutModel *)layoutModel
{
    [self loadViewsWithPhotoBrowerLayoutModel:layoutModel];
}



- (void)loadViewsWithPhotoBrowerLayoutModel:(GJJPhotoBrowerLayoutModel *)layoutModel
{
    [self.collectionView removeFromSuperview];
    self.collectionView = nil;
    self.collectionView = [[GJJPhotoBrowserCollectionView alloc] initWithPhotoBrowerLayoutModel:layoutModel];
    
    [self.contentView addSubview:self.collectionView];
}

@end
