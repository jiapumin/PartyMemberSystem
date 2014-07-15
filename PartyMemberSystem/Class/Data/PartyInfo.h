//
//  PartyInfo.h
//  PartyMemberSystem
//
//  Created by jpm on 14-7-14.
//  Copyright (c) 2014年 jpm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PartyInfo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * nation;
@property (nonatomic, retain) NSString * birthDate;
@property (nonatomic, retain) NSString * joinPartyTime;
@property (nonatomic, retain) NSString * familyAddress;
@property (nonatomic, retain) NSString * startWorkTime;
@property (nonatomic, retain) NSString * education;
@property (nonatomic, retain) NSString * nativePlace;
@property (nonatomic, retain) NSString * positionTitle;
@property (nonatomic, retain) NSString * positiveDate;
@property (nonatomic, retain) NSString * approvedJoinPartyOrganization;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * sortNum;

@end
