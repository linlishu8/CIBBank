//
//  NSDate+LWDate.h
//  LWKitDemo
//
//  Created by 动感超人 on 2017/10/12.
//  Copyright © 2017年 LiuweiChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LWDate)

/**
 * 根据日期返回字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)stringWithFormat:(NSString *)format;
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 根据TimeInterval获取时间字符串,带有时区偏移
 */
+ (NSString *)stringWithTimeInterval:(unsigned int)time Formatter:(NSString *)format;
/**
 * 根据字符串和格式获取TimeInterval时间,带有时区偏移
 */
+ (NSTimeInterval)timeIntervalFromString:(NSString *)timeStr Formatter:(NSString *)format;

/**
 * 当前TimeInterval时间,带有时区偏移
 */
+ (NSTimeInterval)now;

/**
 * yyyy-MM-dd HH:mm:ss格式的当前时间
 */
+ (NSString *)stringNowWithFullFormatter;

/**
 * 自定义格式的当前时间
 */
+ (NSString *)stringNowWithFormatter:(NSString *)format;


/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
+ (NSUInteger)day:(NSDate *)date;
+ (NSUInteger)month:(NSDate *)date;
+ (NSUInteger)year:(NSDate *)date;
+ (NSUInteger)hour:(NSDate *)date;
+ (NSUInteger)minute:(NSDate *)date;
+ (NSUInteger)second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)daysInYear;
+ (NSUInteger)daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)isLeapYear;
+ (BOOL)isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)weekOfYear;
+ (NSUInteger)weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)formatYMD;
+ (NSString *)formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)weeksOfMonth;
+ (NSUInteger)weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)begindayOfMonth;
+ (NSDate *)begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)lastdayOfMonth;
+ (NSDate *)lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)dateAfterDay:(NSUInteger)day;
+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day月后的日期(若month为负数,则为|month|月前的日期)
 */
- (NSDate *)dateAfterMonth:(NSUInteger)month;
+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)offsetYears:(int)numYears;
+ (NSDate *)offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)offsetMonths:(int)numMonths;
+ (NSDate *)offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)offsetDays:(int)numDays;
+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)offsetHours:(int)hours;
+ (NSDate *)offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)daysAgo;
+ (NSUInteger)daysAgo:(NSDate *)date;

/**
 *  获取星期几
 */
- (NSInteger)weekday;
+ (NSInteger)weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 */
- (NSString *)dayFromWeekday;
+ (NSString *)dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 */
- (BOOL)isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 */
- (BOOL)isToday;

/**
 *  增加
 */
- (NSDate *)dateByAddingDays:(NSUInteger)days;

/**
 *  获得NSString的月份
 */
+ (NSString *)monthWithMonthNumber:(NSInteger)month;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)daysInMonth:(NSUInteger)month;
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)daysInMonth;
+ (NSUInteger)daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)timeInfo;
+ (NSString *)timeInfoWithDate:(NSDate *)date;
+ (NSString *)timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)ymdFormat;
- (NSString *)hmsFormat;
- (NSString *)ymdHmsFormat;
+ (NSString *)ymdFormat;
+ (NSString *)hmsFormat;
+ (NSString *)ymdHmsFormat;

@end