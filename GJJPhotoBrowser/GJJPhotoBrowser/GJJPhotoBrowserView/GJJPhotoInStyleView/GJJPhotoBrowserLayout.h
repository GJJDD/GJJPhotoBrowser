//
//  GJJPhotoBrowserLayout.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GJJPhotoBrowserLayout;
@protocol GJJPhotoBrowserLayoutDelegate <NSObject>

- (UICollectionViewLayoutAttributes *)photoBrowserLayoutlayout:(GJJPhotoBrowserLayout *)layout andAttributesForItemAtIndexPath:(NSIndexPath *)indexPath andNumberOfCellsInSection:(NSInteger)numberOfCellsInSection;

@end


@interface GJJPhotoBrowserLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<GJJPhotoBrowserLayoutDelegate> photoBrowserLayoutDelegate;
@end
