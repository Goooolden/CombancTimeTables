//
//  PopTimeTablesView.h
//  TimeTables
//
//  Created by Golden on 2018/10/15.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimesTableModel.h"

typedef enum PopTimeTablesViewType{
    MyPopTimeTablesViewType = 0,
    AllPopTimeTablesViewType
}PopTimeTablesViewType;

@interface PopTimeTablesView : UIView

- (instancetype)initWithPopTimeTablesViewType:(PopTimeTablesViewType)type InfoArray:(NSArray<CourseInfoModel *>*)array;

@end
