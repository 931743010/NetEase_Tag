//
//  CLGCollectionReusableHeadView.m
//  CLG
//
//  Created by byron on 15/12/18.
//  Copyright © 2015年 byron. All rights reserved.
//

#import "CLGCollectionReusableHeadView.h"

@interface CLGCollectionReusableHeadView()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation CLGCollectionReusableHeadView

- (void)awakeFromNib { 
    [self skinChange];
}
- (void)skinChange
{
   // self.rightButton.backgroundColor = [UIColor redColor];
  //  [self.rightButton setBackgroundImage:[UIImage imageNamed:@"InterestButtonBg"] forState:UIControlStateNormal];
}
- (IBAction)rightBtnClick:(id)sender {
 if(_group.callBack)
 {
     _group.callBack(self.group ,sender);
 }
}
- (void)setGroup:(CLGInterestHeadGorup *)group
{
    _group = group;
    self.leftLabel.text = group.groupHeadTilte;
    [self.rightButton setTitle:group.groupRightTitle forState:UIControlStateNormal]  ;
    [self.rightButton sizeToFit];
}
- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
}
//- (CLGInterestHeadGorup *)group
//{
//   // _group = group;
//}

@end
