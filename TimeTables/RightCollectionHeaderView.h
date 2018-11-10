//
//  RightCollectionHeaderView.h
//  TimeTables
//
//  Created by Golden on 2018/10/10.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum RightHeaderViewType{
    RightHeaderViewDayWeek    = 0,
    RightheaderviewMonthWeek
}RightHeaderViewType;

@interface RightCollectionHeaderView : UICollectionReusableView

- (void)createRightHeaderView:(RightHeaderViewType)type;

- (void)updateDate:(NSArray *)currentWeeks currentWeek:(int)week;
@end
