//
//  CLGInterestCollectionViewCell.m
//  CLG
//
//  Created by byron on 15/12/18.
//  Copyright © 2015年 byron. All rights reserved.
//

#import "CLGInterestCollectionViewCell.h"

@interface CLGInterestCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIButton *tagButton;
@property (weak, nonatomic) IBOutlet UIImageView *deleteImageView;
@end
@implementation CLGInterestCollectionViewCell

- (void)awakeFromNib {
    [self initData];
}
- (void)initData
{
  
//    [self.tagButton setBackgroundImage:[UIImage imageNamed:@"interestTagButtonBg"] forState:UIControlStateNormal];
    [self.tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //self.backgroundColor = [UIColor grayColor];
//    self.tagButton.backgroundColor = [UIColor grayColor];
    self.deleteImageView.hidden = YES ;
}
- (void)setInterestTag:(CLGInterestTag *)interestTag
{
    _interestTag = interestTag ;
    self.deleteImageView.hidden = !interestTag.deleteStaut;
    [self.tagButton setTitle:interestTag.interestTitle forState:UIControlStateNormal];
}
- (IBAction)tagBtnClick:(id)sender {
//    if([self.delegate respondsToSelector:@selector(interestCollectionViewCellClick:)])
//    {
//        [self.delegate interestCollectionViewCellClick:self];
//    }
}
@end
