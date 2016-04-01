//
//  WAGScrollViewAnimation.m
//  转场动画
//
//  Created by wangaiguo on 16/3/28.
//  Copyright © 2016年 wangaiguo. All rights reserved.
//

#import "WAGScrollViewAnimation.h"

@interface WAGScrollViewAnimation (){
    UIImageView * _imageView;
    int _currentIndex;
    int totalCount;
    UIPageControl *_pageControl;
    NSTimer *_timer;
}

@end

@implementation WAGScrollViewAnimation

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeImageView];
//        [self makePageControl];
        
           }
    return self;
}
- (void)makeImageView{
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = self.frame;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.image = [UIImage imageNamed:@"0.jpg"];
    [_imageView setUserInteractionEnabled:YES];
    [self addSubview:_imageView];
    _currentIndex = 0;
    //添加手势
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwip.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:rightSwip];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
    [_imageView addGestureRecognizer:tap];

}
- (void)makePageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height - 15);
        _pageControl.numberOfPages = totalCount;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor greenColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:_pageControl];
    }
}
-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    totalCount = (int)imageArr.count;
    _pageControl.numberOfPages= totalCount;
}
-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}

-(void)transitionAnimation:(BOOL)isNext{
    CATransition *transiton = [[CATransition alloc]init];
    transiton.type = @"suckEffect";
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
        _currentIndex = (_currentIndex + 1)%totalCount;
    }else{
        _currentIndex = (_currentIndex - 1 + totalCount)%totalCount;
    }
    _pageControl.currentPage = _currentIndex;
    [_timer invalidate];
    _timer = nil;
    if (_automaticScroll) {
        [self setAutomaticScroll:YES];
    }
    return [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",_currentIndex]];
}
-(void)setPostion:(pageControlPosition)postion{
    _postion = postion;
    switch (postion) {
        case pageControlPositionMiddle:
            [self makePageControl];
            break;
            case pageControlPositionRight:
            [self makePageControl];
            CGRect frame = _pageControl.frame;
            frame.origin.x = self.bounds.size.width - [_pageControl sizeForNumberOfPages:totalCount].width + 30;
            _pageControl.frame = frame;
            break;
            
        default:
            break;
    }
}
-(void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl = showPageControl;
    if (_showPageControl) {
        [self makePageControl];
    }else{
        
    }
}

- (void)setAutomaticScroll:(BOOL)automaticScroll{
    _automaticScroll = automaticScroll;
    _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
//    [[NSRunLoop currentRunLoop]run];
}
- (void)nextImage{
    [self transitionAnimation:YES];
}
- (void)tapImage{
    if ([self.delegate respondsToSelector:@selector(setdidTapCurrentImage:)]) {
        [self.delegate setdidTapCurrentImage:_currentIndex];
    }
    [_timer invalidate];
    _timer = nil;
    if (_automaticScroll) {
        [self setAutomaticScroll:YES];
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    if ([touch.view isKindOfClass:[UIImageView class]]) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    if ([touch.view isKindOfClass:[UIImageView class]]) {
        [self setAutomaticScroll:YES];
    }
}
@end
