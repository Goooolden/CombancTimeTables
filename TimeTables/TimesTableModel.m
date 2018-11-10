//
//  TimesTableModel.m
//  AFNetworking
//
//  Created by Golden on 2018/11/9.
//

#import "TimesTableModel.h"
#import "MJExtension.h"

@implementation TimesTableModel

@end

@implementation MyCourseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"courseId":@"id"};
}

@end

@implementation CourseInfoModel

@end
