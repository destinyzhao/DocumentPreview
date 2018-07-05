//
//  ViewController.m
//  DocumentPreview
//
//  Created by Destiny on 2018/7/5.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)thirdPartAppAction:(UIButton *)sender {
    [self thirdAppPreview];
}

- (void)thirdAppPreview
{
    NSString *docPath = @"";
    
    // 数据库路径-沙盒路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"test.xlsx"];
    
    // 复制本地数据到沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:fileName]) {
        // 获得数据库文件在工程中的路径——源路径。
        docPath = [[NSBundle mainBundle] pathForResource:@"test"ofType:@"xlsx"];
        
        NSError *error ;
        
        if ([fileManager copyItemAtPath:docPath toPath:fileName error:&error]) {
            NSLog(@"数据库移动成功");
        } else {
            NSLog(@"数据库移动失败");
        }
    }
    
    //获取路径文件url
    NSURL*fileUrl = [NSURL fileURLWithPath:fileName];
    
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[fileUrl];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
}
@end
