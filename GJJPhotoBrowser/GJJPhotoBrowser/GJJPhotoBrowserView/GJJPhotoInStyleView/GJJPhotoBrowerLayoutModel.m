//
//  GJJPhotoBrowerLaoutModel.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJPhotoBrowerLayoutModel.h"
#define KContentWidth (self.contentWidth?:[UIScreen mainScreen].bounds.size.width)
// 1张大图的高度
#define kBigImageHeight kImageWH(3)*2+kContentSpace
// 2张小图的宽高
#define kTwoSmallImageWH kImageWH(2)
// 3张小图的宽高
#define kThreeSmallImageWH kImageWH(3)
// 4张小图的宽高
#define kfourSmallImageWH kImageWH(4)

#define kImageWH(nums) (KContentWidth-kLeftSpace-kContentSpace*(nums-1)-kRightSpace)/nums

#define kContentSpace (_contentInset?:0)
#define kTopSpace (_topInset?:0)
#define kLeftSpace (_leftInset?:0)
#define kBottonSpace (_bottomInset?:0)
#define kRightSpace (_rightInset?:0)

@interface GJJPhotoBrowerLayoutModel ()
@property (nonatomic, assign) NSInteger imageNums; // 图片数量
@end


@implementation GJJPhotoBrowerLayoutModel
- (instancetype)initWithPhotoUrlsArray:(NSArray *)photoUrlsArray ContentWidth:(CGFloat)contentWidth andEdgeInsets:(UIEdgeInsets)edgeInsets andContentInset:(CGFloat)contentInset andOrigin:(CGPoint)origin
{
    if (self = [super init]) {
        _origin = origin;
        _photoUrlsArray = photoUrlsArray;
        _contentWidth = contentWidth;
        _contentInset = contentInset;
        _topInset = edgeInsets.top;
        _leftInset = edgeInsets.left;
        _bottomInset = edgeInsets.bottom;
        _rightInset = edgeInsets.right;
        self.imageNums = photoUrlsArray.count;
    }
    
    return self;

}




- (CGFloat)contentHeight
{
    CGFloat contentHeight = 0;
    
    if (self.imageNums==0) {
        contentHeight = 0;
    } else if (self.imageNums==1 || self.imageNums==2) {
        contentHeight = kTopSpace+(kBigImageHeight+kContentSpace)*(self.imageNums-1)+kBigImageHeight+kBottonSpace;
    } else if (self.imageNums==3) {
        contentHeight = kTopSpace+kContentSpace+kTwoSmallImageWH+kBigImageHeight+kBottonSpace;
    } else if (self.imageNums==4) {
        contentHeight = kTopSpace+kContentSpace+kBigImageHeight+kThreeSmallImageWH+kBottonSpace;
    } else if (self.imageNums==5) {
        contentHeight = kContentSpace+kTopSpace+kBigImageHeight+kTwoSmallImageWH+kBottonSpace;
    } else if (self.imageNums==6) {
        contentHeight = kContentSpace+kTopSpace+kBigImageHeight+kThreeSmallImageWH+kBottonSpace;
    } else if (self.imageNums==7) {
        contentHeight = kTopSpace+kContentSpace*2+kBigImageHeight+kThreeSmallImageWH+kThreeSmallImageWH+kBottonSpace;
    } else if (self.imageNums==8) {
        
        contentHeight = kContentSpace*2+kTopSpace+(kTwoSmallImageWH)+(kThreeSmallImageWH)+kThreeSmallImageWH+kBottonSpace;
    } else if (self.imageNums==9) {
        contentHeight = kContentSpace*2+kTopSpace+kBigImageHeight+kfourSmallImageWH+(kfourSmallImageWH)+kBottonSpace;
    }
    return contentHeight;
}







- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath andNumberOfCellsInSection:(NSInteger)numberOfCellsInSection
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /*
     图片样式
     1：一张大图
     2：上一张图，下一张图
     3：上一张大图，下两张小图
     4：上一张大图，下三张小图
     5：上左一张大图，上右 上下 两张小图 ，下两张小图
     6：上左一张大图，上右 上下 两张小图 ，下三张小图
     7：上一张大图，下六张小图
     8：上左右两张大图， 下六张小图
     9：上一张大图， 下八张小图
     
     */
    
    
    switch (numberOfCellsInSection) {
        case 0:break;
        case 1:case 2:
        {
            attribute.frame = CGRectMake(kLeftSpace, kTopSpace+(kBigImageHeight+kContentSpace)*indexPath.item, KContentWidth-kLeftSpace-kTopSpace, kBigImageHeight);
        }
            break;
        case 3:
        {
            if (indexPath.item==0) {
                attribute.frame = CGRectMake(kLeftSpace, kTopSpace, KContentWidth-kLeftSpace-kRightSpace, kBigImageHeight);
            } else{
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kTwoSmallImageWH)*(indexPath.item-1), kTopSpace+(kContentSpace+kBigImageHeight), kTwoSmallImageWH, kTwoSmallImageWH);
            }
        }
            break;
        case 4:
        {
            if (indexPath.item==0) {
                attribute.frame = CGRectMake(kLeftSpace, kTopSpace, KContentWidth-kLeftSpace-kRightSpace, kBigImageHeight);
            } else {
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kThreeSmallImageWH)*(indexPath.item-1), kTopSpace+kContentSpace+kBigImageHeight, kThreeSmallImageWH, kThreeSmallImageWH);
            }
        }
            break;
        case 5:
        {
            if (indexPath.item==0) {
                attribute.frame = CGRectMake(kLeftSpace, kTopSpace, kBigImageHeight, kBigImageHeight);
            } else if (indexPath.item==1 || indexPath.item==2) {
                attribute.frame = CGRectMake(kLeftSpace+kBigImageHeight+kContentSpace, kTopSpace+(kContentSpace+kThreeSmallImageWH)*(indexPath.item-1), kThreeSmallImageWH,kThreeSmallImageWH);
            } else {
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kTwoSmallImageWH)*(indexPath.item-3), kContentSpace+kTopSpace+kBigImageHeight, kTwoSmallImageWH, kTwoSmallImageWH);
            }
        }
            break;
        case 6:
        {
            if (indexPath.item==0) {
                attribute.frame = CGRectMake(kLeftSpace, kTopSpace, kBigImageHeight, kBigImageHeight);
            } else if (indexPath.item==1 || indexPath.item==2) {
                attribute.frame = CGRectMake(kLeftSpace+kBigImageHeight+kContentSpace, kTopSpace+(kContentSpace+kThreeSmallImageWH)*(indexPath.item-1), kThreeSmallImageWH,kThreeSmallImageWH);
            }else {
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kThreeSmallImageWH)*(indexPath.item-3), kContentSpace+kTopSpace+kBigImageHeight, kThreeSmallImageWH, kThreeSmallImageWH);
            }
        }
            
            
            break;
        case 7:
        {
            if (indexPath.item==0) {
                attribute.frame = CGRectMake(kLeftSpace, kTopSpace, KContentWidth-kLeftSpace-kRightSpace, kBigImageHeight);
            } else if (indexPath.row==1 || indexPath.row==2 || indexPath.row==3) {
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kThreeSmallImageWH)*(indexPath.item-1), kContentSpace+kTopSpace+kBigImageHeight, kThreeSmallImageWH, kThreeSmallImageWH);
            } else {
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kThreeSmallImageWH)*(indexPath.item-4), (kContentSpace+kTopSpace+kBigImageHeight)+(kThreeSmallImageWH)+kContentSpace, kThreeSmallImageWH, kThreeSmallImageWH);
            }
        }
            break;
        case 8:
        {
            if (indexPath.row==0 || indexPath.row==1) {
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kTwoSmallImageWH)*indexPath.item, kTopSpace, kTwoSmallImageWH, kTwoSmallImageWH);
                
            }else if (indexPath.row==2 || indexPath.row==3 || indexPath.row==4) {
                
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kThreeSmallImageWH)*(indexPath.item-2), kContentSpace+kTopSpace+kTwoSmallImageWH, kThreeSmallImageWH, kThreeSmallImageWH);
            }else {
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kThreeSmallImageWH)*(indexPath.item-5), kContentSpace*2+kTopSpace+(kTwoSmallImageWH)+(kThreeSmallImageWH), kThreeSmallImageWH, kThreeSmallImageWH);
            }
        }
            break;
        case 9:
        {
            if (indexPath.item==0) {
                attribute.frame = CGRectMake(kLeftSpace, kTopSpace, KContentWidth-kLeftSpace-kRightSpace, kBigImageHeight);
            } else if(indexPath.item==1 || indexPath.item==2 || indexPath.item==3 || indexPath.item==4) {
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kfourSmallImageWH)*(indexPath.item-1), kTopSpace+kContentSpace+kBigImageHeight, kfourSmallImageWH, kfourSmallImageWH);
            }else {
                attribute.frame = CGRectMake(kLeftSpace+(kContentSpace+kfourSmallImageWH)*(indexPath.item-5), kTopSpace+kContentSpace*2+kBigImageHeight+kfourSmallImageWH, kfourSmallImageWH, kfourSmallImageWH);
            }
        }
            break;
        default:
            break;
    }
    
    
    
    return attribute;
}




@end
