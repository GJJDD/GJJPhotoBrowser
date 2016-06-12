//
//  GJJPhotoBrowserLayout.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJPhotoBrowserLayout.h"



@interface GJJPhotoBrowserLayout ()


@end
@implementation GJJPhotoBrowserLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributesArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.collectionView.numberOfSections; i++) {
        NSInteger numberOfCellsInSection = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < numberOfCellsInSection; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            
            
            UICollectionViewLayoutAttributes *attributes;
            if ([self.photoBrowserLayoutDelegate respondsToSelector:@selector(photoBrowserLayoutlayout:andAttributesForItemAtIndexPath:andNumberOfCellsInSection:)]) {
                attributes = [self.photoBrowserLayoutDelegate photoBrowserLayoutlayout:self andAttributesForItemAtIndexPath:indexPath andNumberOfCellsInSection:numberOfCellsInSection];
                
                if (CGRectIntersectsRect(rect, attributes.frame)) {
                    [attributesArray addObject:attributes];
                }
            }
 
        }
    }
    
    return  attributesArray;
}


@end
