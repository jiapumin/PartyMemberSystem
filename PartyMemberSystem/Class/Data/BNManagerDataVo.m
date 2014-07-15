//
//  BNManagerSurveyDataVo.m
//  Survey
//
//  Created by jpm on 14-6-5.
//  Copyright (c) 2014年 jpm. All rights reserved.
//

#import "BNManagerDataVo.h"
#import "BNAppDelegate.h"


@implementation BNManagerDataVo
+ (BOOL)SavePartyInfo{
    
    BNAppDelegate *app = (BNAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSError *error = nil;
    if (![app.managedObjectContext save:&error]) {
        NSLog(@"保存数据失败");
        return NO;
    }
    return YES;

}
+ (NSArray *)SelectAllData{
    
    BNAppDelegate *app = (BNAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PartyInfo"
                                              inManagedObjectContext:app.managedObjectContext];
    
    [request setEntity:entity];
    
    //    NSString *searchStr = [NSString stringWithFormat:@"surveyId = '%@' AND questionId = '%@'", surveyId,questionId];
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:searchStr];
    //    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[app.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"error loading data");
        return nil;
    }
    
    
//    //排序问题
//    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"sortNum" ascending:YES]];
//    
//    NSArray *sortedRecipes = [mutableFetchResults sortedArrayUsingDescriptors:sortDescriptors];
//    
//    NSMutableArray *results = [NSMutableArray arrayWithArray:sortedRecipes];
    
    NSArray *resultArray = [mutableFetchResults sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber *number1 = [NSNumber numberWithFloat:[((PartyInfo *)obj1).sortNum floatValue]];
        NSNumber *number2 = [NSNumber numberWithFloat:[((PartyInfo *)obj2).sortNum floatValue]];
        
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedDescending; // 升序
        
    }];
    
    return resultArray;
    
}
+ (PartyInfo *)CreatePartyInfoWithArray:(NSMutableArray *)array{
    BNAppDelegate *app = (BNAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    PartyInfo *partyInfo =(PartyInfo *)[NSEntityDescription insertNewObjectForEntityForName:@"PartyInfo"
                                                            inManagedObjectContext:app.managedObjectContext];
    
    [partyInfo setName:[array objectAtIndex:0]];
    [partyInfo setSex:[array objectAtIndex:1]];
    [partyInfo setNation:[array objectAtIndex:2]];
    [partyInfo setBirthDate:[array objectAtIndex:3]];
    [partyInfo setJoinPartyTime:[array objectAtIndex:4]];
    [partyInfo setFamilyAddress:[array objectAtIndex:5]];
    [partyInfo setStartWorkTime:[array objectAtIndex:6]];
    [partyInfo setEducation:[array objectAtIndex:7]];
    [partyInfo setNativePlace:[array objectAtIndex:8]];
    [partyInfo setPositionTitle:[array objectAtIndex:9]];
    [partyInfo setPositiveDate:[array objectAtIndex:10]];
    [partyInfo setApprovedJoinPartyOrganization:[array objectAtIndex:11]];
    [partyInfo setRemark:[array objectAtIndex:12]];
    [partyInfo setLongitude:[array objectAtIndex:13]];
    [partyInfo setLatitude:[array objectAtIndex:14]];
    [partyInfo setSortNum:[array objectAtIndex:15]];
    
    
    //姓名:name
    //性别:sex
    //民族nation
    //出生年月birthDate
    //入党时间joinPartyTime
    //家庭住址familyAddress
    //参加工作日期startWorkTime
    //学历:education
    //籍贯:nativePlace
    //职务名称:positionTitle
    //转正日期:positiveDate
    //批准入党党组织名称:approvedJoinPartyOrganization
    //备注一:remark
    //经度:longitude
    //纬度:latitude
    //排序字段:sortNum
    
    return partyInfo;
}

+ (NSArray *)SelectResultWithSurveyId:(NSString *)surveyId{
    
    BNAppDelegate *app = (BNAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Result"
                                              inManagedObjectContext:app.managedObjectContext];
    
    [request setEntity:entity];
    
    NSString *searchStr = [NSString stringWithFormat:@"surveyId = '%@'", surveyId];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:searchStr];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[app.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"error loading data");
        return nil;
    }
    return mutableFetchResults;
    
}
+ (NSArray *)SelectResultQuestionWithSurveyId:(NSNumber *)surveyId questionId:(NSNumber *)questionId {
    
    BNAppDelegate *app = (BNAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ResultQuestion"
                                              inManagedObjectContext:app.managedObjectContext];
    
    [request setEntity:entity];
    
    NSString *searchStr = [NSString stringWithFormat:@"surveyId = '%@' AND questionId = '%@'", surveyId,questionId];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:searchStr];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[app.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"error loading data");
        return nil;
    }
    return mutableFetchResults;
    
}
+ (NSArray *)SelectResultQuestionWithSurveyId:(NSNumber *)surveyId
                                   questionId:(NSNumber *)questionId
                                  optionValue:(NSString *)optionValue{
    
    BNAppDelegate *app = (BNAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ResultQuestion"
                                              inManagedObjectContext:app.managedObjectContext];
    
    [request setEntity:entity];
    
    NSString *searchStr = [NSString stringWithFormat:@"surveyId = '%@' AND questionId = '%@' AND value = '%@'", surveyId,questionId,optionValue];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:searchStr];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[app.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"error loading data");
        return nil;
    }
    return mutableFetchResults;
    
}

@end
