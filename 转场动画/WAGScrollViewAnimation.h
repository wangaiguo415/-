//
//  WAGScrollViewAnimation.h
//  转场动画
//
//  Created by wangaiguo on 16/3/28.
//  Copyright © 2016年 wangaiguo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , pageControlPosition){
    pageControlPositionMiddle,
    pageControlPositionRight
};
@protocol WagScrollAnimationDelegate <NSObject>

-(void)setdidTapCurrentImage:(NSInteger)currentIndex;

@end
@interface WAGScrollViewAnimation : UIView

@property (nonatomic,strong)NSArray *imageArr;
@property (nonatomic,assign)pageControlPosition postion;
@property (nonatomic,assign)BOOL showPageControl;
@property (nonatomic,assign)BOOL automaticScroll;
@property (nonatomic,weak)id<WagScrollAnimationDelegate>delegate;
@end
