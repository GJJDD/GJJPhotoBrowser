//
//  UIImageView+GJJWebImage.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GJJWebImage)

- (void)gjj_setImageWithURL:(NSURL *)url;
- (void)gjj_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)gjj_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(void(^)(UIImage *image, NSError *error, NSURL *imageUrl))completed;

@end
