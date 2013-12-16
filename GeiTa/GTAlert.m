//
//  GTAlert.m
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import "GTAlert.h"
#import <UIKit/UIAlertView.h>
#import "MBProgressHUD.h"

@implementation GTAlert

+ (void)showWithTag:(int)tag title:(NSString *)title message:(NSString *)message delegate:(id <UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIAlertView* alertView=[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    alertView.tag = tag;
	[alertView show];
	[alertView release];
}

+ (void)showWithView:(UIView*)view message:(NSString *)message time:(CGFloat)time
{
    MBProgressHUD* hud=[[MBProgressHUD alloc] initWithView:view];
    hud.mode=MBProgressHUDModeText;
    hud.labelText=message;
    [view addSubview:hud];
    [view bringSubviewToFront:hud];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(time);
    }];
}
@end
