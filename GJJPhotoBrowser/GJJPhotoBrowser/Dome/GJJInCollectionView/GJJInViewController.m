//
//  GJJInViewController.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJInViewController.h"
#import "GJJInLayout.h"
#import "GJJPhotoBrowserCollectionView.h"
#import "GJJPhotoBrowserLayout.h"
#import "GJJPhotoBrowerLayoutModel.h"
#import "GJJInCollectionViewCell.h"

#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static NSString * const reuseCellIdentifier = @"cardCellID";
static NSString * const reuseHeaderIdentifier = @"cardHeaderID";
static NSString * const reuseFooterIdentifier = @"cardFooterID";
@interface GJJInViewController ()<GJJInLayoutDelegate,UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) GJJInLayout *cardLayout;



@property (nonatomic, strong) NSArray *photoUrlsArray;
@property (nonatomic, strong) NSMutableArray *layoutModelsArray;
@end

@implementation GJJInViewController
- (NSArray *)photoUrlsArray
{
    
    if (_photoUrlsArray==nil) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"photoUrls" ofType:@"plist"];
        _photoUrlsArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }
    
    return _photoUrlsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.layoutModelsArray = [NSMutableArray array];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    CGFloat contentInset = 5;
    CGFloat contentWidth = [UIScreen mainScreen].bounds.size.width;
    for (int i = 0; i < self.photoUrlsArray.count; i++) {
        GJJPhotoBrowerLayoutModel *layoutModel = [[GJJPhotoBrowerLayoutModel alloc] initWithPhotoUrlsArray:self.photoUrlsArray[i] ContentWidth:contentWidth andEdgeInsets:edgeInsets andContentInset:contentInset andOrigin:CGPointMake(([UIScreen mainScreen].bounds.size.width-contentWidth)/2, 0)];
        [self.layoutModelsArray addObject:layoutModel];
    }
    
    
    
    
    
    self.title = @"仿In动态显示动画";
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    GJJInLayout *inLayout = [GJJInLayout new];
    inLayout.layoutDelegate = self;
    UICollectionView *cardCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT-64) collectionViewLayout:inLayout];

    cardCollectionView.layer.masksToBounds = NO;
    cardCollectionView.dataSource = self;
    cardCollectionView.delegate = self;
    cardCollectionView.backgroundColor = [UIColor whiteColor];
    cardCollectionView.pagingEnabled = NO;
    cardCollectionView.bounces = YES;
    cardCollectionView.decelerationRate = 0.1f;
    [cardCollectionView registerClass:[GJJInCollectionViewCell class] forCellWithReuseIdentifier:reuseCellIdentifier];
    [cardCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier];
    [cardCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier];
    [self.view addSubview:cardCollectionView];

}

#pragma mark <LayoutDelegate>

- (NSArray *)itemHeightWithCollectionView:(UICollectionView *)collectionView
                collectionViewLayout:(GJJInLayout *)collectionViewLayout {
    /*
     模拟高度
     */
    NSMutableArray *heightArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < self.layoutModelsArray.count; i++) {
        
        GJJPhotoBrowerLayoutModel *layoutModel = self.layoutModelsArray[i];
        
        CGFloat height = ([layoutModel contentHeight]+[UIScreen mainScreen].bounds.size.height);
        [heightArray addObject:[NSNumber numberWithFloat:height]];
    }
    return heightArray;
}

-(CGSize)headerViewSizeWithCollectionView:(UICollectionView *)collectionView collectionViewLayout:(GJJInLayout *)collectionViewLayout
{
    return CGSizeMake(SCREEN_WIDTH,65.f);
}

-(CGSize)footerViewSizeWithCollectionView:(UICollectionView *)collectionView collectionViewLayout:(GJJInLayout *)collectionViewLayout
{
    return CGSizeMake(SCREEN_WIDTH,65.f);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return self.layoutModelsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GJJInCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    [cell setBackgroundColor:kRandomColor];
    
    [cell setLayoutModel:self.layoutModelsArray[indexPath.row]];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
        view.backgroundColor = [UIColor greenColor];
        return view;
    }
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseFooterIdentifier forIndexPath:indexPath];
    view.backgroundColor = [UIColor grayColor];
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
