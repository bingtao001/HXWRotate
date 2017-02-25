//
//  HXWRotateMethod.h
//  HXWRotate
//
//  Created by huxingwang on 2017/2/25.
//  Copyright © 2017年 bingtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct {
    float cosValue;
    float sinValue;
    float distance;
    float scale;
}Rotate;

@interface HXWRotateMethod : NSObject

+ (CGPoint) calculateNewLocation:(CGPoint)point rotateParameter:(Rotate)rotate center:(CGPoint)center;

+ (Rotate) calculateRotatePrePosition:(CGPoint)prePoint current:(CGPoint)curPoint center:(CGPoint)center;

//检测当前是顺时针(YES)还是逆时针运动(NO)
+ (BOOL)isClockWiseOriPoint:(CGPoint)oriPoint middlePoint:(CGPoint) midPoint endPoint:(CGPoint)endPoint;

@end
