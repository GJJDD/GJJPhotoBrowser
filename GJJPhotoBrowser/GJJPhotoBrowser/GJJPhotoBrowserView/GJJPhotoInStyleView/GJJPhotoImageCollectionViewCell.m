//
//  GJJPhotoImageCollectionViewCell.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJPhotoImageCollectionViewCell.h"


@implementation GJJPhotoImageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadViews];
    }
    return self;
}



- (void)loadViews
{
    UIImageView *photoImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:photoImageView];
    self.photoImageView = photoImageView;
}


@end
