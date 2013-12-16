//
//  GTSave.m
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import "GTSave.h"

@implementation GTSave
static NSUserDefaults* userDefaults;
+ (void)setUserDefaults
{
    userDefaults=[NSUserDefaults standardUserDefaults];
}


+ (BOOL)saveUser
{
    NSData* data=[NSKeyedArchiver archivedDataWithRootObject:[GTUser currentUser]];
    [userDefaults setObject:data forKey:GTUSER];
    return [userDefaults synchronize];
}

+ (GTUser*)obtainUser
{
    id object=[userDefaults objectForKey:GTUSER];
    if(object==NULL || object==[NSNull null] || object==nil)
    {
        return nil;
    }
    else
    {
        return [NSKeyedUnarchiver unarchiveObjectWithData:object];
    }
}

+ (BOOL)saveObject:(NSString*)object forKey:(NSString*)key
{
    if(object!=nil)
    {
        [userDefaults setObject:object forKey:key];
    }
    else
    {
        [userDefaults removeObjectForKey:key];
    }
    return [userDefaults synchronize];
}

+ (id)obtainForKey:(NSString*)key
{
    id object=[userDefaults objectForKey:key];
    if(object==NULL || object==[NSNull null] || object==nil)
    {
        return nil;
    }
    else
    {
        return object;
    }
}
@end
