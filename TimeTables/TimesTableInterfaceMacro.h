//
//  TimesTableInterfaceMacro.h
//  Pods
//
//  Created by Golden on 2018/11/9.
//

#import <UIKit/UIKit.h>
#ifndef TimesTableInterfaceMacro_h
#define TimesTableInterfaceMacro_h

#define isNilOrNull(obj) (obj == nil || [obj isEqual:[NSNull null]])

#define setObjectForKey(object) \
do { \
[dictionary setObject:object forKey:@#object]; \
} while (0)

#define setObjectForParameter(object) \
do { \
NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil]; \
NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]; \
[paramDic setObject:str forKey:@"param"]; \
} while (0)

#define BASE_URL (@"https://campus.shuxiaoyun.cn/micro/basis")
#define TimesTablesToken (@"TimesTablesToken")
#define MyToken [[NSUserDefaults standardUserDefaults] objectForKey:TimesTablesToken]

//请求header
NS_INLINE NSDictionary *header(NSString *token) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(token);
    return dictionary;
}

//获取周次
#define GetWeeks_URL ([NSString stringWithFormat:@"%@/pub/getWeeks",BASE_URL])
/**
 获取周次的参数
 @param sdate 开始日期 yyyy/MM/dd
 */
NS_INLINE NSDictionary *tokenParam(NSString *sdate) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(sdate);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

//获取我的课表
#define GetMyCourse_URL ([NSString stringWithFormat:@"%@/pub/myCourse",BASE_URL])
/**
 我的课表参数
 @param sdate 开始日期 yyyy/MM/dd
 @param edate 结束日期 yyyy/MM/dd
 */
NS_INLINE NSDictionary *myCourseParam(NSString *sdate,NSString *edate) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(sdate);
    setObjectForKey(edate);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

//获取所有课表
#define GetAllCourse_URL ([NSString stringWithFormat:@"%@/pub/listCourse",BASE_URL])
/**
 所有课表参数
 @param semesterId 学期ID，默认当前学期
 @param gradeId 年级ID，必填
 @param clazzId 班级ID
 @param usersId 任课教师的用户ID
 @param subjectId 科目ID
 @param sdate 开始日期 yyyy-MM-dd
 @param edate 结束日期 yyyy-MM-dd
 */
NS_INLINE NSDictionary *allCourseParam(NSString *semesterId,NSString *gradeId,NSString *clazzId,NSString *usersId,NSString *subjectId,NSString *sdate,NSString *edate) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(semesterId);
    setObjectForKey(gradeId);
    setObjectForKey(clazzId);
    setObjectForKey(usersId);
    setObjectForKey(subjectId);
    setObjectForKey(sdate);
    setObjectForKey(edate);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

//获取某节课的具体信息
#define GetCourseInfo_URL ([NSString stringWithFormat:@"%@/pub/getCourseInfo",BASE_URL])
/**
 某节课具体信息
 @param courseId 课程ID
 */
NS_INLINE NSDictionary *courseInfoParam(NSString *courseId) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    setObjectForKey(courseId);
    setObjectForParameter(dictionary.copy);
    return paramDic.copy;
}

#endif /* TimesTableInterfaceMacro_h */
