//
//  ViewController.m
//  YLRatingView
//
//  Created by lin on 2016/12/2.
//  Copyright © 2016年 YangLin. All rights reserved.
//

#import "ViewController.h"
#import "YLStarRating.h"

@interface ViewController ()<YLStarRatingDelegate>

@property (weak, nonatomic) IBOutlet YLStarRating *xibRatingView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    YLStarRating * halfRatingview = [[YLStarRating alloc] initWithFrame:frame numberOfStar:6];
    
    halfRatingview.delegate = self;
    
    halfRatingview.displayStatus = YLStarDisplayStatusHalf;
    
    [self.view addSubview:halfRatingview];
    
}


- (void)starRatingView:(YLStarRating *)view score:(float)score
{
    [UIView animateWithDuration:1
                     animations:^{
                         _scoreLabel.text = [NSString stringWithFormat:@"%g",score];
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
