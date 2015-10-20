//
//  YFStartView.h
//  YFStartView
//
//  Created by 叶帆 on 15/10/19.
//  Copyright © 2015年 Suzhou Coryphaei Information&Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LogoPosition) {
    LogoPositionNone,
    LogoPositionCenter,
    LogoPositionButtom,
};

@interface YFStartView : UIView

/**
 *  logo位置，默认为LogoPositionNone，非必需
 */
@property (nonatomic, assign) LogoPosition logoPosition;
/**
 *  是否允许随机启动图片，默认为NO，非必需
 *  Note:
 *     1.若randomImages为0或1，则不允许随机图片
 *     2.若randomImages大于1，设置为随机图片则随机取，未设置则默认取第一张
 */
@property (nonatomic, assign) BOOL isAllowRandomImage;
/**
 *  启动图片数组，数组为NSString，图片名称，必填
 *  挖坑: 目前不支持从服务器取图片，只支持本地图片
 */
@property (nonatomic, copy) NSMutableArray *randomImages;
/**
 *  logo image，在LogoPositionCenter和LogoPositionButtom下设置均可
 */
@property (nonatomic, copy) UIImage *logoImage;
/**
 *  logo view，只在LogoPositionButtom下设置
 */
@property (nonatomic, strong) UIView *logoView;

/**
 *  启动图片实例化
 */
+ (instancetype)startView;
/**
 *  开始设置YFStartView，启动函数
 */
- (void)configYFStartView;

@end
