//
//  GJJPhotoBrowerLaoutModel.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJJPhotoBrowerLayoutModel : NSObject
/**
 *  快速初始化 GJJPhotoBrowerLayoutModel
 *  contentWidth：默认GJJPhotoBrowserCollectionView对象的宽度为屏幕宽度，edgeInsets：默认上下左右间距为5，contentInset：默认图片与图片的间距为5
 *  @param photoUrlsArray 图片链接数组
 *  @param origin GJJPhotoBrowserCollectionView对象的x坐标和y坐标
 *
 *  @return GJJPhotoBrowerLayoutModel 对象
 */
- (instancetype)initWithPhotoUrlsArray:(NSArray *)photoUrlsArray andOrigin:(CGPoint)origin;
/**
 *  初始化 GJJPhotoBrowerLayoutModel
 *
 *  @param photoUrlsArray 图片链接数组
 *  @param contentWidth   GJJPhotoBrowserCollectionView对象的宽度
 *  @param edgeInsets     图片整体与上下左右间距
 *  @param contentInset   图片与图片的间距
 *  @param origin         GJJPhotoBrowserCollectionView对象的的x坐标和y坐标

 *
 *  @return GJJPhotoBrowerLayoutModel 对象
 */
- (instancetype)initWithPhotoUrlsArray:(NSArray *)photoUrlsArray ContentWidth:(CGFloat)contentWidth andEdgeInsets:(UIEdgeInsets)edgeInsets andContentInset:(CGFloat)contentInset andOrigin:(CGPoint)origin;
/**
 *  自动计算所需GJJPhotoBrowserCollectionView的高度
 *
 *  @return GJJPhotoBrowserCollectionView的高度
 */
- (CGFloat)contentHeight;


@property (nonatomic, assign,readonly) CGPoint origin;
@property (nonatomic, assign, readonly) CGFloat contentWidth; // 内容的宽度
@property (nonatomic, assign, readonly) CGFloat contentInset; // 图片与图片的间距
@property (nonatomic, assign, readonly) CGFloat topInset; // 整体距离上方的距离
@property (nonatomic, assign, readonly) CGFloat leftInset; // 整体距离左侧的距离
@property (nonatomic, assign, readonly) CGFloat bottomInset; // 整体距离下方的距离
@property (nonatomic, assign, readonly) CGFloat rightInset; // 整体距离右方的距离

@property (nonatomic, strong, readonly) NSArray *photoUrlsArray; // 图片的url数组

// 每个item的 UICollectionViewLayoutAttributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath andNumberOfCellsInSection:(NSInteger)numberOfCellsInSection;
@end
