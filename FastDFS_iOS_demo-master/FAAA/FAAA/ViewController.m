//
//  ViewController.m
//  FAAA
//
//  Created by linxiang on 2017/10/23.
//  Copyright © 2017年 minxing. All rights reserved.
//

#import "ViewController.h"

#import "FDFS_Upload_API.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    int retn = 0;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"111" ofType:@"JPG"];
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"conf"];

    
    BOOL res = [[NSFileManager defaultManager] fileExistsAtPath:path];
    BOOL res1 = [[NSFileManager defaultManager] fileExistsAtPath:path1];
    
    const char *filename = [path UTF8String];

    char file_id[500] = {0};

    retn = fdfs_upload_by_filename(filename,file_id);
    if(0 != retn)
    {
        printf("upload_by_filename err,errno = %d\n",retn);
    }

    printf("file_id = %s\n",file_id);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
