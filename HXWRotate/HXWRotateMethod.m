//
//  HXWRotateMethod.m
//  HXWRotate
//
//  Created by huxingwang on 2017/2/25.
//  Copyright © 2017年 bingtao. All rights reserved.
//

#import "HXWRotateMethod.h"
#import <Accelerate/Accelerate.h>
#import "HXWRotate-swift.h"

@implementation HXWRotateMethod

+ (CGPoint)calculateNewLocation:(CGPoint)point rotateParameter:(Rotate)rotate center:(CGPoint)center{
    //    利用旋转矩阵求新坐标
    double x = (point.x - center.x) * rotate.cosValue - (point.y - center.y) * rotate.sinValue;
    double y = (point.x - center.x) * rotate.sinValue + (point.y - center.y) * rotate.cosValue;
    return CGPointMake(x * rotate.scale + center.x, y* rotate.scale + center.y);
}

+ (Rotate)calculateRotatePrePosition:(CGPoint)prePoint current:(CGPoint)curPoint center:(CGPoint)center{
    CGPoint A0 = CGPointMake(prePoint.x - center.x, prePoint.y - center.y);
    CGPoint A1 = CGPointMake(curPoint.x - center.x, curPoint.y - center.y);
    //    利用向量点积求向量夹角的sin、cos值
    double dotProduct = A0.x * A1.x + A0.y * A1.y; //向量点积
    double cos = 0.0;
    double tempValue = (sqrtf(A0.x * A0.x + A0.y *A0.y) * sqrtf(A1.x * A1.x + A1.y * A1.y));
    
    if (tempValue) {
        cos = dotProduct / tempValue;
    }
    BOOL rotateDirection = [self isClockWiseOriPoint:center middlePoint:prePoint endPoint:curPoint];
    Rotate rotate;
    rotate.cosValue = cos;
    rotate.sinValue = cos <= 1 ? sqrtf(1 - cos * cos) : 0.0;//由于计算精度问题可能导致求得的cos略值大于1
    if (!rotateDirection) {
        //        NSLog(@"----------逆时针旋转");
        rotate.sinValue = rotate.sinValue * -1;
    }
    rotate.distance = sqrtf(A1.x * A1.x + A1.y * A1.y);
    if (sqrtf(A0.x * A0.x + A0.y *A0.y) != 0) {
        rotate.scale = sqrtf(A1.x * A1.x + A1.y * A1.y) / sqrtf(A0.x * A0.x + A0.y *A0.y);
    }
    return rotate;
}

+ (BOOL)isClockWiseOriPoint:(CGPoint)oriPoint middlePoint:(CGPoint)midPoint endPoint:(CGPoint)endPoint{
    CGPoint vector1 = CGPointMake(midPoint.x - oriPoint.x, midPoint.y - oriPoint.y);
    CGPoint vector2 = CGPointMake(endPoint.x - midPoint.x, endPoint.y - midPoint.y);
    
    double result = vector1.x * vector2.y - vector1.y * vector2.x;
    
    if (result >= 0) {
        return YES; //顺时针
    }
    return NO;
}

@end
