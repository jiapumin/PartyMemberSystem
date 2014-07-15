//
//  BNManagerSurveyDataVo.h
//  Survey
//
//  Created by jpm on 14-6-5.
//  Copyright (c) 2014年 jpm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartyInfo.h"


@interface BNManagerDataVo : NSObject
//保存单个数据到数据库
+ (BOOL)SavePartyInfo;
//查询所有结果
+ (NSArray *)SelectAllData;
//根据数组创建一个对象
+ (PartyInfo *)CreatePartyInfoWithArray:(NSMutableArray *)array;
//根据调查id查询调查结果
+ (NSArray *)SelectResultWithSurveyId:(NSString *)surveyId;

//根据调查id  问题id查询调查结果
+ (NSArray *)SelectResultQuestionWithSurveyId:(NSNumber *)surveyId questionId:(NSNumber *)questionId;

//根据调查id  问题id 选项结果 查询调查结果
+ (NSArray *)SelectResultQuestionWithSurveyId:(NSNumber *)surveyId
                                   questionId:(NSNumber *)questionId
                                  optionValue:(NSString *)optionValue;


@end
