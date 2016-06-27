//
//  GJJPhotoAnimatedView.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJPhotoAnimatedView.h"
#import "GJJWebImage.h"
#import "GJJPhotoBrowser.h"

@interface GJJPhotoAnimatedView ()

@property (nonatomic, weak) UIImageView *photoImageView;
@property (nonatomic, assign) int index;
@end

@implementation GJJPhotoAnimatedView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupViews];
    }
    
    return self;
}


/*
 * @DO 改变滑动图片
 * @param imageView 滑动视图
 */
- (void)changeImages:(UIImageView *)imageView
{
    self.index++;
    if (self.index>=self.photoUrlsArray.count) {
        self.index = 0;
    }
    
    [imageView gjj_setImageWithContentModeURL:[NSURL URLWithString:self.photoUrlsArray[self.index]]];
    
        CATransition *animation = [CATransition animation];
        //动画时间
        animation.duration = 2.0f;
        //display mode, slow at beginning and end
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        //过渡效果
        animation.type = kCATransitionFade;
        //过渡方向
        animation.subtype = kCATransitionFromBottom;
        //添加动画
    [imageView.layer addAnimation:animation forKey:nil];
    
    //这里是改变图片的程序代码，在此略去，然后递归调用自己
    [self performSelector:@selector(changeImages:)
               withObject: imageView
               afterDelay:3.0
     ];
    
 
}


- (void)setupViews
{

    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:photoImageView];
    photoImageView.layer.masksToBounds = YES;
    
    self.photoImageView = photoImageView;
    [photoImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [photoImageView addGestureRecognizer:tapGestureRecognizer];

}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    [GJJPhotoBrowser showFromImageView:self.photoImageView withURLStrings:self.photoUrlsArray placeholderImage:[UIImage imageNamed:@"placeholder"] atIndex:self.index dismiss:^(UIImage *image, NSInteger index, CGRect frame , GJJPhotoBrowser *photoBrowser) {
        CGRect endFrame = self.photoImageView.bounds;
        
        UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:frame];
        tempImageView.image = self.photoImageView.image;
        tempImageView.contentMode = UIViewContentModeScaleAspectFit;
        photoBrowser.collectionView.hidden = YES;
        
        [[UIApplication sharedApplication].keyWindow addSubview:tempImageView];
        
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            tempImageView.frame = endFrame;
            photoBrowser.alpha = 0;
        } completion:^(BOOL finished) {
            
            [photoBrowser removeFromSuperview];
            [tempImageView removeFromSuperview];
            
        }];
        
        
        
    }];

}

- (void)setPhotoUrlsArray:(NSArray *)photoUrlsArray
{
    _photoUrlsArray = photoUrlsArray;
    
    self.index = 0;
    [self performSelector:@selector(changeImages:)withObject:self.photoImageView afterDelay:0.0];
    
}




@end