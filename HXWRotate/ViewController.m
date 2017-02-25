//
//  ViewController.m
//  HXWRotate
//
//  Created by huxingwang on 2017/2/25.
//  Copyright © 2017年 bingtao. All rights reserved.
//

#import "ViewController.h"
#import "HXWRotateView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet HXWRotateView *rotateView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (IBAction)addElement:(UIButton *)sender {
    [self.rotateView addElement:nil];
}

- (IBAction)deleteElement:(UIButton *)sender {
    [self.rotateView deleteElement:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
