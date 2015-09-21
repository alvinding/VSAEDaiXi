//
//  VSALoginController.m
//  VSAEDai
//
//  Created by alvin on 15/9/17.
//  Copyright (c) 2015年 alvin. All rights reserved.
//

#import "VSALoginController.h"

@interface VSALoginController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *authCode;
- (IBAction)coverBtnClicked;

@end

@implementation VSALoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *phoneIcon = [UIImage imageNamed:@"login_phone_icon"];
    UIImageView *phoneView = [[UIImageView alloc] init];
    phoneView.width = 30;
    phoneView.height = 30;
    phoneView.image = phoneIcon;
    phoneView.contentMode = UIViewContentModeCenter;
    self.phone.leftView = phoneView;
    self.phone.leftViewMode = UITextFieldViewModeAlways;
    
    UIImage *keyIcon = [UIImage imageNamed:@"key_icon"];
    UIImageView *keyView = [[UIImageView alloc] init];
    keyView.width = 30;
    keyView.height = 30;
    keyView.image = keyIcon;
    keyView.contentMode = UIViewContentModeCenter;
    self.authCode.leftView = keyView;
    self.authCode.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark - 监听事件
- (IBAction)closeClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)coverBtnClicked {
    [self.view endEditing:YES];
}
@end
