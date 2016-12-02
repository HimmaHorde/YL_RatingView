# YL_RatingView [![Build Status](https://travis-ci.org/GuiFoA/YL_RatingView.svg?branch=master)](https://travis-ci.org/GuiFoA/YL_RatingView)

- 星级评分，支持 xib，支持自动布局。
- 可点击评分和拖动评分。
- 可设置评分精度，一颗星、半颗星或者精确到小数

## Requirements
YLRatingView works on iOS 7+ and requires ARC to build. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

Foundation.framework
UIKit.framework

## Adding YLRatingView to your project
- Installation with CocoaPods：`pod 'YLRatingView', '~> 1.0'`
- Import the main file：`#import "YLStarRating.h"`

## Usage
###### Init
```objective-c
    YLStarRating * halfRatingview = [[YLStarRating alloc] initWithFrame:frame numberOfStar:6];
    
    halfRatingview.delegate = self;
    
    halfRatingview.displayStatus = YLStarDisplayStatusHalf;
    
    [self.view addSubview:halfRatingview];
```
