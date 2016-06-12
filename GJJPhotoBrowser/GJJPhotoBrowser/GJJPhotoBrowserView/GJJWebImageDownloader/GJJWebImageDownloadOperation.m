//
//  GJJWebImageDownloadOperation.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//
#import "GJJWebImageDownloadOperation.h"
#import "UIImage+GJJExtension.h"

@interface GJJWebImageDownloadOperation ()

@property (nonatomic, copy) GJJWebImageDownloadCompltedBlock completedBlock;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation GJJWebImageDownloadOperation

- (instancetype)initWithURL:(NSURL *)url completed:(GJJWebImageDownloadCompltedBlock)completedBlock {
    if (self = [super init]) {
        _url = url;
        _completedBlock = completedBlock;
    }
    return self;
}

- (void)main {
    
    @autoreleasepool {
        if (self.isCancelled) {
            [self reset];
            return;
        }
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration];
        
        NSURLRequest *repuest = [NSURLRequest requestWithURL:_url];
        __weak __typeof(self) wself = self;
        NSURLSessionDataTask *task = [_session dataTaskWithRequest:repuest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            __strong __typeof(self) sself = wself;
            if (!sself.completedBlock) {
                return ;
            }
            
            if (data == nil) {
                sself.completedBlock(nil, nil, error);
                return ;
            }
            
            if (sself.isCancelled) {
                [sself reset];
                return;
            }
            
            UIImage *image = [UIImage gjj_imageFromData:data];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                sself.completedBlock(image, data, nil);
            }];
            
        }];
        [task resume];

    }
    
}

- (void)reset {
    self.completedBlock = nil;
    [[self.session dataTaskWithURL:_url] cancel];
}

@end
