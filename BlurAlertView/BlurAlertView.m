//
//  BlurAlertView.m
//  UIAlterViewDemo
//
//  Created by zhanbing han on 15/12/4.
//  Copyright © 2015年 北京与车行信息技术有限公司. All rights reserved.
//

#import "BlurAlertView.h"
#import "FXBlurView.h" //模糊视图

@interface BlurAlertView ()
{
    FXBlurView *shadowBgView; //模糊背景视图
    FXBlurView *bgView; //模糊弹框背景视图
}
@end

@implementation BlurAlertView

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
           baseView:(UIView *)bView{
    
    CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        
        self.title = title;
        self.content = content;
        self.leftTitle = leftTitle;
        self.rigthTitle = rigthTitle;
        self.baseView = bView;
        
        if ([self isBlankString:self.leftTitle]) {
            self.flag = NO; //只有确定按钮
        } else {
            self.flag = YES; //取消和确定2个按钮
        }
        
        [self.baseView addSubview:self];
        [self initView]; //初始化视图
        
    }
    return self;
}

#pragma mark - 初始化视图
- (void)initView {
    
    shadowBgView = [[FXBlurView alloc] initWithFrame:self.frame];
    shadowBgView.tintColor = [UIColor blackColor];
    shadowBgView.dynamic = YES;
    shadowBgView.blurRadius = 5;
    [self.baseView addSubview:shadowBgView];
    
    bgView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, 260, 0)];
    bgView.tintColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 10;
    [bgView.layer setMasksToBounds:YES];
    bgView.dynamic = YES;
    bgView.blurRadius = 30;
    [self.baseView addSubview:bgView];
    
    CGFloat titleH;
    titleH = self.title.length==0?0:20;
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 230, titleH)];
    titleLab.font = [UIFont boldSystemFontOfSize:16];
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = self.title;
    [bgView addSubview:titleLab];
    
    CGFloat contentOffY = titleLab.frame.size.height==0?20:45;
    CGFloat contentH = [self getTextHeight:self.content font:[UIFont systemFontOfSize:15] forWidth:230] + 1;
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(15, contentOffY, 230, contentH)];
    contentLab.numberOfLines = 0;
    contentLab.font = [UIFont systemFontOfSize:14];
    contentLab.textColor = [UIColor blackColor];
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.text = self.content;
    [bgView addSubview:contentLab];
    
    CGFloat offY = CGRectGetMaxY(contentLab.frame) + 20;
    
    UIView *rowLine = [[UIView alloc] initWithFrame:CGRectMake(0, offY, bgView.frame.size.width, 0.5)];
    rowLine.backgroundColor = [UIColor colorWithRed:0.4317 green:0.4462 blue:0.5047 alpha:0.5];
    [bgView addSubview:rowLine];
    
    if (self.flag == YES) {
        UIView *colLine = [[UIView alloc] initWithFrame:CGRectMake(bgView.frame.size.width/2, offY, 0.5, 40)];
        colLine.backgroundColor = [UIColor colorWithRed:0.4317 green:0.4462 blue:0.5047 alpha:0.5];
        [bgView addSubview:colLine];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, offY, bgView.frame.size.width/2, 40)];
        cancelBtn.userInteractionEnabled = YES;
        [cancelBtn setTitle:self.leftTitle forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn setTitleColor:[UIColor colorWithRed:0.1843 green:0.4549 blue:0.9922 alpha:1.0] forState:UIControlStateNormal];
        cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:cancelBtn];
        
        UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(bgView.frame.size.width/2, offY, bgView.frame.size.width/2, 40)];
        [doneBtn setTitle:self.rigthTitle forState:UIControlStateNormal];
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [doneBtn setTitleColor:[UIColor colorWithRed:0.1843 green:0.4549 blue:0.9922 alpha:1.0] forState:UIControlStateNormal];
        doneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:doneBtn];
    } else {
        UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, offY, bgView.frame.size.width, 40)];
        [doneBtn setTitle:self.rigthTitle forState:UIControlStateNormal];
        doneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [doneBtn setTitleColor:[UIColor colorWithRed:0.1843 green:0.4549 blue:0.9922 alpha:1.0] forState:UIControlStateNormal];
        doneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:doneBtn];
    }
    
    CGRect bgFrame = bgView.frame;
    bgFrame.size.height = contentOffY+contentH+20+40;
    bgView.frame = bgFrame;
    bgView.center = self.center;
}

#pragma mark - 取消点击
- (void)cancelAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    [self dismissAlert];
}

#pragma mark - 确定点击
- (void)doneAction:(id)sender {
    if (self.doneBlock) {
        self.doneBlock();
    }
    
    [self dismissAlert];
}

#pragma mark - 页面消失
- (void)dismissAlert
{
    [self removeFromSuperview];
    shadowBgView.hidden = YES;
    bgView.hidden = YES;
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

#pragma mark - 根据文字内容、字体大小、行宽返回文本高度
- (CGFloat)getTextHeight:(NSString *) text font:(UIFont *)font forWidth:(CGFloat) width {
    if ( text == nil || font == nil || width <= 0) {
        return 0 ;
    }
    
    CGSize size;
    if (IsIOS7) {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        size = [text boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil ].size ;
    } else {
        size = [text sizeWithFont: font forWidth:width lineBreakMode:NSLineBreakByClipping ] ;
    }
    return size.height ;
}

#pragma mark - 判断字符串是否为空
- (BOOL)isBlankString:(id)string
{
    string = [NSString stringWithFormat:@"%@",string];
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if([string isEqualToString:@"<null>"])
    {
        return YES;
    }
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        return YES;
    }
    return NO;
}

@end

