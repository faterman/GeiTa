//
//  GTUser.m
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import "GTUser.h"

@implementation GTUser

@synthesize userID=_userID;
@synthesize userName=_userName;
@synthesize password=_password;
@synthesize email=_email;
@synthesize mobile=_mobile;
@synthesize balance=_balance;
@synthesize cityID=_cityID;
@synthesize cityName=_cityName;
@synthesize location=_location;


@synthesize isImageOnlyWhenWifi=_isImageOnlyWhenWifi;
@synthesize networkStatus=_networkStatus;

static GTUser* user=nil;

+ (GTUser *)currentUser
{
    @synchronized(self)
    {
        if (user==nil)
        {
            user=[[super allocWithZone:NULL] init];
        }
    }
    return user;
}
+ (id)alloc
{
    return [[self currentUser] retain];
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [[self currentUser] retain];
}
- (id)copyWithZone:(NSZone *)zone;
{
    return self; //确保copy对象也是唯一
}
- (id)retain
{
    return self; //确保计数唯一
}
- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //这样打印出来的计数永远为-1
}
- (oneway void)release
{
    //do nothing
}
+ (void)release
{
    //do nothing
}
- (id)autorelease
{
    return self;//确保计数唯一
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userID forKey:@"userID"];
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_balance forKey:@"balance"];
    [aCoder encodeObject:_cityID forKey:@"cityID"];
    [aCoder encodeObject:_cityName forKey:@"cityName"];
    [aCoder encodeObject:_location forKey:@"location"];
    
    [aCoder encodeBool:_isImageOnlyWhenWifi forKey:@"isImageOnlyWhenWifi"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self.userID=[decoder decodeObjectForKey:@"userID"];
    self.userName=[decoder decodeObjectForKey:@"userName"];
    self.password=[decoder decodeObjectForKey:@"password"];
    self.email=[decoder decodeObjectForKey:@"email"];
    self.mobile=[decoder decodeObjectForKey:@"mobile"];
    self.balance=[decoder decodeObjectForKey:@"balance"];
    self.cityID=[decoder decodeObjectForKey:@"cityID"];
    self.cityName=[decoder decodeObjectForKey:@"cityName"];
    self.location=[decoder decodeObjectForKey:@"location"];
    
    self.isImageOnlyWhenWifi=[decoder decodeBoolForKey:@"isImageOnlyWhenWifi"];
    return self;
}

#pragma mark- 退出
- (void)logout
{
    user.userID=nil;
    user.userName=nil;
    user.email=nil;
    user.mobile=nil;
    user.balance=nil;
    user.cityID=nil;
    user.cityName=nil;
    user.location=nil;
    
    user.isImageOnlyWhenWifi=NO;
}


#pragma mark- 复制原始数据
- (void)copyPreUser:(GTUser*)preUser
{
    if(preUser!=nil)
    {
        user.userID=preUser.userID;
        user.userName=preUser.userName;
        user.password=preUser.password;
        user.email=preUser.email;
        user.mobile=preUser.mobile;
        user.balance=preUser.balance;
        user.cityID=preUser.cityID;
        user.cityName=preUser.cityName;
        user.location=preUser.location;
        
        user.isImageOnlyWhenWifi=preUser.isImageOnlyWhenWifi;
    }
}

@end
