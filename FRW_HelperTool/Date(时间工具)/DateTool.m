//
//  DateTool.m
//  FRW_HelperTool
//
//  Created by panda誌 on 2017/6/12.
//  Copyright © 2017年 杭州融讯科技有限公司. All rights reserved.
//

#import "DateTool.h"

@implementation DateFormatterHelper
+ (DateFormatterHelper *)shareDateFormatterHelper
{
    static DateFormatterHelper * dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        dateFormatter = [[DateFormatterHelper alloc] init];
    });
    return dateFormatter;
}
@end

@implementation DateTool
+(NSTimeInterval)getCurrentTimeStr
{
    return [[NSDate date] timeIntervalSince1970];
}
+(NSString *)getTimeDateBySeconds:(NSTimeInterval)seconds dateStyle:(NSString *)dateStyle;
{
    NSString * dateSecondsString = [NSString stringWithFormat:@"%f",seconds];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[dateSecondsString doubleValue]];
    NSDateFormatter *formatter = [DateFormatterHelper shareDateFormatterHelper];
    [formatter setDateFormat:dateStyle];
    return [formatter stringFromDate:date];
}

+ (BOOL)isTodayWithDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [DateFormatterHelper shareDateFormatterHelper];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *selfString = [dateFormatter stringFromDate:date];
    return [nowString isEqualToString:selfString];
}

+ (BOOL)isTomorrowWithDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [DateFormatterHelper shareDateFormatterHelper];
    dateFormatter.dateFormat = @"yyyyMMdd";
    
    NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *selfString = [dateFormatter stringFromDate:date];
    NSDate *nowDate = [dateFormatter dateFromString:nowString];
    NSDate *selfDate = [dateFormatter dateFromString:selfString];
    
    NSCalendar *calendar;
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        calendar = [NSCalendar currentCalendar];
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == -1;
}


+ (BOOL)isYesterdayWithDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [DateFormatterHelper shareDateFormatterHelper];
    dateFormatter.dateFormat = @"yyyyMMdd";
    
    NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *selfString = [dateFormatter stringFromDate:date];
    NSDate *nowDate = [dateFormatter dateFromString:nowString];
    NSDate *selfDate = [dateFormatter dateFromString:selfString];
    
    NSCalendar *calendar;
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        calendar = [NSCalendar currentCalendar];
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

+ (BOOL)isThisMouthWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [DateFormatterHelper shareDateFormatterHelper];
    dateFormatter.dateFormat = @"yyyyMM";
    NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *selfString = [dateFormatter stringFromDate:date];
    return [nowString isEqualToString:selfString];
}

+ (BOOL)isThisYearWithDate:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [DateFormatterHelper shareDateFormatterHelper];
    dateFormatter.dateFormat = @"yyyy";
    NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *selfString = [dateFormatter stringFromDate:date];
    return [nowString isEqualToString:selfString];
}

+ (NSString *)getExoticTimeWith:(NSTimeInterval)interval {
    NSDateFormatter *formatter = [DateFormatterHelper shareDateFormatterHelper];
    // 获取当前时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建时间戳
    NSTimeInterval createTime = interval / 1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    //求出现在几点
    [formatter setDateFormat:@"HH"];
    NSDate *hourDate = [NSDate dateWithTimeIntervalSince1970:interval / 1000];
    
    NSString *hourStr = [formatter stringFromDate:hourDate];
    //求出现在几月份
    [formatter setDateFormat:@"MM"];
    long temp = 0;
    //1.一个小时前的显示xx分钟前、
    if ((temp = time / 60) < 60) {
        if (temp < 1) {
            //小于一分钟
            return @"刚刚";
        } else {
            //小于60分钟
            return [NSString stringWithFormat:@"%ld分钟前",temp];
        }
    }
    //2.超过一个小时,不超过一天,就显示分钟 如 11：51  。
    else if ((temp = temp / 60) + [hourStr intValue] < 24) {
        [formatter setDateFormat:@"HH:mm"];
        NSDate *cesh111 = [NSDate dateWithTimeIntervalSince1970:interval / 1000];
        return [formatter stringFromDate:cesh111];
    }
    //3.超过一天,不超过两天,就是 昨天11：51
    else if (temp + [hourStr intValue] < 48) {
        [formatter setDateFormat:@"HH:mm"];
        NSDate *cesh111 = [NSDate dateWithTimeIntervalSince1970:interval / 1000];
        return [NSString stringWithFormat:@"昨天%@", [formatter stringFromDate:cesh111]];
    }
    //4.超过两天,不超过一年,就是显示月-日 时-分。
    else if ([self isThisYearWithDate:hourDate]) {
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSDate *cesh111 = [NSDate dateWithTimeIntervalSince1970:interval / 1000];
        return [formatter stringFromDate:cesh111];
    }
    //5.超过一年，就是年-月-日
    else {
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *cesh111 = [NSDate dateWithTimeIntervalSince1970:interval / 1000];
        return [formatter stringFromDate:cesh111];
    }
}

@end
