//
//  TitleView.h
//  TimeTables
//
//  Created by Golden on 2018/10/11.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum TitleType{
    MyTimetableTitle = 0,
    AllTimetableTitle
}TitleType;

typedef void(^TitleClickedBlock)(TitleType type);

@interface TitleView : UIView

@property (nonatomic, copy) TitleClickedBlock titleClickedBlock;

+ (instancetype)createTitleViewWithTitleType:(TitleType)titleType;

@end
