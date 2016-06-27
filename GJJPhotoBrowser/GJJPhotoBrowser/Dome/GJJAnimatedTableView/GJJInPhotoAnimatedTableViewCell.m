//
//  GJJInPhotoAnimatedTableViewCell.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJInPhotoAnimatedTableViewCell.h"
#import "GJJPhotoAnimatedView.h"

@interface GJJInPhotoAnimatedTableViewCell ()

@property (nonatomic, weak) GJJPhotoAnimatedView *photoAnimatedView;

@end


@implementation GJJInPhotoAnimatedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    GJJPhotoAnimatedView *photoAnimatedView = [[GJJPhotoAnimatedView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    [self.contentView addSubview:photoAnimatedView];
    self.photoAnimatedView = photoAnimatedView;
    // 设置动画间隔时间
//    self.photoAnimatedView.animatedTime  = 4;
    photoAnimatedView.imageAnimatedBlock = ^(UIImageView *imageView){
        
        CATransition *animation = [CATransition animation];
        // 动画时间
        animation.duration = 2.0f;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        // 过渡效果
        animation.type = kCATransitionMoveIn;
        // 过渡方向
        animation.subtype = kCATransitionFade;
        // 添加动画
        [imageView.layer addAnimation:animation forKey:nil];
    };
}

- (void)setPhotoUrlsArray:(NSArray *)photoUrlsArray
{
    _photoUrlsArray = photoUrlsArray;
    [self.photoAnimatedView setPhotoUrlsArray:photoUrlsArray];
    
}


@end
