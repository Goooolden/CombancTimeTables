//
//  TimesTableInterfaceRequest.h
//  AFNetworking
//
//  Created by Golden on 2018/11/9.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSuccess)(id json);
typedef void(^RequestFailed)(NSError *error);

@interface TimesTableInterfaceRequest : NSObject

//获取我的课程
+ (void)requestMyCouresList:(NSDictionary *)params success:(RequestSuccess)success failed:(RequestFailed)failed;

//获取全部课程
+ (void)requestAllCouresList:(NSDictionary *)params success:(RequestSuccess)success failed:(RequestFailed)failed;

//获取某节课的具体信息
+ (void)requestCourseInfo:(NSDictionary *)params success:(RequestSuccess)success failed:(RequestFailed)failed;

@end
