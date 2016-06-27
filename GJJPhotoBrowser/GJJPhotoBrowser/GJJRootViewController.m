//
//  GJJRootViewController.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJRootViewController.h"
static NSString * const reuseCellIdentifier = @"RootCellID";
@interface GJJRootViewController ()
@property (nonatomic,strong)NSArray *cellTitleArray;
@property (nonatomic,strong)NSArray *classNameArray;
@end

@implementation GJJRootViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"仿in图片浏览器";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseCellIdentifier];
}

#pragma mark -- TableView Delegate DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellTitleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellIdentifier];
    }
    cell.textLabel.text = self.cellTitleArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class pushClass = NSClassFromString(self.classNameArray[indexPath.row]);
    if ([pushClass isSubclassOfClass:[UIViewController class]]) {
        UIViewController *pushViewController = [[pushClass alloc] init];
        pushViewController.title = self.cellTitleArray[indexPath.row];
        [self.navigationController pushViewController:pushViewController animated:YES];
    }
}

#pragma mark -- Lazy Loading
-(NSArray *)cellTitleArray
{
    if (!_cellTitleArray) {
        _cellTitleArray = @[@"UICollectionView示例",@"UITableView示例", @"UITableView图片轮播示例"];
    }
    return _cellTitleArray;
}

-(NSArray *)classNameArray
{
    if (!_classNameArray) {
        _classNameArray = @[@"GJJInViewController",@"GJJInPhotoBrowserViewController", @"GJJInAnimatedTableViewController"];
    }
    return _classNameArray;
}
@end
