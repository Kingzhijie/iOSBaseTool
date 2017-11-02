//
//  NSString+StringCategoryClass.m
//  FaRongWangWithRongYun
//
//  Created by panda誌 on 17/1/22.
//  Copyright © 2017年 RongXun. All rights reserved.
//

#import "ToolHelperClass.h"
#import <objc/runtime.h>
@implementation ToolHelperClass

@end

@implementation NSString (StringCategoryClass)

//字符串是否为空字符的方法
+ (NSString *)removerBlankString:(NSString *)string {
    NSString *newStr = [NSString stringWithFormat:@"%@", string];
    if ([newStr isEqualToString:@"<null>"] || [newStr isEqualToString:@"(null)"] || newStr.length <= 0) {
        return @"";
    }
    return newStr;
}

+ (NSString *)getTwoSubstringFromSuperString:(NSString *)superString text1:(NSString *)text1 text2:(NSString *)text2
{
    NSString *phoneNo = superString;
    NSRange range = [phoneNo rangeOfString:[NSString stringWithFormat:@"(?<=%@)([.[^ \f\n\r\t\v][ \f\n\r\t\v]]*)(?=%@)",text1,text2] options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        return  [phoneNo substringWithRange:range];
    }
    return @"";
}


+ (BOOL)judgeStringisHttp:(NSString *)string
{
    NSString *phoneNo = string;
    NSRange range = [phoneNo rangeOfString:@"^(http|https|file)://[/]?(([\\w-]+\\.)+)?[\\w-]+(/[\\w-./?%&=,@!~`#$%^&*,./]*)?$" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        return  YES;
    }
    return NO;
}


+ (NSString *)transformMandarinToLatin:(NSString *)string
{
    if (string.length <= 0) {
        return nil;
    }
    /*复制出一个可变的对象*/
    NSMutableString *preString = [string mutableCopy];
    /*转换成成带音 调的拼音*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformMandarinLatin, NO);
    /*去掉音调*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformStripDiacritics, NO);
    /*多音字处理*/
    if ([[(NSString *)string substringToIndex:1] compare:@"长"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"沈"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"厦"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"地"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"重"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    return [[NSString stringWithString:preString] uppercaseString];
}

- (CGRect)stringFitSizeWithAttributes:(NSDictionary *)attributes size:(CGSize)size
{
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    /*
     NSStringDrawingUsesLineFragmentOrigin  这个参数是计算多行文本时用的参数
     NSStringDrawingUsesFontLeading 这个参数是要求根据字形来计算行高
     */
    return rect;
}

+ (NSString *)translationChinese:(NSString *)number
{
    NSString *str = [NSString stringWithFormat:@"%ld",(long)number.integerValue];
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    NSString *sumStr = [sums componentsJoinedByString:@""];
    if (str.length == 2) {
        NSComparisonResult result1 = [str compare:@"09"];
        NSComparisonResult result2 = [str compare:@"20"];
        if (result1 == 1 && result2 == -1) {
            sumStr = [sumStr substringFromIndex:1];
        }
    }
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    return chinese;
}
@end

@implementation UIView (viewCategory)
- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
- (void)addSubviews:(NSArray *)views
{
    for (UIView* v in views) {
        [self addSubview:v];
    }
}

@end

@implementation NSMutableAttributedString (attributedStringCategory)

+ (NSMutableAttributedString *)setAttributedString:(NSString *)string textSpace:(NSInteger)textSpace textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor textFont:(UIFont *)textFont
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:textSpace];
    paragraphStyle.alignment = textAlignment;//对齐方式
    NSRange range = NSMakeRange(0, string.length);
    [attributedString setAttributes:@{
                                      NSForegroundColorAttributeName : textColor,
                                      NSFontAttributeName:textFont,
                                      NSParagraphStyleAttributeName:paragraphStyle
                                      } range:range];
    return attributedString;
}

@end

@implementation UIColor (colorCategory)

+ (UIColor *)setColorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6) return [UIColor whiteColor]; //颜色值不正确(小于6位), 返回默认白色
    if ([cString hasPrefix:@"#"])  cString = [cString substringFromIndex:1]; //#开头的话. 去除#号
    if ([cString length] != 6) return [UIColor whiteColor]; //去除#号后, 位数不是6位, 返回默认色
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end


#define defaultInterval .5  //默认时间间隔
@interface UIButton()
/**bool 类型 YES 不允许点击   NO 允许点击   设置是否执行点UI方法*/
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end
@implementation UIButton (touch)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(mySendAction:to:forEvent:);
        Method methodA =   class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
        //将 methodB的实现 添加到系统方法中 也就是说 将 methodA方法指针添加成 方法methodB的  返回值表示是否添加成功
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        //添加成功了 说明 本类中不存在methodB 所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{
            //添加失败了 说明本类中 有methodB的实现，此时只需要将 methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodA, methodB);
        }
    });
}
- (NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//当我们按钮点击事件 sendAction 时  将会执行  mySendAction
- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (self.isIgnore) {
        //不需要被hook
        [self mySendAction:action to:target forEvent:event];
        return;
    }
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        self.timeInterval =self.timeInterval == 0 ?defaultInterval:self.timeInterval;
        if (self.isIgnoreEvent){
            return;
        }else if (self.timeInterval > 0){
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
        }
    }
    //此处 methodA和methodB方法IMP互换了，实际上执行 sendAction；所以不会死循环
    self.isIgnoreEvent = YES;
    [self mySendAction:action to:target forEvent:event];
}
//runtime 动态绑定 属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    //_cmd == @select(isIgnore); 和set方法里一致
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsIgnore:(BOOL)isIgnore{
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isIgnore), @(isIgnore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnore{
    //_cmd == @select(isIgnore); 和set方法里一致
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)resetState{
    [self setIsIgnoreEvent:NO];
}
@end


@implementation UIBarButtonItem (item)
+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action size:(CGSize)size{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0,size.width,size.height);
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImage:highImage forState:UIControlStateHighlighted];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action size:(CGSize)size
{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake(0, 0,size.width,size.height);
    [Button setTitle:title forState:UIControlStateNormal];
    [Button setTitleColor:titleColor forState:UIControlStateNormal];
    Button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:Button];
}
@end






