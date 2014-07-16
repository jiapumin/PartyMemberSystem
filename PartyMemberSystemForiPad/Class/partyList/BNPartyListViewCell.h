//
//  BNPartyListViewCell.h
//  PartyMemberSystem
//
//  Created by jpm on 14-7-16.
//  Copyright (c) 2014年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNPartyListViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *familyAddressLabel;

@end
