//
//  WeekView.h
//  TimeTables
//
//  Created by Golden on 2018/10/9.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeekViewDelegate <NSObject>

- (void)weekViewSelectedWithName:(NSString *)name;

@end

@interface WeekView : UIView

@property (nonatomic, assign) id<WeekViewDelegate> weekViewDelegate;

/**
 创建周次视图

 @param frame 视图frame
 @param array 周次的信息
 @return weekView
 */
+ (instancetype)creatWithFrame:(CGRect)frame infoArray:(NSMutableArray *)array;

@end
