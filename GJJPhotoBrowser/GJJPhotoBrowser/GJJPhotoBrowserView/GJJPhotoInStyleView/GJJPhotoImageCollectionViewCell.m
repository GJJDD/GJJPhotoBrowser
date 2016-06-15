//
//  GJJPhotoImageCollectionViewCell.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJPhotoImageCollectionViewCell.h"
#import "GJJWebImage.h"

#define ASPECT_DIFF_TOL 0.1

@interface GJJPhotoImageCollectionViewCell ()

@end

@implementation GJJPhotoImageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadViews];
//        [self.contentView setBackgroundColor:kRandomColor];
    }
    return self;
}



- (void)loadViews
{
    UIImageView *photoImageView = [[UIImageView alloc]init];
    photoImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:photoImageView];
    _photoImageView = photoImageView;
}




- (void)fixContentMode:(UIImage *)image
{
    if (image != nil) {
        CGSize imgSize = image.size;
        CGFloat imgAspect = imgSize.width/imgSize.height;
        CGFloat regAspect = self.frame.size.width/self.frame.size.height;
        if (ABS(imgAspect - regAspect) < ASPECT_DIFF_TOL) {
            // 图像纵横比和显示区域纵横比差异小于阈值，直接拉伸
            self.contentMode = UIViewContentModeScaleToFill;
        } else {
            // 图像纵横比和显示区域纵横比差异过大，以非失真方式缩放填充
            self.contentMode = UIViewContentModeScaleAspectFill;
        }
    }else{
        self.contentMode = UIViewContentModeCenter;
    }
}



- (void)setPhotoUrl:(NSString *)photoUrl
{
    _photoUrl = photoUrl;
 
    [_photoImageView setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [_photoImageView gjj_setImageWithContentModeURL:[NSURL URLWithString:photoUrl]];

}




@end
