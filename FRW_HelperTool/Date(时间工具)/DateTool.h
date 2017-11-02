//
//  DateTool.h
//  FRW_HelperTool
//
//  Created by panda誌 on 2017/6/12.
//  Copyright © 2017年 杭州融讯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatterHelper : NSDateFormatter
//时间戳..工具类
+ (DateFormatterHelper *)shareDateFormatterHelper;
@end

@interface DateTool : NSObject
/*
 ** 获取当前时间戳(1970年到现在流失的秒数)
 */
+(NSTimeInterval)getCurrentTimeStr;
/*
 ** 传入一个时间戳(seconds),返回一个时间
 **  dateStyle 需要返回日期的格式(yyyy-MM-dd a HH:mm:ss)
 */
+(NSString *)getTimeDateBySeconds:(NSTimeInterval)seconds dateStyle:(NSString *)dateStyle;

/**
 *   日期判断 <是否是今天.明天.昨天.今月.今年>
 *   @parameter date 跟当前时间所比较的时间
 *
 */
+ (BOOL)isTodayWithDate:(NSDate *)date;
+ (BOOL)isTomorrowWithDate:(NSDate *)date;
+ (BOOL)isYesterdayWithDate:(NSDate *)date;
+ (BOOL)isThisMouthWithDate:(NSDate *)date;
+ (BOOL)isThisYearWithDate:(NSDate *)date;

/*
 *  1.一分钟前的显示刚刚
 *  2.一个小时前的显示xx分钟前
 *  3.超过一个小时了就显示分钟 如 11：51
 *  4.超过一天了就是 昨天 11 ：51
 *  5.超过两天了 就是显示 月-日
 *  6.超过一年，就是 年-月-日
 */
+ (NSString *)getExoticTimeWith:(NSTimeInterval)interval;



@end
