//
//  GJJPhotoBrowserCollectionView.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJPhotoBrowserCollectionView.h"
#import "GJJPhotoBrowserLayout.h"
#import "GJJPhotoImageCollectionViewCell.h"
#import "GJJPhotoBrowser.h"
#import "GJJWebImage.h"
#import "GJJPhotoBrowerLayoutModel.h"
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
static NSString *const photoBrowsercellID = @"cellID";
@interface GJJPhotoBrowserCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, GJJPhotoBrowserLayoutDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) GJJPhotoBrowserLayout *layout;

@end


@implementation GJJPhotoBrowserCollectionView


- (instancetype)init
{
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews
{
    GJJPhotoBrowserLayout *layout = [[GJJPhotoBrowserLayout alloc] init];
    self.layout = layout;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView registerClass:[GJJPhotoImageCollectionViewCell class] forCellWithReuseIdentifier:photoBrowsercellID];
}

- (void)setLayoutModel:(GJJPhotoBrowerLayoutModel *)layoutModel
{
    _layoutModel = layoutModel;
    [self.layout setPhotoBrowserLayoutDelegate:self];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    self.frame = CGRectMake(layoutModel.origin.x, layoutModel.origin.y, layoutModel.contentWidth, layoutModel.contentHeight);
    
    [self.collectionView reloadData];
    [self.collectionView setFrame:CGRectMake(0, 0, layoutModel.contentWidth, layoutModel.contentHeight)];
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return YES;
}


#pragma mark - GJJPhotoBrowserLayoutDelegate
- (UICollectionViewLayoutAttributes *)photoBrowserLayoutlayout:(GJJPhotoBrowserLayout *)layout andAttributesForItemAtIndexPath:(NSIndexPath *)indexPath andNumberOfCellsInSection:(NSInteger)numberOfCellsInSection
{
    UICollectionViewLayoutAttributes *attributes = [self.layoutModel layoutAttributesForItemAtIndexPath:indexPath andNumberOfCellsInSection:numberOfCellsInSection];
    return attributes;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.layoutModel.photoUrlsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GJJPhotoImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoBrowsercellID forIndexPath:indexPath];
    cell.photoUrl =self.layoutModel.photoUrlsArray[indexPath.row];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GJJPhotoImageCollectionViewCell *cell = (GJJPhotoImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [GJJPhotoBrowser showFromImageView:cell.photoImageView withURLStrings:self.layoutModel.photoUrlsArray placeholderImage:[UIImage imageNamed:@"placeholder"] atIndex:indexPath.row dismiss:nil];
    
}


@end
