//
//  UIImageView+GJJWebImage.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "UIImageView+GJJWebImage.h"
#import "GJJWebImageDownloadOperation.h"
#import "GJJWebImageDownloader.h"
#import <objc/runtime.h>

static char *loadOperationKey = "loadOperationKey";

@implementation UIImageView (GJJWebImage)

- (void)gjj_setImageWithURL:(NSURL *)url {
    [self gjj_setImageWithURL:url placeholderImage:nil];
}

- (void)gjj_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self gjj_setImageWithURL:url placeholderImage:placeholder completed:nil];
}

- (void)gjj_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(void (^)(UIImage *, NSError *, NSURL *))completed {
    self.image = nil;
    self.image = placeholder;
    [self gjj_cancelImageDownloadOperationForKey:@"downloadimage"];
    __weak __typeof(self) wself = self;
    GJJWebImageDownloadOperation *operation = [GJJWebImageDownloader downloadImageWithURL:url completed:^(UIImage *image, NSError *error, NSURL *imageUrl) {
        if (image) {
            wself.image = image;
            [wself setNeedsDisplay];
            [wself layoutIfNeeded];
        }
        else {
            wself.image = placeholder;
            [wself setNeedsDisplay];
            [wself layoutIfNeeded];
        }
        if (completed) {
            completed(image, error, imageUrl);
        }
    }];
    if (operation) {
        [self gjj_setImageDownloadOperation:operation forKey:@"downloadimage"];
    }

}

- (void)gjj_setImageDownloadOperation:(id)operation forKey:(NSString *)key {
    [self gjj_cancelImageDownloadOperationForKey:key];
    NSMutableDictionary *operations = [self operationDict];
    [operations setObject:operation forKey:key];
}

- (void)gjj_cancelImageDownloadOperationForKey:(NSString *)key {
    NSMutableDictionary *operations = [self operationDict];
    
    id operation = operations[key];
    if ([operation isKindOfClass:[GJJWebImageDownloadOperation class]]) {
        [operation cancel];
        operation = nil;
    }

}

- (NSMutableDictionary *)operationDict {
    NSMutableDictionary *operations = objc_getAssociatedObject(self, loadOperationKey);
    if (operations) {
        return operations;
    }
    operations = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, loadOperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return operations;
}

@end
