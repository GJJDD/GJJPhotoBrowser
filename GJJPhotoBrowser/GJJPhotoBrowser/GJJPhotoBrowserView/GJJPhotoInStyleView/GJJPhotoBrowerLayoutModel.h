//
//  GJJPhotoBrowerLaoutModel.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJJPhotoBrowerLayoutModel : NSObject


- (instancetype)initWithPhotoUrlsArray:(NSArray *)photoUrlsArray ContentWidth:(CGFloat)contentWidth andEdgeInsets:(UIEdgeInsets)edgeInsets andContentInset:(CGFloat)contentInset andOrigin:(CGPoint)origin;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat contentWidth; // 内容的宽度
@property (nonatomic, assign) CGFloat contentInset; // 图片与图片的间距
@property (nonatomic, assign) CGFloat topInset; // 整体距离上方的距离
@property (nonatomic, assign) CGFloat leftInset; // 整体距离左侧的距离
@property (nonatomic, assign) CGFloat bottomInset; // 整体距离下方的距离
@property (nonatomic, assign) CGFloat rightInset; // 整体距离右方的距离

@property (nonatomic, strong) NSArray *photoUrlsArray; // 图片的url数组
- (CGFloat)contentHeight; // 高度
// 每个item的 UICollectionViewLayoutAttributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath andNumberOfCellsInSection:(NSInteger)numberOfCellsInSection;


@end
