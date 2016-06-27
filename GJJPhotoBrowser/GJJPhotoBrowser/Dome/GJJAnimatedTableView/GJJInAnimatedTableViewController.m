//
//  GJJInAnimatedTableViewController.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJInAnimatedTableViewController.h"
#import "GJJInPhotoAnimatedTableViewCell.h"
@interface GJJInAnimatedTableViewController ()
@property (nonatomic, strong) NSArray *photoUrlsArray;
@end

@implementation GJJInAnimatedTableViewController
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
    

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.photoUrlsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"cellid";
    
    GJJInPhotoAnimatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[GJJInPhotoAnimatedTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        
    }
    
    [cell setPhotoUrlsArray:self.photoUrlsArray[indexPath.row]];
    
    
    return cell;
}

@end
