# YFStartView - simple iOS StartView

![GIFImage](http://7xkvt5.com1.z0.glb.clouddn.com/github/YFStartViewbuttom.gif) </br >
![GIFImage](http://7xkvt5.com1.z0.glb.clouddn.com/github/YFStartViewcenter.gif)

## Introduction

在启动图都是一个PNG的年代下，有强迫症的我已经受不了，设计交互大法好。
- iOS 8 and later
- ARC

## CocoaPods

[CocoaPods](http://cocoapods.org/) is the recommended way to use YFStartView in your project.

- Simply add this line to your `Podfile`:
```
platform :ios, '8.0'
pod 'YFStartView'
```
- Run `pod install`.
- Include with `#import "YFStartView.h"` to use it wherever you need.

## Manual installation

- Add `YFStartView` headers and implementations to your project (2 files total).
- Include with `#import "YFStartView.h"` to use it wherever you need.

## Usage

YFStartView使用起来很简单，但是需要你确定好样式，有三种方法配合LaunchScreen使用。

### Basic

property
```objective-c
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
```

methods
```objective-c
/**
 *  启动图片实例化
 */
+ (instancetype)startView;
/**
 *  开始设置YFStartView，启动函数
 */
- (void)configYFStartView;
```

### Method 1

不设置logo也不设置logo buttom view，直接使用动画。

此种方式推荐LaunchScreen.xib设置一张启动图片。

```objective-c
YFStartView *startView = [YFStartView startView];
startView.isAllowRandomImage = YES;
startView.randomImages = [NSMutableArray arrayWithObjects:@"startImage4", @"startImage2", @"startImage1", @"startImage3", nil];
[startView configYFStartView];
```

### Method 2

设置logo的类型，类似于Coding。

此种方式推荐LaunchScreen.xib background 为 block，且将logo.png设置在对应的位置，不会造成先出现黑色页面的情况，而是出现带有logo的LaunchScreen.xib再到YFStartView。

```objective-c
YFStartView *startView = [YFStartView startView];
startView.isAllowRandomImage = YES;
startView.randomImages = [NSMutableArray arrayWithObjects:@"startImage4", @"startImage2", @"startImage1", @"startImage3", nil];
//LogoPositionCenter
startView.logoPosition = LogoPositionCenter;
startView.logoImage = [UIImage imageNamed:@"logo"];
[startView configYFStartView];
```

### Method 3

设置logo buttom view的类型，类似支付宝。

此种方式推荐将Launch Screen File的xib 设置为自定义的xxx.xib，做到无缝连接。

```objective-c
YFStartView *startView = [YFStartView startView];
startView.isAllowRandomImage = YES;
startView.randomImages = [NSMutableArray arrayWithObjects:@"startImage4", @"startImage2", @"startImage1", @"startImage3", nil];
//LogoPositionCenter & UIView
startView.logoPosition = LogoPositionButtom;
StartButtomView *startButtomView = [[[NSBundle mainBundle] loadNibNamed:@"StartButtomView" owner:self options:nil] lastObject];
startView.logoView = startButtomView;
[startView configYFStartView];
```

## Athor

Created by Fan Ye .

Mail: yeziahehe@gmail.com

## License

YFStartView is available under the MIT license. See the LICENSE file for more info.
