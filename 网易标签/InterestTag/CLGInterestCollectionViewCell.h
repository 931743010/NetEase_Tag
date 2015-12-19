//
//  CLGInterestCollectionViewCell.h
//  CLG
//
//  Created by byron on 15/12/18.
//  Copyright © 2015年 byron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLGInterestTag.h"
//@class CLGInterestCollectionViewCell;
//@protocol CLGInterestCollectionViewCellDelegate <NSObject>
//
//@optional
//- (void)interestCollectionViewCellClick:(CLGInterestCollectionViewCell *)clickCell;
//@end

@interface CLGInterestCollectionViewCell : UICollectionViewCell
/** 标签模型 */
@property (nonatomic, strong) CLGInterestTag *interestTag;
/** delegate    */
//@property (nonatomic, weak) id<CLGInterestCollectionViewCellDelegate> delegate;
@end
