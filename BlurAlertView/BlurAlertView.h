//
//  BlurAlertView.h
//  UIAlterViewDemo
//
//  Created by zhanbing han on 15/12/4.
//  Copyright © 2015年 北京与车行信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

@interface BlurAlertView : UIView

@property (nonatomic,copy) dispatch_block_t cancelBlock;
@property (nonatomic,copy) dispatch_block_t doneBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock; //点击左右按钮都会触发该消失的block

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *leftTitle;
@property (nonatomic,copy) NSString *rigthTitle;
@property (nonatomic,retain) UIView *baseView;
@property (nonatomic,assign) BOOL flag; //YES:取消和确定2个按钮  NO:只有确定按钮

/**
 *  构造方法
 *
 *  @param title      标题
 *  @param content    内容
 *  @param leftTitle  左按钮标题
 *  @param rigthTitle 右按钮标题
 *  @param bView      self.view
 *
 *  @return id
 */
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
           baseView:(UIView *)bView;

@end

