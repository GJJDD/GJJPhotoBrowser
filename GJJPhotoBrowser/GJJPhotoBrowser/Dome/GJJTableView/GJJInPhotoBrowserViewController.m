//
//  GJJInPhotoBrowserViewController.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJInPhotoBrowserViewController.h"
#import "GJJDomeTableViewCell.h"



@interface GJJInPhotoBrowserViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *photoUrlsArray;
@property (nonatomic, strong) NSMutableArray *layoutModelsArray;

@end

@implementation GJJInPhotoBrowserViewController


- (NSArray *)photoUrlsArray
{

    if (_photoUrlsArray==nil) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"photoUrls" ofType:@"plist"];
        _photoUrlsArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }
    
    return _photoUrlsArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.layoutModelsArray = [NSMutableArray array];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(10, 20, 50, 40);
    CGFloat contentInset = 5;
    CGFloat contentWidth = 300;
    for (int i = 0; i < self.photoUrlsArray.count; i++) {
//        GJJPhotoBrowerLayoutModel *layoutModel = [[GJJPhotoBrowerLayoutModel alloc] initWithPhotoUrlsArray:self.photoUrlsArray[i] ContentWidth:contentWidth andEdgeInsets:edgeInsets andContentInset:contentInset andOrigin:CGPointMake(([UIScreen mainScreen].bounds.size.width-contentWidth)/2, 0)];
        GJJPhotoBrowerLayoutModel *layoutModel = [[GJJPhotoBrowerLayoutModel alloc] initWithPhotoUrlsArray:self.photoUrlsArray[i] andOrigin:CGPointMake(0, 0)];
        [self.layoutModelsArray addObject:layoutModel];
    }
    
    [self loadTableView];
    

}

//- (void)loadViews
//{
//    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(15, 30, 300, 400)];
//    [self.view addSubview:contentView];
//    [contentView setBackgroundColor:[UIColor blueColor]];
//    contentView.layer.cornerRadius = 15;
//    contentView.layer.masksToBounds = YES;
//    
//    GJJPhotoBrowserCollectionView *collectionView = [[GJJPhotoBrowserCollectionView alloc] initWithOrigin:CGPointMake(0, 0) andPhotosArray:self.photoUrlsArray[0] andEdgeInsets:(UIEdgeInsetsMake(0, 0, 0, 0)) andContentInset:5 andContentWidth:300];
//    [contentView addSubview:collectionView];
//
//
//}
- (void)loadTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    [self.view addSubview:tableView];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GJJPhotoBrowerLayoutModel *layoutModel = self.layoutModelsArray[indexPath.row];
    return [layoutModel contentHeight]+100;
}


#pragma mark - tableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layoutModelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellId = @"photoListID";
    GJJDomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[GJJDomeTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setLayoutModel:self.layoutModelsArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
