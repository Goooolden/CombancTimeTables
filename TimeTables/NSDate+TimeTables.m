//
//  NSDate+TimeTables.m
//  AFNetworking
//
//  Created by Golden on 2018/11/9.
//

#import "NSDate+TimeTables.h"

@implementation NSDate (TimeTables)

- (NSDateComponents *)components:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    //1->周日 2->周一 ···
    calendar.firstWeekday = 1;
    return components;
}

- (int)year {
    return (int)[self components:self].year;
}

- (int)month {
    return (int)[self components:self].month;
}

- (int)day {
    return (int)[self components:self].day;
}

- (int)week {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    //1->周日 2->周一 ···
    calendar.firstWeekday = 1;
    return (int)[components weekday] - 1;
}

- (int)hour {
    return (int)[self components:self].hour;
}

- (int)minute {
    return (int)[self components:self].minute;
}

- (int)second {
    return (int)[self components:self].second;
}

- (int)daysInYear {
    return (self.isLeapYear ? 366 : 365);
}

- (BOOL)isLeapYear {
    int year = self.year;
    return (year%4==0 ? (year%100==0 ? (year%400==0 ? true : false) : true) : false);
}

- (int)firstWeekDayInThisMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    //1->周日 2->周一 ···
    calendar.firstWeekday = 1;
    components.day = 1;
    NSDate *first = [calendar dateFromComponents:components];
    NSInteger firstWeekDay = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:first];
    return (int)(firstWeekDay - 1);
}

- (int)totalDaysInThisMonth {
    NSRange totalDays = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return (int)totalDays.length;
}

- (NSDate *)lastMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)nextMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)lastWeek {
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.weekday = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)nextWeek {
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.weekday = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSArray *)getCurrentWeekAllDate:(NSString *)formatter {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:self];
    //1->周日 2->周一 ···
    calendar.firstWeekday = 1;
    NSInteger weekDay = [components weekday] - 1;
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 0;
        lastDiff = 7 - weekDay;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 7 - weekDay;
    }
    NSArray *currentWeeks = [self getCurrentWeeksWithFirstDiff:firstDiff lastDiff:lastDiff formatter:formatter];
#if 0
    // 得到几号
    NSInteger day = [components day];
    //一周的第一天
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    //一周的最后一天
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
#endif
    return currentWeeks;
}

//获取一周时间 数组
- (NSMutableArray *)getCurrentWeeksWithFirstDiff:(NSInteger)first lastDiff:(NSInteger)last formatter:(NSString *)formatter{
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    for (NSInteger i = first; i < last + 1; i ++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        //日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatter];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];
#if 0
        //星期
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];
        NSString *weekStr = [weekFormatter stringFromDate:curDate];
#endif
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@",dateStr];
        [eightArr addObject:strTime];
    }
    return eightArr;
}

- (NSString *)formatterDate:(NSString *)formatter {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.dateFormat = formatter;
    NSString *dateString = [dateformatter stringFromDate:self];
    return dateString;
}

@end
