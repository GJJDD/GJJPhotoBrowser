//
//  GJJDomeTableViewCell.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJDomeTableViewCell.h"




@interface GJJDomeTableViewCell ()
@property (nonatomic, weak) GJJPhotoBrowserCollectionView *collectionView;
@property (nonatomic, weak) UILabel *descLabel;
@end

@implementation GJJDomeTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        GJJPhotoBrowserCollectionView *collectionView = [[GJJPhotoBrowserCollectionView alloc] init];
        [self.contentView addSubview:collectionView];
        self.collectionView = collectionView;
        // 描述信息
        UILabel *descLabel = [[UILabel alloc] init];
        [self.contentView addSubview:descLabel];
        [descLabel setTextColor:kRandomColor];
        [descLabel setTextAlignment:(NSTextAlignmentCenter)];
        self.descLabel = descLabel;
        
    }
    return self;
}

- (void)setLayoutModel:(GJJPhotoBrowerLayoutModel *)layoutModel
{
    _layoutModel = layoutModel;
    [self.collectionView setLayoutModel:layoutModel];
    [self.descLabel setFrame:CGRectMake(0, layoutModel.contentHeight, [UIScreen mainScreen].bounds.size.width, 30)];
    [self.descLabel setText:@"这是一段描述信息"];
    
}




@end
