//
//  ViewController.m
//  短信倒计时
//
//  Created by suge on 2017/7/18.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "VerificationCodeVC.h"

@interface ViewController ()
@property (strong, nonatomic) UIButton *sendButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(100, 200, 200, 50);
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendButton];

    
}
#pragma mark - 发送短信按钮
- (void)sendButtonClick:(UIButton *)sender {
    
    
    VerificationCodeVC *vc = [[VerificationCodeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
