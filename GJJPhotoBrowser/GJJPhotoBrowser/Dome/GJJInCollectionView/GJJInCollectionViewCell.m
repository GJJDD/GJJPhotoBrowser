//
//  GJJInCollectionViewCell.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJInCollectionViewCell.h"
#import "GJJPhotoBrowserCollectionView.h"
#import "GJJPhotoBrowerLayoutModel.h"


@interface GJJInCollectionViewCell ()
@property (nonatomic, strong) GJJPhotoBrowserCollectionView *collectionView;
@end

@implementation GJJInCollectionViewCell

- (void)setLayoutModel:(GJJPhotoBrowerLayoutModel *)layoutModel
{
    [self loadViewsWithPhotoBrowerLayoutModel:layoutModel];
}



- (void)loadViewsWithPhotoBrowerLayoutModel:(GJJPhotoBrowerLayoutModel *)layoutModel
{
    [self.collectionView removeFromSuperview];
    self.collectionView = nil;
    self.collectionView = [[GJJPhotoBrowserCollectionView alloc] initWithPhotoBrowerLayoutModel:layoutModel];
    [self.collectionView setUserInteractionEnabled:YES];
    
    [self.contentView addSubview:self.collectionView];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//    
//    UITouch *touch = [touches anyObject];
//    if([self.collectionView pointInside:[touch locationInView:self] withEvent:nil]) {
//     
//        CGPoint originLocation = [touch locationInView:self];
//        NSLog(@"%f----%f", originLocation.x, originLocation.y);
//    }
//           NSLog(@"xx:%f----yy:%f", [touch locationInView:self].x, [touch locationInView:self].y);
//    
//
//}


@end
