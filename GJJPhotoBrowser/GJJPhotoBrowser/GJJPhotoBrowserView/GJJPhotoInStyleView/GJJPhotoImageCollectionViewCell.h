//
//  GJJPhotoImageCollectionViewCell.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJJPhotoImageCollectionViewCell : UICollectionViewCell


@property (nonatomic, copy) NSString *photoUrl;
@property (nonatomic, weak, readonly) UIImageView *photoImageView;
@end
