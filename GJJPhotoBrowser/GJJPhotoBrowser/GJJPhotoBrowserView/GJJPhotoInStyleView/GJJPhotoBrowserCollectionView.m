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

@property (nonatomic, strong) GJJPhotoBrowerLayoutModel *layoutModel;
@end


@implementation GJJPhotoBrowserCollectionView

- (instancetype)initWithPhotoBrowerLayoutModel:(GJJPhotoBrowerLayoutModel *)layoutModel
{
    if (self = [super init]) {
        self.layoutModel = layoutModel;

     [self setupViews];
    }
    
    return self;
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


- (void)setupViews
{
    GJJPhotoBrowserLayout *layout = [[GJJPhotoBrowserLayout alloc] init];
    layout.photoBrowserLayoutDelegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, self.layoutModel.contentWidth, self.layoutModel.contentHeight) collectionViewLayout:layout];
    [collectionView setBackgroundColor:kRandomColor];
    [self addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionView = collectionView;
    [collectionView registerClass:[GJJPhotoImageCollectionViewCell class] forCellWithReuseIdentifier:photoBrowsercellID];
    //
    [collectionView setFrame:CGRectMake(self.layoutModel.origin.x, self.layoutModel.origin.y, self.layoutModel.contentWidth, self.layoutModel.contentHeight)];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.layoutModel.photoUrlsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GJJPhotoImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoBrowsercellID forIndexPath:indexPath];

    [cell.photoImageView gjj_setImageWithURL:[NSURL URLWithString:self.layoutModel.photoUrlsArray[indexPath.row]]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GJJPhotoImageCollectionViewCell *cell = (GJJPhotoImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [GJJPhotoBrowser showFromImageView:cell.photoImageView withURLStrings:self.layoutModel.photoUrlsArray placeholderImage:[UIImage imageNamed:@"placeholder"] atIndex:indexPath.row dismiss:nil];
    
}


@end
