//
//  NSString+StringCategoryClass.h
//  FaRongWangWithRongYun
//
//  Created by panda誌 on 17/1/22.
//  Copyright © 2017年 RongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ToolHelperClass : NSObject
/**
 * 获取设备信息 (待补充)
 */
@end

@interface NSString (StringCategoryClass)
/**
* 字符串是否为空字符的方法,如果为空,则返回为@""
 */
+ (NSString *)removerBlankString:(NSString *)string;
/**
 * 判断url地址是否为全路径(http.....)
 */
+ (BOOL)judgeStringisHttp:(NSString *)string;
/**
 *   获取两个字串之间的字符串
 *   @parameter string   主串
 *   @parameter text1    字符串1
 *   @parameter text2    字符串2
 *   return  目标字串
 */
+ (NSString *)getTwoSubstringFromSuperString:(NSString *)superString text1:(NSString *)text1 text2:(NSString *)text2;

/**
 * 汉字首字符转拼音
 */
+ (NSString *)transformMandarinToLatin:(NSString *)string;
/**
 * 阿拉伯数字转中文格式 (5->五, 20->二十, 101->一百零一)
 */
+ (NSString *)translationChinese:(NSString *)number;

/**
 *  字符串, 返回自适应高度
     attributes 例如: {NSFontAttributeName:[UIFont systemFontOfSize:16]}
     size 例如: CGSizeMake(100, CGFLOAT_MAX)
 */
- (CGRect)stringFitSizeWithAttributes:(NSDictionary *)attributes size:(CGSize)size;
@end







@interface UIView (viewCategory)
@property(nonatomic) CGFloat left; //左边界(x)
@property(nonatomic) CGFloat top; //上边界(y)
@property(nonatomic) CGFloat right; //右边界
@property(nonatomic) CGFloat bottom; //下边界
@property(nonatomic) CGFloat width;  //宽度
@property(nonatomic) CGFloat height; //高度
@property(nonatomic) CGFloat centerX; //中心(x)
@property(nonatomic) CGFloat centerY; //中心(y)
@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;
/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;
/**
 * add subviews.
 */
- (void)addSubviews:(NSArray *)views;

@end









@interface NSMutableAttributedString (attributedStringCategory)
/*
 ** 设置富文本
 @param string 文本内容
 @param textSpace 文本行间距
 @param textAlignment 文本对齐方式
 @param textColor 文本color
 @param textFont 文本字体
 */
+ (NSMutableAttributedString *)setAttributedString:(NSString *)string textSpace:(NSInteger)textSpace textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor textFont:(UIFont *)textFont;
@end










@interface UIColor (colorCategory)
/**
 *  16进制颜色字符串转UIColor
 *
 *  @param stringToConvert 16进制颜色字符串（如：#FFE326）
 *
 *  @return 对应的IColor
 */
+ (UIColor *)setColorWithHexString:(NSString *)stringToConvert;
@end








/*
 **  防止button快速点击Method
 */
@interface UIButton (touch)
/**设置点击时间间隔, 默认0.5S*/
@property (nonatomic, assign) NSTimeInterval timeInterval;
/**
 *  用于设置单个按钮不需要被hook, 忽略YES
 */
@property (nonatomic, assign) BOOL isIgnore;
@end









@interface UIBarButtonItem (item)
/**
 *  自定义, 导航左右按钮(图标)
 *
 *  @param normalImage 正常图片  highImage 高亮图片  size图标的尺寸
 *
 *  @return 对应的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action size:(CGSize)size;
/**
 *  自定义, 导航左右按钮(文本)
 *
 *  @param title 按钮文本
 *
 *  @return 对应的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action size:(CGSize)size;
@end





