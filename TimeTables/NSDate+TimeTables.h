//
//  NSDate+TimeTables.h
//  AFNetworking
//
//  Created by Golden on 2018/11/9.
//

#import <Foundation/Foundation.h>

@interface NSDate (TimeTables)
//年
- (int)year;
//月
- (int)month;
//日
- (int)day;
//周
- (int)week;
//时
- (int)hour;
//分
- (int)minute;
//秒
- (int)second;
//一年的天数
- (int)daysInYear;
//是否为闰年
- (BOOL)isLeapYear;
//当前时间月份的第一天是周几
- (int)firstWeekDayInThisMonth;
//当前时间月份共有多少天
- (int)totalDaysInThisMonth;

//上个月份的此刻日期时间
- (NSDate *)lastMonth;
//下个月份的此刻日期时间
- (NSDate *)nextMonth;

//上周的此刻时间日期
- (NSDate *)lastWeek;
//下周的此刻时间日期
- (NSDate *)nextWeek;

//获取日期所在周的所有日期(周一,周二,周三,周四,周五,周六)
- (NSArray *)getCurrentWeekAllDate:(NSString *)formatter;

/**
 格式化时间
 
 @param formatter yyyy-MM-dd/YYYY-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss
 @return 格式化后的时间String
 */
- (NSString *)formatterDate:(NSString *)formatter;
@end
