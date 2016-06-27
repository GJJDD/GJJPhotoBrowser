//
//  GJJPhotoAnimatedView.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ImageAnimatedBlock)(UIImageView *);

@interface GJJPhotoAnimatedView : UIView
// 图片 url 链接
@property (nonatomic, strong) NSArray *photoUrlsArray;
// 动画设置
@property (nonatomic, copy) ImageAnimatedBlock imageAnimatedBlock;

@property (nonatomic, assign) int animatedTime; // 动画时间
@end
