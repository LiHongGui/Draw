//
//  DrawBoard.m
//  Draw
//
//  Created by lihonggui on 2016/12/12.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import "DrawBoard.h"
#import "DrawBezier.h"
@interface DrawBoard ()
@property(nonatomic,strong) NSMutableArray *paths;

@end
@implementation DrawBoard

#pragma mark
#pragma mark -  懒加载
-(NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
        
    }
    return _paths;
}
#pragma mark
#pragma mark -  清屏
-(void)clearView
{
    //删除数组中的所有元素
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}
#pragma mark
#pragma mark -  返回上一步
-(void)backView
{
    //删除数组中最后添加的数组
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
#pragma mark
#pragma mark -  橡皮擦
-(void)eraserView
{
    //橡皮擦的轨迹颜色----背景颜色
    self.lineColor = self.backgroundColor;
    NSLog(@"backgroundColor%@",self.backgroundColor);
}
#pragma mark
#pragma mark -  开始触摸画板
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    //绘画路径
    DrawBezier *path = [[DrawBezier alloc]init];
    path.lineWidth = self.lineWidth;
    path.lineColor = self.lineColor;
    //添加路径
    [path moveToPoint:point];
    //添加到数组中
    [self.paths addObject:path];
}
#pragma mark
#pragma mark -  移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取触摸点
    UITouch *touch = touches.anyObject;
    CGPoint point  =[touch locationInView:touch.view];
    [[self.paths lastObject]addLineToPoint:point];
    [self setNeedsDisplay];
    
}
#pragma mark
#pragma mark -  手指抬起
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    //获取图形上下文----画三角形
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextMoveToPoint(context, 100, 100);
//    CGContextAddLineToPoint(context, 100, 400);
//    CGContextAddLineToPoint(context, 400, 300);
//    CGContextClosePath(context);
//    CGContextStrokePath(context);
    
    //绘画---for 循环
    for (DrawBezier *path in self.paths) {
//        [path stroke];
        [path.lineColor set];
        path.lineCapStyle = kCGLineCapRound;
        path.lineJoinStyle = kCGLineJoinRound;
        [path stroke];
    }
    
}

@end
