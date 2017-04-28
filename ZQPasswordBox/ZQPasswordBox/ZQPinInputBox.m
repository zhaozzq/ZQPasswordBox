//
//  ZQPinInputBox.m
//  BandaoGangwan
//
//  Created by zhaozq on 2016/12/21.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZQPinInputBox.h"

@interface ZQPinInputBox () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ZQPinInputBox

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _textField.tintColor = [UIColor clearColor];//看不到光标
    _textField.textColor = [UIColor clearColor];//看不到输入内容
    _textField.delegate = self;
    [_textField becomeFirstResponder];
    self.secureTextEntry = YES;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    [self refreshAll];
}

- (UILabel *)labelAtIndex:(NSInteger)index
{
    if (index < 6) {
        SEL getter = NSSelectorFromString([NSString stringWithFormat:@"label%zd",index]);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return (UILabel *)[self performSelector:getter];
#pragma clang diagnostic pop
    }
    return nil;
}

- (IBAction)editingDidChanged:(UITextField *)sender {
    self.pin = sender.text;
    if (_didChangedBlock) {
        _didChangedBlock(sender.text);
    }
    HLog(@"Pin %@",sender.text);
    if (sender.text.length == 6) {
        _completionBlock(self.pin);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 6) {
        return NO;
    }
    [self refreshInRange:range replacementString:string];
    return YES;
}

- (void)refreshInRange:(NSRange)range replacementString:(NSString *)string
{
    UILabel *label = [self labelAtIndex:range.location];
    if (_secureTextEntry) {
        label.text = @"●";
    }
    else
    {
        label.text = string;
    }
    label.hidden = !(string.length > 0);
}

- (void)refreshAll
{
    for (NSInteger index = 0; index < 6; index ++) {
        UILabel *label = [self labelAtIndex:index];
        label.hidden = index >= _textField.text.length;
        if (_secureTextEntry) {
            label.text = @"●";
        }
        else if (index < _textField.text.length)
        {
            label.text = [_textField.text substringWithRange:NSMakeRange(index, 1)];
        }
    }

}

- (BOOL)becomeFirstResponder
{
    [self.textField becomeFirstResponder];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self.textField resignFirstResponder];
    return [super resignFirstResponder];
}

- (void)dealloc
{
    HLog(@"Dealloc ZQPinInputBox release successfully 😀");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
