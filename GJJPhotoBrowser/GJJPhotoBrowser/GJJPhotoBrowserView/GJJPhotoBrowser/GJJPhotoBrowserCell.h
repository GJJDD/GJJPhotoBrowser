//
//  GJJPhotoBrowserCell.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPhotoBrowserCellID @"HUPhotoBrowserCell"
static NSString * const kPhotoCellDidZommingNotification = @"kPhotoCellDidZommingNotification";
static NSString * const kPhotoCellDidImageLoadedNotification = @"kPhotoCellDidImageLoadedNotification";

@interface GJJPhotoBrowserCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *imageView;

//@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)resetZoomingScale;

//- (void)configureCellWithURLStrings:(NSString *)URLStrings;

@property (nonatomic, copy) void(^tapActionBlock)(UITapGestureRecognizer *tapGesture);

@end
