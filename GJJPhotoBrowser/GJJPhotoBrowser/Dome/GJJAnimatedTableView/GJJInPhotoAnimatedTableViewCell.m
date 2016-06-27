//
//  GJJInPhotoAnimatedTableViewCell.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJInPhotoAnimatedTableViewCell.h"
#import "GJJPhotoAnimatedView.h"

@interface GJJInPhotoAnimatedTableViewCell ()

@property (nonatomic, weak) GJJPhotoAnimatedView *photoAnimatedView;

@end


@implementation GJJInPhotoAnimatedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    GJJPhotoAnimatedView *photoAnimatedView = [[GJJPhotoAnimatedView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    [self.contentView addSubview:photoAnimatedView];
    self.photoAnimatedView = photoAnimatedView;
}

- (void)setPhotoUrlsArray:(NSArray *)photoUrlsArray
{
    _photoUrlsArray = photoUrlsArray;
    [self.photoAnimatedView setPhotoUrlsArray:photoUrlsArray];
    
}


@end
