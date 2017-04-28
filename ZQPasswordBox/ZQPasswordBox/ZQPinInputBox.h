//
//  ZQPinInputBox.h
//  BandaoGangwan
//
//  Created by zhaozq on 2016/12/21.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PinInputBoxCompletionBlock)(NSString * _Nullable pin);
typedef void (^PinInputBoxEditingDidChanged)(NSString * _Nullable pin);
@interface ZQPinInputBox : UIView

@property (assign, nonatomic) BOOL secureTextEntry;

@property (copy, nonatomic, nullable) NSString *pin; // 密码 验证码

@property (copy, nonatomic, nullable) PinInputBoxCompletionBlock completionBlock;

@property (copy, nonatomic, nullable) PinInputBoxEditingDidChanged didChangedBlock;

@end
