//
//  LeftHeaderView.h
//  TimeTables
//
//  Created by Golden on 2018/10/10.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum LeftHeaderType {
    LeftHeaderMonth = 0,
    LeftHeaderSection
}LeftHeaderType;

@interface LeftHeaderView : UIView

+ (instancetype)createLeftHeaderView:(LeftHeaderType)type title:(NSString *)title;

@end

