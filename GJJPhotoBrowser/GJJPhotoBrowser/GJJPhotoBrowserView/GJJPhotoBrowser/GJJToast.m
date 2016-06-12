//
//  GJJToast.m
//  GJJPhotoBrowser
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 QiaTu HangZhou. All rights reserved.
//

#import "GJJToast.h"
#import "gjj_const.h"
#import "UIView+frame.h"

const static NSTimeInterval kDefaultDuration = 1.0;

@interface GJJToast () {
    BOOL _didHiden;
}

@property (nonatomic, weak) UILabel *msgLab;

@end

@implementation GJJToast

+ (instancetype)toast {
    static GJJToast *toast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[self alloc] init];
    });
    return toast;
}

+ (void)showToastWithMsg:(NSString *)msg {
    [[GJJToast toast] showToastWithMsg:msg];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self  =[super initWithFrame:frame];
    if (self) {
        _didHiden = YES;
        self.alpha = 0;
        self.frame = CGRectMake((kScreenWidth-80)/2, (kScreenHeight-50)/2, 100, 30);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        self.layer.cornerRadius = 6;
        UILabel *msgLab = [[UILabel alloc] initWithFrame:self.bounds];
        msgLab.textColor = [UIColor whiteColor];
        msgLab.font = [UIFont systemFontOfSize:13];
        msgLab.numberOfLines = 0;
        msgLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:msgLab];
        _msgLab = msgLab;
    }
    return self;
}

- (void)showToastWithMsg:(NSString *)msg {
    if (!_didHiden) {
        return;
    }
    
    CGFloat width = [msg sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}].width+16;
    self.width = width;
    self.msgLab.width = width;
    self.msgLab.text = msg;
    [self showToast];
}
- (void)showToast {
    _didHiden = NO;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:[GJJToast toast]];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:kDefaultDuration target:self selector:@selector(hideToash:) userInfo:nil repeats:NO];
    }];
}

- (void)hideToash:(NSTimer *)timer {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _didHiden = YES;
        [timer invalidate];
       
    }];
}

@end
