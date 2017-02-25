//
//  HXWRotateView.m
//  HXWRotate
//
//  Created by huxingwang on 2017/2/25.
//  Copyright © 2017年 bingtao. All rights reserved.
//

#import "HXWRotateView.h"
#import "HXWRotateMethod.h"

@interface HXWRotateView ()

@end

@implementation HXWRotateView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initViewProperty];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViewProperty];
    }
    return self;
}

- (void)initViewProperty{
    self.backgroundColor = [UIColor darkGrayColor];
    _R = 100;
    _elements = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        [self addElement:nil];
    }
}

- (void)addElement:(UIView *)view{
    NSInteger count = self.elements.count;
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        view.backgroundColor = [self randomColor];
        view.tag = count;
        UILabel *showTagLabel = [[UILabel alloc] initWithFrame:view.frame];
        showTagLabel.text = [NSString stringWithFormat:@"%ld",(long)view.tag];
        showTagLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:showTagLabel];
        [self addSubview:view];
    }
    [self.elements addObject:view];
    
    [self relayoutElementPosition];
}

- (void)relayoutElementPosition{
    NSInteger count = self.elements.count;
    if (count == 0) {
        return;
    }
    for (int i = 0; i < count; i++) {
        UIView *tempView = self.elements[i];
        double x = _R * cos((2 * M_PI / count) * i) + self.center.x - 20;
        double y = _R * sin((2 * M_PI / count) * i) + self.center.y - 20;
        [UIView animateWithDuration:0.01 animations:^{
            tempView.center = CGPointMake(x, y);
        }];
    }
    [self setNeedsLayout];
}

- (void)deleteElement:(UIView *)view{
    if (self.elements.count > 2) {
        [self.elements.lastObject removeFromSuperview];
        [self.elements removeLastObject];
        [self relayoutElementPosition];
    }
}

- (UIColor *)randomColor{
    float red = arc4random() % 255 /255.0;
    float green = arc4random() % 255 /255.0;
    float blue = arc4random() % 255 /255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint prePoint = [touch previousLocationInView:self];
    CGPoint curPoint = [touch locationInView:self];
    Rotate rotate = [HXWRotateMethod calculateRotatePrePosition:prePoint current:curPoint center:self.center];
    [self rotateAnimation:rotate];
}

- (void)rotateAnimation:(Rotate)rotate{
    if (self.elements.count) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.01 animations:^{
            for (UIView *tempView in weakSelf.elements) {
                tempView.center = [HXWRotateMethod calculateNewLocation: tempView.center rotateParameter:rotate center:weakSelf.center];
            }
        }];
    }
}

@end
