//
//  GTAlert.h
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import <Foundation/Foundation.h>

@interface GTAlert : NSObject

+ (void)showWithTag:(int)tag title:(NSString *)title message:(NSString *)message delegate:(id <UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
+ (void)showWithView:(UIView*)view message:(NSString *)message time:(CGFloat)time;

@end

