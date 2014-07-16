//
//  BNPartyListViewController.m
//  PartyMemberSystem
//
//  Created by jpm on 14-7-16.
//  Copyright (c) 2014年 jpm. All rights reserved.
//

#import "BNPartyListViewController.h"
#import "BNPartyListViewCell.h"
#import "BNManagerDataVo.h"

@interface BNPartyListViewController ()
@property (nonatomic, strong) NSArray *partyList;

@end

@implementation BNPartyListViewController

- (UIPopoverController *)popo{
    if (_popo == nil) {
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.pdc];
        
        _popo = [[UIPopoverController alloc] initWithContentViewController:nav];
    }
    return _popo;
}
- (BNPartyDetailController *)pdc{
    if (_pdc == nil) {
        
        UIStoryboard *story = [UIStoryboard  storyboardWithName:@"Main" bundle:nil];
        
        _pdc = [story instantiateViewControllerWithIdentifier:@"BNPartyDetailController"];
    }
    return _pdc;
}

- (NSArray *)partyList{
    if (_partyList == nil) {
        //获取所有党员数据
        _partyList = [BNManagerDataVo SelectAllData];
    }
    return _partyList;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"党员列表";
    
    self.collectionView.backgroundColor = kGetColor(220, 220, 220);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.partyList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"BNPartyListViewCell";
    BNPartyListViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    
    PartyInfo *partyInfo = [self.partyList objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = partyInfo.name;
    cell.familyAddressLabel.text = partyInfo.familyAddress;
    
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(220, 130);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    self.pdc.partyInfo = [self.partyList objectAtIndex:indexPath.row];
    
    [self.popo presentPopoverFromRect:cell.frame inView:collectionView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
//UICollectionView取消选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
