//
//  GJJPhotoImageCollectionViewCell.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJPhotoImageCollectionViewCell.h"
#import "GJJWebImage.h"

#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
@interface GJJPhotoImageCollectionViewCell ()

@end

@implementation GJJPhotoImageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadViews];
        [self.contentView setBackgroundColor:kRandomColor];
    }
    return self;
}



- (void)loadViews
{
    UIImageView *photoImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:photoImageView];
    _photoImageView = photoImageView;
}
- (void)setPhotoUrl:(NSString *)photoUrl
{
    _photoUrl = photoUrl;
 
    [_photoImageView setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [_photoImageView gjj_setImageWithURL:[NSURL URLWithString:photoUrl]];
}




@end
