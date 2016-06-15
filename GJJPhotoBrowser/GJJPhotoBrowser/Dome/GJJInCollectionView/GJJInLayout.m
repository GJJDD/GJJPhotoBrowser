//
//  GJJInLayout.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJInLayout.h"
static CGFloat Animation_Scale = 0.5;

@interface GJJInLayout()
@property (nonatomic) NSInteger numberOfSections;
@property (nonatomic) NSInteger numberOfCellsInSection;
@property (nonatomic) CGSize headerSize;
@property (nonatomic) CGSize footerSize;
@property (nonatomic, strong) NSArray *itemsHeight;
@end
@implementation GJJInLayout
#pragma mark -- UICollectionViewLayout 重写的方法
- (void)prepareLayout {
    [super prepareLayout];
    [self initData];
}

/**
 * 该方法返回CollectionView的ContentSize的大小
 */
-(CGSize)collectionViewContentSize {
    return CGSizeMake(SCREEN_WIDTH,[self itemHeightSum:_itemsHeight.count] + _footerSize.height);
}


/**
 * 该方法为每个Cell绑定一个Layout属性~
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *array = [NSMutableArray array];
    
    //add cells
    for (int i = 0; i < _numberOfCellsInSection; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [array addObject:attributes];
    }
    
    NSIndexPath *headerIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionViewLayoutAttributes *headerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:headerIndexPath];
    [array addObject:headerAttributes];
    
    NSIndexPath *footerIndexPath = [NSIndexPath indexPathForItem:_numberOfCellsInSection - 1 inSection:0];
    UICollectionViewLayoutAttributes *footerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:footerIndexPath];
    [array addObject:footerAttributes];
    return array;
}


/**
 * 为每个Cell设置attribute
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取当前Cell的attributes
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //获取滑动的位移
    CGFloat contentOffsetY = self.collectionView.contentOffset.y;
    NSInteger currentIndex = [self currentIndex:contentOffsetY];
    NSLog(@"%ld",currentIndex);
    NSLog(@"%f",contentOffsetY);
    if (indexPath.row >= currentIndex) {
        //获取Cell的X坐标
        CGFloat centerX = SCREEN_WIDTH/2;
        //计算Cell的Y坐标
        CGFloat centerY = [_itemsHeight[indexPath.row] floatValue]/2 + contentOffsetY;
        attributes.size = CGSizeMake(SCREEN_WIDTH, [_itemsHeight[indexPath.row] floatValue]);
        attributes.center = CGPointMake(centerX, centerY);
        attributes.zIndex = 10000 - indexPath.row;
    }
    if (indexPath.row == currentIndex || contentOffsetY < 0) {
        attributes.transform = CGAffineTransformTranslate(attributes.transform, 0, -(contentOffsetY - [self itemHeightSum:currentIndex]));
    }
    return attributes;
}

/**
 * 为每个Header和footer设置attribute
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    if (elementKind == UICollectionElementKindSectionHeader) {
        attributes.frame = CGRectMake(0,-_headerSize.height,_headerSize.width,_headerSize.height);
    }else if (elementKind == UICollectionElementKindSectionFooter) {
        attributes.frame = CGRectMake(0, self.collectionView.contentSize.height - _headerSize.height,_headerSize.width,_headerSize.height);
    }
    
    return attributes;
}

//当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

//修正Cell的位置，使当前Cell显示在屏幕的中心
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    NSInteger currentIndex = [self currentIndex:proposedContentOffset.y];
    CGFloat moveLimit = proposedContentOffset.y - [self itemHeightSum:currentIndex] - ([_itemsHeight[currentIndex] floatValue] - (SCREEN_HEIGHT-64));
    if (moveLimit > Animation_Scale*(SCREEN_HEIGHT - 64)) {
        proposedContentOffset.y = [self itemHeightSum:currentIndex+1];
    }
    else if (moveLimit > 0) {
        proposedContentOffset.y = [self itemHeightSum:currentIndex+1] - (SCREEN_HEIGHT-64);
    }
    return proposedContentOffset;
}





#pragma mark -- 自定义的方法
/**
 * 初始化私有属性，通过代理获取配置参数
 */
- (void) initData{
    _numberOfSections = self.collectionView.numberOfSections;
    
    _numberOfCellsInSection = [self.collectionView numberOfItemsInSection:0];
    
    _itemsHeight = [_layoutDelegate itemHeightWithCollectionView:self.collectionView collectionViewLayout:self];
    
    _headerSize = [_layoutDelegate headerViewSizeWithCollectionView:self.collectionView collectionViewLayout:self];
    
    _footerSize = [_layoutDelegate footerViewSizeWithCollectionView:self.collectionView collectionViewLayout:self];
}

-(CGFloat)itemHeightSum:(NSInteger) count
{
    CGFloat heightSum = 0;
    for (NSInteger i = 0; i < count; i++) {
        heightSum += [_itemsHeight[i] floatValue];
    }
    return heightSum;
}

-(NSInteger)currentIndex:(CGFloat) contentOffsetY;
{
    NSInteger currentIndex = 0;
    CGFloat heightSum = 0;
    for (NSInteger i = 0; i < _itemsHeight.count; i++) {
        heightSum += [_itemsHeight[i] floatValue];
        if (contentOffsetY < heightSum) {
            break;
        }
        currentIndex++;
    }
    return currentIndex;
}

@end
