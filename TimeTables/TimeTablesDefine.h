//
//  TimeTablesDefine.h
//  TimeTables
//
//  Created by Golden on 2018/10/15.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#ifndef TimeTablesDefine_h
#define TimeTablesDefine_h

#pragma mark - 视图坐标
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//3.5寸 4/4s @2x
#define K_PHONE_4_SCREEN_WIDTH (320.f)
#define K_PHONE_4_SCREEN_HEIGHT (480.f)
//4寸   5/5s/5c @2x
#define K_PHONE_5_SCREEN_WIDTH (320.f)
#define K_PHONE_5_SCREEN_HEIGHT (568.f)
//4.7寸 6/6s/7/8 @2x
#define K_PHONE_6_SCREEN_WIDTH (375.0f)
#define K_PHONE_6_SCREEN_HEIGHT (667.0f)
//5.5寸 6+/6s+/7+/8+ @3x
#define K_PHONE_7p_SCREEN_WIDTH (414.f)
#define K_PHONE_7p_SCREEN_HEIGHT (736.f)
//5.8寸 x @3x
#define K_PHONE_x_SCREEN_WIDTH (375.f)
#define K_PHONE_x_SCREEN_HEIGHT (812.f)

#define K_DEPENDED_SCREEN_WIDTH K_PHONE_6_SCREEN_WIDTH
#define K_DEPENDED_SCREEN_HEIGHT K_PHONE_6_SCREEN_HEIGHT
#define getWidth(w) ((float)w / K_DEPENDED_SCREEN_WIDTH * SCREEN_WIDTH)
#define getHeight(h) ((float)h / K_DEPENDED_SCREEN_HEIGHT * SCREEN_HEIGHT)

#define KVIEW_WIDTH(view) view.frame.size.width
#define KVIEW_HEIGHT(view) view.frame.size.height
#define KVIEW_XPOINT(view) view.frame.origin.x
#define KVIEW_YPOINT(view) view.frame.origin.y
#define KVIEW_RIGHT_POINT(view) (view.frame.origin.x + view.frame.size.width)
#define KVIEW_BOTTOM_POINT(view) (view.frame.origin.y + view.frame.size.height)

#endif /* TimeTablesDefine_h */
