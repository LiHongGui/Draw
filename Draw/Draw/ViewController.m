//
//  ViewController.m
//  Draw
//
//  Created by lihonggui on 2016/12/12.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import "ViewController.h"
#import "DrawBoard.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+CZ.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet DrawBoard *drawBoard;


@property (weak, nonatomic) IBOutlet UISlider *sliderValue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置默认状态
    self.drawBoard.lineWidth = self.sliderValue.value;
    
}
#pragma mark
#pragma mark -  画笔宽
- (IBAction)slider:(UISlider *)sender {
    self.drawBoard.lineWidth = self.sliderValue.value;
    
}
#pragma mark
#pragma mark -  画笔颜色
- (IBAction)butotnColor:(UIButton *)sender {
    self.drawBoard.lineColor = sender.backgroundColor;
}
#pragma mark
#pragma mark -  清屏
- (IBAction)clearView:(UIButton *)sender {
  //直接调用
    [self.drawBoard clearView];
}
#pragma mark
#pragma mark -  返回上一步
- (IBAction)backView:(UIButton *)sender {
    [self.drawBoard backView];
}
#pragma mark
#pragma mark -  橡皮擦
- (IBAction)eraser:(UIButton *)sender {
    [self.drawBoard eraserView];
}
#pragma mark
#pragma mark -  保存---到相册
- (IBAction)saveButton:(UIButton *)sender {
    
    //延时
   [UIView animateWithDuration:1 animations:^{
       //开启图形上下文
       UIGraphicsBeginImageContextWithOptions(self.drawBoard.frame.size, YES, 0);
       //获取图形上下文
       CGContextRef context = UIGraphicsGetCurrentContext();
       //获取路径
       //    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
       ////    拼接图片文件
       //    NSString *photo = [document stringByAppendingPathComponent:@"name.png"];
       //将veiw绘制到图像上下文中
       [self.view.layer renderInContext:context];
       //获取图片
       UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
       UIImageWriteToSavedPhotosAlbum(getImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
       self.view.alpha = 0.5;
   } completion:^(BOOL finished) {
       self.view.alpha = 1;
   }];
    
    }

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void  *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:@"图片保存失败"];
//        NSLog(@"图片爆保存失败");
    }else
    {
        [MBProgressHUD showSuccess:@"图片保存成功" ];
//        NSLog(@"图片保存成功");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
