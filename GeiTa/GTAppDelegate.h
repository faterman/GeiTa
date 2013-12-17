//
//  GTAppDelegate.h
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "GTLocation.h"

@interface GTAppDelegate : UIResponder <UIApplicationDelegate>
{
    GTMessageCenter* messageCenter;
    GTUser* user;
    MBProgressHUD* hud;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL loadUserInfo;

@end
