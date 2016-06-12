//
//  GJJWebImageDownloadOperation.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GJJWebImageDownloadCompltedBlock) (UIImage *image, NSData *data, NSError *error);

@interface GJJWebImageDownloadOperation : NSOperation

- (instancetype)initWithURL:(NSURL *)url completed:(GJJWebImageDownloadCompltedBlock)completedBlock;

@end
