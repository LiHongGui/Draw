//
//  DrawBoard.h
//  Draw
//
//  Created by lihonggui on 2016/12/12.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawBoard : UIView
@property(nonatomic,assign) CGFloat lineWidth;
@property(nonatomic,strong) UIColor *lineColor;

-(void)clearView;
-(void)backView;
-(void)eraserView;
@end
