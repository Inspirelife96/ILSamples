//
//  ViewController.m
//  InputField
//
//  Created by Chen XueFeng on 16/9/16.
//  Copyright © 2016年 Chen XueFeng. All rights reserved.
//

#import "ViewController.h"

#define MainScreenHeight [[UIScreen mainScreen] bounds].size.height
#define MainScreenWidth  [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _puzzleTableView.delegate = self;
    _puzzleTableView.dataSource = self;
    _puzzleTableView.tableFooterView = [[UIView alloc] init];
    _inputTextView.returnKeyType = UIReturnKeySend;
    _inputTextView.delegate = self;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)]; // 手势类型随你喜欢。
    tapGesture.delegate = self;
    [_puzzleTableView addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UITableViewDelegate


#pragma mark - Keyboard Notification
- (void)keyboardWillShow:(NSNotification *)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改工具条底部约束
    _inputViewButtom.constant = MainScreenHeight - keyboardFrame.origin.y;
    
    // 获得键盘弹出或隐藏时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 添加动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHidden:(NSNotification *)notification {
    _inputViewButtom.constant = 0.0f;
}

- (void)tapGesturedDetected:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self sendComment];
        [_inputTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self updateInputViewUI];
}

- (void)updateInputViewUI {
    static CGFloat minHeight = 30.0f;
    static CGFloat maxHeight = 80.0f;
    CGSize constraintSize = CGSizeMake(MainScreenWidth - 78.0f, MAXFLOAT);
    CGSize size = [_inputTextView sizeThatFits:constraintSize];
    if (size.height <= minHeight) {
        size.height = minHeight;
    } else {
        if (size.height >= maxHeight) {
            size.height = maxHeight;
            _inputTextView.scrollEnabled = YES;   // 允许滚动
        } else {
            _inputTextView.scrollEnabled = NO;    // 不允许滚动
        }
    }
    _inputTextView.frame = CGRectMake(10.0f, 8.0f, MainScreenWidth - 78.0f, size.height);
    _inputViewHeight.constant = size.height + 16.0f;
}

- (void)sendComment {
    _inputTextView.text = @"";
    [self updateInputViewUI];
    //
}

- (IBAction)clickSendButton:(id)sender {
    [_inputTextView resignFirstResponder];
    if ([_inputTextView.text isEqualToString:@""]) {
        //
    } else {
        [self sendComment];
    }
}

@end
