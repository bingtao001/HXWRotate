//
//  HXWRotateView.h
//  HXWRotate
//
//  Created by huxingwang on 2017/2/25.
//  Copyright © 2017年 bingtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXWRotateView : UIView

@property (nonatomic, strong) NSMutableArray *elements;
@property (nonatomic, assign) float R;//半径

- (void)addElement:(UIView *)view;

- (void)deleteElement:(UIView *)view;

@end
