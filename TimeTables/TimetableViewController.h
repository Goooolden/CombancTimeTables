//
//  TimetableViewController.h
//  TimeTables
//
//  Created by Golden on 2018/10/11.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum TimetableViewType{
    MyTimetableViewType = 0,
    AllTimetableViewType
}TimetableViewType;

@interface TimetableViewController : UIViewController

@property (nonatomic, assign) TimetableViewType timetableViewType;

@end
