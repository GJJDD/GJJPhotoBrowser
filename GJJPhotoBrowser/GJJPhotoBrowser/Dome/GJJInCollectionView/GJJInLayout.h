//
//  GJJInLayout.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GJJInLayout;

@protocol GJJInLayoutDelegate <NSObject>
/**
 * 确定每个cell的长度
 */
- (NSArray *) itemHeightWithCollectionView:(UICollectionView *)collectionView
                 collectionViewLayout:(GJJInLayout *)collectionViewLayout;

/**
 * 确定头尾View的大小
 */
-(CGSize) headerViewSizeWithCollectionView:(UICollectionView *)collectionView
                      collectionViewLayout:(GJJInLayout *)collectionViewLayout;

-(CGSize) footerViewSizeWithCollectionView:(UICollectionView *)collectionView
                      collectionViewLayout:(GJJInLayout *)collectionViewLayout;

@end

@interface GJJInLayout : UICollectionViewLayout
@property (nonatomic, weak) id<GJJInLayoutDelegate> layoutDelegate;
@end
