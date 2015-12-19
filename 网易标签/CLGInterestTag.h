//
//  CLGInterestIdTag.h
//  CLG
//
//  Created by byron on 15/12/16.
//  Copyright © 2015年 byron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLGInterestTag : NSObject
/** 兴趣标签的ID */
@property (nonatomic, copy) NSString *interestId;
/** 兴趣标签标题 */
@property (nonatomic, copy) NSString *interestTitle;
/** 是否进入删除模式 */
@property (nonatomic, assign,getter=isDeleteStaut) BOOL deleteStaut;

+ (instancetype)interestTagWith:(NSString *)interestId interestTitle:(NSString *)interestTitle;
- (instancetype)initInterestTagWith:(NSString *)interestId interestTitle:(NSString *)interestTitle;

@end
