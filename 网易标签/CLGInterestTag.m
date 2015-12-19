//
//  CLGInterestIdTag.m
//  CLG
//
//  Created by byron on 15/12/16.
//  Copyright © 2015年 byron. All rights reserved.
//

#import "CLGInterestTag.h"

@implementation CLGInterestTag
- (instancetype)initInterestTagWith:(NSString *)interestId interestTitle:(NSString *)interestTitle
{
    self = [super init];
    if (self) {
        self.interestTitle = interestTitle;
        self.interestId = interestId;
    }
    return self;
}

+ (instancetype)interestTagWith:(NSString *)interestId interestTitle:(NSString *)interestTitle
{
    return [[self alloc] initInterestTagWith:interestId interestTitle:interestTitle];
}
 
@end
