//
//  GJJWebImageDownloader.h
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GJJWebImageOption) {
    GJJWebImageOptionNone,
    GJJWebImageOptionMemoryOnely,
    GJJWebImageOptionMemoryAndDisk,
};

typedef void(^GJJDownloadCompletionBlock)(UIImage *image, NSError *error, NSURL *imageUrl);

@class GJJWebImageDownloadOperation;
@interface GJJWebImageDownloader : NSObject

+ (instancetype)sharedInstance;
+ (NSString *)cacheKeyForURL:(NSURL *)url;
+ (UIImage *)imageFromDiskCacheForKey:(NSString *)key;
+ (UIImage *)imageFromMemoryCacheForKey:(NSString *)key;
+ (GJJWebImageDownloadOperation *)downloadImageWithURL:(NSURL *)url completed:(GJJDownloadCompletionBlock)completeBlock;
+ (GJJWebImageDownloadOperation *)downloadImageWithURL:(NSURL *)url option:(GJJWebImageOption)option completed:(GJJDownloadCompletionBlock)completeBlock;

- (NSString *)cacheKeyForURL:(NSURL *)url;
- (UIImage *)imageFromDiskCacheForKey:(NSString *)key;
- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key;
- (void)saveImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk;


- (GJJWebImageDownloadOperation *)downloadImageWithURL:(NSURL *)url completed:(GJJDownloadCompletionBlock)completeBlock;


- (GJJWebImageDownloadOperation *)downloadImageWithURL:(NSURL *)url option:(GJJWebImageOption)option completed:(GJJDownloadCompletionBlock)completeBlock;

@property (nonatomic) BOOL shouldCacheImagesInMemory;

@end
