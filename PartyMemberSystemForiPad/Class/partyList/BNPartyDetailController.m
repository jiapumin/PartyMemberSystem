//
//  BNPartyDetailController.m
//  PartyMemberSystem
//
//  Created by jpm on 14-7-16.
//  Copyright (c) 2014年 jpm. All rights reserved.
//

#import "BNPartyDetailController.h"
#import "BNPartyDetailViewCell.h"

@interface BNPartyDetailController ()

@end

@implementation BNPartyDetailController

- (void)setPartyInfo:(PartyInfo *)partyInfo{
    _partyInfo = partyInfo;
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"党员详细信息";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float left = [self leftHeightContentForText:[self descriptionLeft:indexPath]];
    float right = [self rightHeightContentForText: [self contentRight:indexPath]];
    
    float height = 23 + (left > right ? left : right);
    
    return height >= 44 ? height : 44;
}

- (CGFloat)leftHeightContentForText:(NSString *)text{
    UIFont *textFont = [UIFont systemFontOfSize:17];
    
    int height =  [text
                   sizeWithFont:textFont
                   constrainedToSize:CGSizeMake(146, 999999)
                   lineBreakMode:NSLineBreakByWordWrapping
                   ].height;
    
    return height < 21 ? 21 : height;
}

- (CGFloat)rightHeightContentForText:(NSString *)text{
    UIFont *textFont = [UIFont systemFontOfSize:17];
    
    int height =  [text
                   sizeWithFont:textFont
                   constrainedToSize:CGSizeMake(213, 999999)
                   lineBreakMode:NSLineBreakByWordWrapping
                   ].height;
    
    return height < 21 ? 21 : height;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNPartyDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNPartyDetailViewCell" forIndexPath:indexPath];

    cell.leftLabel.text = [self descriptionLeft:indexPath];
    cell.rightLabel.text = [self contentRight:indexPath];
    
    return cell;
}
- (NSString *)descriptionLeft:(NSIndexPath *)indexPath{
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
    NSString *desc;
    if (indexPath.row == 0) {
        desc = @"姓名";
    }else if(indexPath.row == 1){
        desc = @"性别";
    }else if(indexPath.row == 2){
        desc = @"民族";
    }else if(indexPath.row == 3){
        desc = @"出生年月";
    }else if(indexPath.row == 4){
        desc = @"入党时间";
    }else if(indexPath.row == 5){
        desc = @"家庭住址";
    }else if(indexPath.row == 6){
        desc = @"参加工作日期";
    }else if(indexPath.row == 7){
        desc = @"学历";
    }else if(indexPath.row == 8){
        desc = @"籍贯";
    }else if(indexPath.row == 9){
        desc = @"职务名称";
    }else if(indexPath.row == 10){
        desc = @"转正日期";
    }else if(indexPath.row == 11){
        desc = @"批准入党党组织名称";
    }else if(indexPath.row == 12){
        desc = @"备注一";
    }else if(indexPath.row == 13){
        desc = @"";
    }
    return desc;
}

- (NSString *)contentRight:(NSIndexPath *)indexPath{
    NSString *content;
    if (indexPath.row == 0) {
        content = self.partyInfo.name;
    }else if(indexPath.row == 1){
        content = self.partyInfo.sex;
    }else if(indexPath.row == 2){
        content = self.partyInfo.nation;
    }else if(indexPath.row == 3){
        content = self.partyInfo.birthDate;
    }else if(indexPath.row == 4){
        content = self.partyInfo.joinPartyTime;
    }else if(indexPath.row == 5){
        content = self.partyInfo.familyAddress;
    }else if(indexPath.row == 6){
        content = self.partyInfo.startWorkTime;
    }else if(indexPath.row == 7){
        content = self.partyInfo.education;
    }else if(indexPath.row == 8){
        content = self.partyInfo.nativePlace;
    }else if(indexPath.row == 9){
        content = self.partyInfo.positionTitle;
    }else if(indexPath.row == 10){
        content = self.partyInfo.positiveDate;
    }else if(indexPath.row == 11){
        content = self.partyInfo.approvedJoinPartyOrganization;
    }else if(indexPath.row == 12){
        content = self.partyInfo.remark;
    }else if(indexPath.row == 13){
        content = self.partyInfo.name;
    }
    return content;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
