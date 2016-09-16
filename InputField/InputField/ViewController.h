//
//  ViewController.h
//  InputField
//
//  Created by Chen XueFeng on 16/9/16.
//  Copyright © 2016年 Chen XueFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIGestureRecognizerDelegate>

@property(weak, nonatomic) IBOutlet UITableView *puzzleTableView;
@property(weak, nonatomic) IBOutlet UITextView *inputTextView;
@property(weak, nonatomic) IBOutlet UIButton *sendButton;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewHeight;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewButtom;

@end

