//
//  CLGInterestHeadGorup.h
//  CLG
//
//  Created by byron on 15/12/18.
//  Copyright © 2015年 byron. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CLGInterestHeadGorup : NSObject
/** 分组标题 */
@property (nonatomic, copy) NSString *groupHeadTilte;
/** 分组右边标题 */
@property (nonatomic, copy) NSString *groupRightTitle;
/** 分组子集 CLGInterestTag */
@property (nonatomic, strong) NSMutableArray *items;
/** NSIndexPath */
@property (nonatomic, strong) NSIndexPath *idxPath;
/** 回调 */
@property (nonatomic, copy) void(^callBack)(CLGInterestHeadGorup *group, UIButton * btn);
@end
