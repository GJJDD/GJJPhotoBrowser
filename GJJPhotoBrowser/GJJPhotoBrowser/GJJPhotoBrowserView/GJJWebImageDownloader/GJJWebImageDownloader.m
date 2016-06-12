//
//  GJJWebImageDownloader.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJWebImageDownloader.h"
#import <CommonCrypto/CommonDigest.h>
#import "GJJWebImageDownloadOperation.h"

static NSString *const kDefaultDiskCachePath = @"com.huwebimagedownloader";


FOUNDATION_STATIC_INLINE NSUInteger HUCacheCostForImage(UIImage *image) {
    return image.size.width * image.size.height *image.scale * image.scale;
}

@interface GJJWebImageDownloader () {
    int count;
}

@property (nonatomic, strong) NSCache *webImageCache;
@property (nonatomic) dispatch_queue_t ioQueue;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableDictionary *downloadOperations;

@end

@implementation GJJWebImageDownloader

+ (instancetype)sharedInstance {
    static GJJWebImageDownloader *downloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloader = [self new];
    });
    return downloader;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _webImageCache = [[NSCache alloc] init];
        _shouldCacheImagesInMemory = YES;
        [self createDefaultCachePath];
        _ioQueue = dispatch_queue_create("com.huwebimagedownloader.io", DISPATCH_QUEUE_SERIAL);
        _downloadOperations = [NSMutableDictionary dictionary];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMemory) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

+ (NSString *)cacheKeyForURL:(NSURL *)url {
    return [[GJJWebImageDownloader sharedInstance] cacheKeyForURL:url];
}

+ (UIImage *)imageFromDiskCacheForKey:(NSString *)key {
    return [[GJJWebImageDownloader sharedInstance] imageFromDiskCacheForKey:key];
}

+ (UIImage *)imageFromMemoryCacheForKey:(NSString *)key {
    return [[GJJWebImageDownloader sharedInstance] imageFromMemoryCacheForKey:key];
}

+ (GJJWebImageDownloadOperation *)downloadImageWithURL:(NSURL *)url completed:(GJJDownloadCompletionBlock)completeBlock {
    return[self downloadImageWithURL:url option:GJJWebImageOptionMemoryAndDisk completed:completeBlock];
}

+ (GJJWebImageDownloadOperation *)downloadImageWithURL:(NSURL *)url option:(GJJWebImageOption)option completed:(GJJDownloadCompletionBlock)completeBlock {
    return[[GJJWebImageDownloader sharedInstance] downloadImageWithURL:url option:option completed:completeBlock];
}

#pragma mark - save image

- (void)saveImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk {
    if (image == nil) {
        return;
    }
    if (toDisk) {
        NSData *imageData = UIImagePNGRepresentation(image);
        [self saveImage:imageData toDiskForKey:key];
    }
    
    [self saveImage:image toMemoryForKey:key];
}

#pragma mark - cache key for url

- (NSString *)cacheKeyForURL:(NSURL *)url {
    return [url absoluteString];
}

#pragma mark - the image from disk for key

- (UIImage *)imageFromDiskCacheForKey:(NSString *)key {
    
    UIImage *image = [self imageFromMemoryCacheForKey:key]; //first from memory
    if (image) {
        //NSLog(@"image from memory");
        return image;
    }
    UIImage *diskImage = [self diskImageForKey:key];
    if (diskImage && self.shouldCacheImagesInMemory) {
        ///NSLog(@"image from disk");
        NSUInteger cost = HUCacheCostForImage(diskImage);
        [self.webImageCache setObject:diskImage forKey:key cost:cost];
    }
    
    return diskImage;
}

#pragma mark - the image from memory for key

- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key {
    return [self.webImageCache objectForKey:key];
}

#pragma mark - download image for url whit option

- (GJJWebImageDownloadOperation *)downloadImageWithURL:(NSURL *)url option:(GJJWebImageOption)option completed:(GJJDownloadCompletionBlock)completeBlock {
    UIImage *image = [self imageFromDiskCacheForKey:[self cacheKeyForURL:url]];
    if (image) {
        if (completeBlock) {
            completeBlock(image, nil, url);
        }
        return nil;
    }
    GJJWebImageDownloadOperation *operation = self.downloadOperations[[self cacheKeyForURL:url]];
    __weak __typeof(self) wself = self;
    if (operation == nil) {
        operation = [[GJJWebImageDownloadOperation alloc] initWithURL:url completed:^(UIImage *image, NSData *data, NSError *error) {
            __strong __typeof(self) sself = wself;
            
            if (completeBlock) {
                completeBlock(image, nil, url);
            }
            
            if (image == nil)  return ;
//            count ++;
//            NSLog(@"count: %zd, down load image data: %zd",count, data.length/1024);

            [sself.downloadOperations removeObjectForKey:[self cacheKeyForURL:url]];
            
            if (option == GJJWebImageOptionMemoryAndDisk) {
                [sself saveImage:data toDiskForKey:[sself cacheKeyForURL:url]];
                [sself saveImage:image toMemoryForKey:[sself cacheKeyForURL:url]];
            }
            else if (option == GJJWebImageOptionMemoryOnely) {
                [sself saveImage:image toMemoryForKey:[sself cacheKeyForURL:url]];
            }
           
        }];
        
        [self.operationQueue addOperation:operation];
        [self.downloadOperations setValue:operation forKey:[self cacheKeyForURL:url]];
    }
    return operation;
}

#pragma mark - download image for url and store to disk

- (GJJWebImageDownloadOperation *)downloadImageWithURL:(NSURL *)url completed:(GJJDownloadCompletionBlock)completeBlock {
   return [self downloadImageWithURL:url option:GJJWebImageOptionMemoryAndDisk completed:completeBlock];
}

#pragma mark - parvate

- (void)saveImage:(UIImage *)image toMemoryForKey:(NSString *)key {
    UIImage *memoryImage = [self imageFromMemoryCacheForKey:key]; //first from memory
    if (memoryImage == nil && image) {
        NSUInteger cost = HUCacheCostForImage(image);
        [self.webImageCache setObject:image forKey:key cost:cost];
        //NSLog(@"save image to memory");
    }
}

#pragma mark - save image to disk

- (void)saveImage:(NSData *)imageData toDiskForKey:(NSString *)key {
    if (imageData == nil) {
        return;
    }
    UIImage *image = [self imageFromDiskCacheForKey:key];
    if (image) {
        return;
    }
    NSString *file = [self cacheFileForKey:key];
    dispatch_sync(_ioQueue, ^{
       // NSLog(@"save data to disk %@", file);
        [imageData writeToFile:file atomically:YES];
    });
}

- (UIImage *)diskImageForKey:(NSString *)key {
    NSString *fileName = [self cacheFileForKey:key];
    UIImage *img = [UIImage imageWithContentsOfFile:fileName];
    return img;
}

- (NSString *)cacheFileForKey:(NSString *)key {
    const char *cStr = [key UTF8String];
    unsigned char result[16];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString *md5Key = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
    NSString *cachePath = [self defaultCahePath];
    return [cachePath stringByAppendingPathComponent:md5Key];
}

- (BOOL)createDefaultCachePath {
    
    NSString *cachePath = [self defaultCahePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExit = [fileManager fileExistsAtPath:cachePath isDirectory:&isDir];
    if (!(isDir && isDirExit)) {
        if ([fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil]) {
            return NO;
        }
    }
    
    return isDirExit;
}

- (NSString *)defaultCahePath {
    
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [cacheDir stringByAppendingPathComponent:kDefaultDiskCachePath];
}

- (void)clearMemory {
    [self.webImageCache removeAllObjects];
    [self.downloadOperations removeAllObjects];
}

- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 5;
    }
    return _operationQueue;
}


@end
