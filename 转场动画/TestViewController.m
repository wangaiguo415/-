//
//  TestViewController.m
//  转场动画
//
//  Created by wangaiguo on 16/3/28.
//  Copyright © 2016年 wangaiguo. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/2.0, self.view.bounds.size.width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
//    label.text = [NSString stringWithFormat:@"您点击的是第%ld张图片",(long)self.currentIndex];
    label.attributedText = [self releplace:[NSString stringWithFormat:@"您点击的是第%ld张图片",(long)self.currentIndex]];
    [self.view addSubview:label];
}

- (NSMutableAttributedString *)releplace:(NSString *)texts{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:texts];
    [string addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:NSMakeRange(6, 1)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(6, 1)];
    return string;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
