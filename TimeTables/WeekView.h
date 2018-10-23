//
//  WeekView.h
//  TimeTables
//
//  Created by Golden on 2018/10/9.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WeekViewClickedBlock)(NSString *name,NSString *id);

@interface WeekView : UIView

@property (nonatomic, copy) WeekViewClickedBlock weekViewClickedBlock;

/**
 创建周次视图

 @param frame 视图frame
 @param dic 周次的信息，name&&id
 @return weekView
 */
+ (instancetype)creatWithFrame:(CGRect)frame infoDictionary:(NSDictionary *)dic;

@end
