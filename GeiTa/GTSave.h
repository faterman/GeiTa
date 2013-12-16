//
//  GTSave.h
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import <Foundation/Foundation.h>

#define GTUSER              @"GTUSER"

@interface GTSave : NSObject

//此方法在应用启动时执行，激活LSUser
+ (void)setUserDefaults;

//用户保存和关键值保存都使用NSUserDefault
+ (BOOL)saveUser;
+ (GTUser*)obtainUser;

+ (BOOL)saveObject:(NSString*)object forKey:(NSString*)key;
+ (id)obtainForKey:(NSString*)key;
@end
