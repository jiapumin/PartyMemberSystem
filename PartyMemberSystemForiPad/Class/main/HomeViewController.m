//
//  HomeViewController.m
//  QQ空间-HD
//
//  Created by apple on 13-9-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "HomeViewController.h"
#import "Dock.h"
#import "DockItem.h"
#import "THPinViewController.h"

@interface HomeViewController ()<THPinViewControllerDelegate>
{
    Dock *_dock;
    
    // 存放所有要显示的子控制器
    NSMutableDictionary *_allChilds;
    
    // 当前正在显示的子控制器
    UINavigationController *_currentChild;
    
    
}


@property (nonatomic, strong) UIImageView *secretContentView;
@property (nonatomic, strong) UIButton *loginLogoutButton;
@property (nonatomic, copy) NSString *correctPin;
@property (nonatomic, assign) NSUInteger remainingPinEntries;
@property (nonatomic, assign) BOOL locked;
@end

@implementation HomeViewController
static const NSUInteger THNumberOfPinEntries = 6;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _allChilds = [NSMutableDictionary dictionary];
    __unsafe_unretained HomeViewController *home = self;
    
    // 1.添加dock
    _dock = [[Dock alloc] init];
    _dock.dockItemClickBlock = ^(DockItem *item) {
        // 根据切换控制器
        [home selectChildWithItem:item];
    };
    [_dock rotateToOrientation:self.interfaceOrientation];
    [self.view addSubview:_dock];
    
    // 2.设置背景
    self.view.backgroundColor = kGlobalBg;
    
    // 3.监听通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:@"logout" object:nil];
    
    // 4.默认选中全部状态
    [home selectChildWithItem:[DockItem itemWithIcon:nil className:@"ProfileViewController"]];
    
    //密码部分
    self.correctPin = @"1111";
    

    self.locked = YES;
    
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(login:) userInfo:nil repeats:NO];

}

#pragma mark 即将旋转屏幕的时候自动调用
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        // 根据即将要显示的方向来调整dock内部的布局
        [_dock rotateToOrientation:toInterfaceOrientation];
        
        // 调整当前选中控制器view的frame
//        CGFloat width = 768 - kDockMenuItemHeight;
        CGFloat width = 1024 - 270;
        _currentChild.view.frame = CGRectMake(_dock.frame.size.width, 0, width, _dock.frame.size.height);
    }];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
#pragma mark 切换控制器
- (void)selectChildWithItem:(DockItem *)item
{
    // 1.从字典中取出即将要显示的子控制器
    UINavigationController *nav = _allChilds[item.className];
    if (nav == nil) {
        Class c = NSClassFromString(item.className);
        UIViewController *vc;
        if ([item.className isEqualToString:@"BNPartyListViewController"]) {
            UIStoryboard *story = [UIStoryboard  storyboardWithName:@"Main" bundle:nil];
            
             vc = [story instantiateViewControllerWithIdentifier:@"BNPartyListViewController"];
            
        }else{
             vc = [[c alloc] init];
        }
        
       
        nav = [[UINavigationController alloc] initWithRootViewController:vc];
        // 不要自动伸缩
        nav.view.autoresizingMask = UIViewAutoresizingNone;
        vc.view.backgroundColor = kGetColor(220, 220, 220);
        
        // 模型形式展示控制器
        if (item.modal) {
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
        
        // 添加手势监听器
        [nav.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragNavView:)]];
        
        // 建立控制器之间的父子关系
        // 建议：两个控制器互为父子关系，那么它们的view也应该互为父子关系
        [self addChildViewController:nav];
        [_allChilds setObject:nav forKey:item.className];
    }
    
    if (_currentChild == nav) return;
    
    // 2.移除旧控制器的view
    [_currentChild.view removeFromSuperview];
    
//    CGFloat width = 768 - kDockMenuItemHeight;
    CGFloat width = 1024 - 270;
    nav.view.frame = CGRectMake(_dock.frame.size.width, 0, width, _dock.frame.size.height);
    [self.view addSubview:nav.view];
    
    _currentChild = nav;
}

#pragma mark 监听拖拽手势
- (void)dragNavView:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {// 手势结束
        [UIView animateWithDuration:0.2 animations:^{
            pan.view.transform = CGAffineTransformIdentity;
        }];
    } else {
        CGFloat tx = [pan translationInView:pan.view].x;
        pan.view.transform = CGAffineTransformMakeTranslation(tx * 0.5, 0);
    }
}


#pragma mark - Properties

- (void)setLocked:(BOOL)locked
{
    _locked = locked;
    
    if (self.locked) {
        self.remainingPinEntries = THNumberOfPinEntries;
//        self.secretContentView.hidden = YES;
    } else {
//        self.secretContentView.hidden = NO;
    }
}

#pragma mark - UI

- (void)showPinViewAnimated:(BOOL)animated
{
    THPinViewController *pinViewController = [[THPinViewController alloc] initWithDelegate:self];
    pinViewController.promptTitle = @"Enter PIN";
    UIColor *darkBlueColor = [UIColor colorWithRed:0.012f green:0.071f blue:0.365f alpha:1.0f];
    pinViewController.promptColor = darkBlueColor;
    pinViewController.view.tintColor = darkBlueColor;
    
    // for a solid background color, use this:
    pinViewController.backgroundColor = [UIColor whiteColor];
    
    // for a translucent background, use this:
    self.view.tag = THPinViewControllerContentViewTag;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    pinViewController.translucentBackground = YES;
    
    
    //    [self.view addSubview:pinViewController.view];
    [self presentViewController:pinViewController animated:animated completion:nil];
}

#pragma mark - User Interaction

- (void)login:(id)sender
{
    [self showPinViewAnimated:YES];
}

- (void)logout:(id)sender
{
    self.locked = YES;
}

#pragma mark - THPinViewControllerDelegate

- (NSUInteger)pinLengthForPinViewController:(THPinViewController *)pinViewController
{
    return 4;
}

- (BOOL)pinViewController:(THPinViewController *)pinViewController isPinValid:(NSString *)pin
{
    if ([pin isEqualToString:self.correctPin]) {
        return YES;
    } else {
        self.remainingPinEntries--;
        return NO;
    }
}

- (BOOL)userCanRetryInPinViewController:(THPinViewController *)pinViewController
{
    return (self.remainingPinEntries > 0);
}

- (void)incorrectPinEnteredInPinViewController:(THPinViewController *)pinViewController
{
    if (self.remainingPinEntries > THNumberOfPinEntries / 2) {
        return;
    }
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Incorrect PIN"
                               message:(self.remainingPinEntries == 1 ?
                                        @"You can try again once." :
                                        [NSString stringWithFormat:@"You can try again %lu times.",
                                         (unsigned long)self.remainingPinEntries])
                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

- (void)pinViewControllerWillDismissAfterPinEntryWasSuccessful:(THPinViewController *)pinViewController
{
    self.locked = NO;
    
}

- (void)pinViewControllerWillDismissAfterPinEntryWasUnsuccessful:(THPinViewController *)pinViewController
{
    self.locked = YES;
}

- (void)pinViewControllerWillDismissAfterPinEntryWasCancelled:(THPinViewController *)pinViewController
{

}

@end