//
//  TimesTableInterfaceRequest.m
//  AFNetworking
//
//  Created by Golden on 2018/11/9.
//

#import "TimesTableInterfaceRequest.h"
#import "HTTPTool.h"
#import "MJExtension.h"
#import "TimesTableModel.h"
#import "TimesTableInterfaceMacro.h"

@implementation TimesTableInterfaceRequest

+ (void)requestMyCouresList:(NSDictionary *)params success:(RequestSuccess)success failed:(RequestFailed)failed {
    [HTTPTool postWithURL:GetMyCourse_URL headers:header(MyToken) params:params success:^(id json) {
        switch ([json[@"result"] intValue]) {
            case 1:{
                //操作成功
                NSArray *dataArray = [MyCourseModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                success(dataArray);
                break;
            }
            case 0:{
                //没有查询到数据
                break;
            }
            case -1:{
                //操作过程中出现异常
                break;
            }
            case -2:{
                //数据重复，一般在新增接口中
                break;
            }
            case -100:{
                //用户会话过期，需重新登陆
                break;
            }
            default:
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)requestAllCouresList:(NSDictionary *)params success:(RequestSuccess)success failed:(RequestFailed)failed {
    [HTTPTool postWithURL:GetAllCourse_URL headers:header(MyToken) params:params success:^(id json) {
        switch ([json[@"result"] intValue]) {
            case 1:{
                //操作成功
                NSArray *dataArray = [MyCourseModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
                success(dataArray);
                break;
            }
            case 0:{
                //没有查询到数据
                break;
            }
            case -1:{
                //操作过程中出现异常
                break;
            }
            case -2:{
                //数据重复，一般在新增接口中
                break;
            }
            case -100:{
                //用户会话过期，需重新登陆
                break;
            }
            default:
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}

+ (void)requestCourseInfo:(NSDictionary *)params success:(RequestSuccess)success failed:(RequestFailed)failed {
    [HTTPTool postWithURL:GetCourseInfo_URL headers:header(MyToken) params:params success:^(id json) {
        switch ([json[@"result"] intValue]) {
            case 1:{
                //操作成功
                CourseInfoModel *model = [CourseInfoModel mj_objectWithKeyValues:json[@"data"]];
                NSArray *dataArray = [NSArray arrayWithObject:model];
                success(dataArray);
                break;
            }
            case 0:{
                //没有查询到数据
                break;
            }
            case -1:{
                //操作过程中出现异常
                break;
            }
            case -2:{
                //数据重复，一般在新增接口中
                break;
            }
            case -100:{
                //用户会话过期，需重新登陆
                break;
            }
            default:
                break;
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
