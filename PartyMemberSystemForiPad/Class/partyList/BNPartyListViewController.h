//
//  BNPartyListViewController.h
//  PartyMemberSystem
//
//  Created by jpm on 14-7-16.
//  Copyright (c) 2014年 jpm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNPartyDetailController.h"

@interface BNPartyListViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) BNPartyDetailController *pdc;
@property (nonatomic, strong) UIPopoverController *popo;


@end
