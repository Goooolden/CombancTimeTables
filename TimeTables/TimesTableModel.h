//
//  TimesTableModel.h
//  AFNetworking
//
//  Created by Golden on 2018/11/9.
//

#import <Foundation/Foundation.h>

@interface TimesTableModel : NSObject

@end

//我的课程
@interface MyCourseModel : NSObject

@property (nonatomic, copy) NSString *courseId;     //课程ID
@property (nonatomic, copy) NSString *clazzId;      //上课班级
@property (nonatomic, copy) NSString *numofday;     //第几节
@property (nonatomic, copy) NSString *week;         //周几
@property (nonatomic, copy) NSString *clazz;        //班级全称
@property (nonatomic, copy) NSString *day;          //日期
@property (nonatomic, copy) NSString *subject;      //科目名称
@property (nonatomic, copy) NSString *teacherName;  //教师姓名

@end

//某节课课程具体信息
@interface CourseInfoModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *clazzId;
@property (nonatomic, copy) NSString *clazz;
@property (nonatomic, copy) NSString *teacherUsersId;
@property (nonatomic, copy) NSString *teacherName;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *week;
@property (nonatomic, copy) NSString *numofday;

@end
