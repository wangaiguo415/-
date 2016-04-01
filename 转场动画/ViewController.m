//
//  ViewController.m
//  转场动画
//
//  Created by wangaiguo on 16/3/25.
//  Copyright © 2016年 wangaiguo. All rights reserved.
//

#import "ViewController.h"
#import "WAGScrollViewAnimation.h"
#import "TestViewController.h"
#define IMAGE_COUNT 5
@interface ViewController ()<WagScrollAnimationDelegate>{
    UIImageView * _imageView;
    int _currentIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WAGScrollViewAnimation * wagLayerView = [[WAGScrollViewAnimation alloc]initWithFrame:self.view.bounds];
    wagLayerView.imageArr = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    wagLayerView.showPageControl = YES;
    wagLayerView.postion = pageControlPositionRight;
    wagLayerView.automaticScroll = YES;
    wagLayerView.delegate = self;
    [self.view addSubview:wagLayerView];
    
//    [self makeImageView];
}

- (void)makeImageView{
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = [UIScreen mainScreen].bounds;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.image = [UIImage imageNamed:@"0.jpg"];
    [_imageView setUserInteractionEnabled:YES];
    [self.view addSubview:_imageView];
    _currentIndex = 0;
    //添加手势
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwip.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:rightSwip];
}

-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}

-(void)transitionAnimation:(BOOL)isNext{
    CATransition *transiton = [[CATransition alloc]init];
    transiton.type = @"rippleEffect";
    /*
     type 类型
     公开API：
     kCATransitionFade    kCATransitionMoveIn    kCATransitionPush     kCATransitionReveal
     
     私有API：  只能通过字符串访问
     cube    oglflip   suckEffect   rippleEffect   pageCurl   pageUnCurl   
     cameralIrisHollowOpen   cameraIrisHollowClose
     */
    if (isNext) {
        transiton.subtype = kCATransitionFromRight;
    }else{
        transiton.subtype = kCATransitionFromLeft;
    }
    transiton.duration = 1.0f;
    _imageView.image = [self getImage:isNext];
    [_imageView.layer addAnimation:transiton forKey:@"zhuanchangAnimation"];
}

- (UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
        _currentIndex = (_currentIndex + 1)%IMAGE_COUNT;
    }else{
        _currentIndex = (_currentIndex - 1 + IMAGE_COUNT)%IMAGE_COUNT;
    }
    return [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",_currentIndex]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setdidTapCurrentImage:(NSInteger)currentIndex{
    TestViewController *test = [[TestViewController alloc]init];
    test.currentIndex = currentIndex;
    [self presentViewController:test animated:YES completion:nil];
    NSLog(@"%ld",(long)currentIndex);
}
@end
