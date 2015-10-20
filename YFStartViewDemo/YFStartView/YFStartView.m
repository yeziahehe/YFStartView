//
//  YFStartView.m
//  YFStartView
//
//  Created by 叶帆 on 15/10/19.
//  Copyright © 2015年 Suzhou Coryphaei Information&Technology Co., Ltd. All rights reserved.
//

#import "YFStartView.h"

#define kScreen_Bounds  [UIScreen mainScreen].bounds
#define kScreen_Height  [UIScreen mainScreen].bounds.size.height
#define kScreen_Width   [UIScreen mainScreen].bounds.size.width

@interface YFStartView ()
@property (nonatomic, strong) UIView *buttomView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@end

@implementation YFStartView

#pragma mark - Init Methods
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultValues];
    }
    return self;
}

+ (instancetype)startView {
    static YFStartView *startViewInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        startViewInstance = [[self alloc] initWithFrame:kScreen_Bounds];
    });
    return startViewInstance;
}

- (void)setupDefaultValues {
    self.backgroundColor = [UIColor blackColor];
    _logoPosition = LogoPositionNone;
    _isAllowRandomImage = NO;
    _randomImages = [NSMutableArray array];
}

#pragma mark - Setter Methods
- (void)setLogoView:(UIView *)logoView {
    if (_logoPosition == LogoPositionButtom) {
        _buttomView = [[UIView alloc] init];
        _buttomView = logoView;
        return;
    }
    NSAssert(0, @"设置logoView的YFStartView的logoPosition必须为LogoPositionButtom");
}

- (void)setLogoImage:(UIImage *)logoImage {
    if (_logoPosition == LogoPositionCenter) {
        _logoImage = logoImage;
        return;
    } else {
        _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width * 1/3)];
        _buttomView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:logoImage];
        imageView.frame = _buttomView.frame;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_buttomView addSubview:imageView];
        return;
    }
    NSAssert(0, @"设置logoView的YFStartView的logoPosition不可以为LogoPositionNone");
}

#pragma mark - Private Methods
- (UIImage *)startImage {
    if (_isAllowRandomImage && _randomImages.count > 0) {
        NSUInteger index = arc4random()%_randomImages.count;
        return [UIImage imageNamed:[_randomImages objectAtIndex:index]];
    } else if (!_isAllowRandomImage && _randomImages.count > 0) {
        return [UIImage imageNamed:[_randomImages objectAtIndex:0]];
    } else {
        NSAssert(0, @"YFStartView的randomImages为必填参数");
    }
    return nil;
}

#pragma mark - Public Methods
- (void)configYFStartView {
    _bgImageView = [[UIImageView alloc] initWithFrame:kScreen_Bounds];
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView.alpha = 0.0;
    _bgImageView.image = [self startImage];
    [self addSubview:_bgImageView];
    
    if (_logoPosition == LogoPositionCenter) {
        _logoImageView = [[UIImageView alloc] initWithImage:_logoImage];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_logoImageView];
        
        //为了防止Masonry重复引用，使用了系统autolayout
        [_logoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_logoImageView
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_logoImageView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1
                                                          constant:kScreen_Height/7]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_logoImageView
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1
                                                          constant:kScreen_Width/4 *2/3]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_logoImageView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1
                                                          constant:kScreen_Width *2/3]];
    } else if (_logoPosition == LogoPositionButtom) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:_buttomView];
        
        [_buttomView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_buttomView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_buttomView
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1
                                                          constant:kScreen_Width/_buttomView.frame.size.width*_buttomView.frame.size.height]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_buttomView
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeWidth
                                                        multiplier:1
                                                          constant:kScreen_Width]];
    }
    
    [self updateConstraintsIfNeeded];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    __weak YFStartView *weakself = self;
    [UIView animateWithDuration:2.0 animations:^{
        weakself.bgImageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            CGAffineTransform newTransform = CGAffineTransformMakeScale(1.2, 1.2);
            [weakself.bgImageView setTransform:newTransform];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                weakself.bgImageView.alpha = 0.0;
                [weakself removeFromSuperview];
            }];
        }];
    }];
}

@end
