//
//  TestViewController.m
//  短信倒计时
//
//  Created by suge on 2017/7/18.
//  Copyright © 2017年 郑州鹿客互联网科技有限公司. All rights reserved.
//

#import "VerificationCodeVC.h"

@interface VerificationCodeVC ()
@property (strong, nonatomic) UIButton *sendButton;
@end

@implementation VerificationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.frame = CGRectMake(100, 200, 200, 50);
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [_sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendButton];
    
    
    //倒计时5分钟后的时间戳（从点击发送验证码按钮开始计时）
    NSInteger futureTime = [[[NSUserDefaults standardUserDefaults] objectForKey:@"futureTime"] integerValue];
    //已经触发过发送验证码按钮了
    if (futureTime > 0) {//验证码未失效不用再次发送，此时发送验证码按钮的交互性为NO
        [self changeButtonTitle];
    }
    
    
    
}
#pragma mark - 发送短信按钮
- (void)sendButtonClick:(UIButton *)sender {

    
    //处理发送验证码逻辑
    
    
    
#warning ----验证码发送成功后再执行下边的代码----
    
    //当前的时间戳
    NSDate *date = [NSDate date];
    NSInteger timeInterval = (NSInteger)[date timeIntervalSince1970];
    //倒计时5分钟后的时间戳（从点击发送验证码按钮开始计时）
    NSInteger futureTime = (NSInteger)(timeInterval + 5*60);
    [[NSUserDefaults standardUserDefaults] setInteger:futureTime forKey:@"futureTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self changeButtonTitle];
    
}
#pragma mark - 发送按钮的标题倒计时
- (void)changeButtonTitle
{
    NSDate *date = [NSDate date];
    NSInteger timeInterval = (NSInteger)[date timeIntervalSince1970];
    //5分钟后的时间
    NSInteger futureTime = [[[NSUserDefaults standardUserDefaults] objectForKey:@"futureTime"] integerValue];
    //时间差（5分钟后的时间与当前的时间差）
    NSInteger timeCha = futureTime - timeInterval;
    
    //倒计时默认时间
    __block NSInteger time = 300;
    
    if (futureTime > 0) {
        time = timeCha;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                _sendButton.userInteractionEnabled = YES;
                //移除上次的计时
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"futureTime"];
                
                //设置按钮的样式
                [_sendButton setTitle:@"重新发送" forState:UIControlStateNormal];
                [_sendButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                
            });
            
        }else{
            
            NSInteger seconds = time;
            dispatch_async(dispatch_get_main_queue(), ^{
                _sendButton.userInteractionEnabled = NO;
                //设置按钮显示读秒效果
                [_sendButton setTitle:[NSString stringWithFormat:@"%.2ld秒后重发", (long)seconds] forState:UIControlStateNormal];
                [_sendButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                
            });
            time--;
        }
    });
    dispatch_resume(timer);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
