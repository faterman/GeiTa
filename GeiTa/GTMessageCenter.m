//
//  GTMessageCenter.m
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import "GTMessageCenter.h"
#import "GTStatus.h"
#import "GTError.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"

@implementation GTMessageCenter

static GTMessageCenter *defaultCenter=nil;
static AFHTTPRequestOperationManager* requestOperationManager=nil;
static NSNotificationCenter* notificationCenter=nil;
static GTUser* user=nil;

#pragma mark - 消息中心,单例模式
+ (GTMessageCenter *)defaultCenter
{
    @synchronized(self)
    {
        if (defaultCenter==nil)
        {
            defaultCenter=[[super allocWithZone:NULL] init];
            
            user=[GTUser currentUser];
            notificationCenter=[NSNotificationCenter defaultCenter];
            requestOperationManager=[AFHTTPRequestOperationManager manager];
        }
    }
    return defaultCenter;
}

+ (id)alloc
{
    return [[self defaultCenter] retain];
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [[self defaultCenter] retain];
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



#pragma mark - 自定义通知相关函数
- (void)postNotificationName:(NSString *)aName object:(id)anObject
{
    [notificationCenter postNotificationName:aName object:anObject];
}
- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
    [notificationCenter addObserver:observer selector:aSelector name:aName object:anObject];
}
- (void)removeObserver:(id)observer
{
    [notificationCenter removeObserver:observer];
}
- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject
{
    [notificationCenter removeObserver:observer name:aName object:anObject];
}


#pragma mark- 私有方法
- (void)requestWithURL:(NSString *)URL params:(NSDictionary *)params
{
    [requestOperationManager POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GTLOG(@"请求类型:[%@]\n状态:请求成功",operation.request.URL.absoluteString);
        
        id object=[operation.responseString objectFromJSONString];
        
        id safeObject=nil;
        if(object!=nil)
        {
            //解析成功
            GTLOG(@"非安全数据\n%@",object);
            
            Class objectClass=[object class];
            if([objectClass isSubclassOfClass:[NSDictionary class]])
            {
                GTLOG(@"返回数据类型为字典\n");
                
                //说明服务器返回了错误信息
                //服务器返回的状态信息一定是一个字典
                if([object objectForKey:@"status"]!=NULL && [object objectForKey:@"status"]!=[NSNull null] && [[object objectForKey:@"status"] isKindOfClass:[NSDictionary class]] && [[object objectForKey:@"status"] objectForKey:@"code"]!=NULL && [[object objectForKey:@"status"] objectForKey:@"code"]!=[NSNull null])
                {
                    GTLOG(@"返回数据类型为状态\n");
                    //数据结构
                    //{
                    //   status = {
                    //               code = "-2";
                    //               message = "\U7528\U6237\U540d\U6216\U8005\U5bc6\U7801\U6709\U8bef\Uff01";
                    //            };
                    //}
                    
                    id statusObject=[object objectForKey:@"status"];
                    if([statusObject isKindOfClass:[NSDictionary class]])
                    {
                        GTStatus* status=[[[GTStatus alloc] initWithDictionary:statusObject] autorelease];
                        safeObject=status;
                    }
                    else
                    {
                        GTError* error=[[[GTError alloc] init] autorelease];
                        error.code=GTErrorCodeParseWrong;
                        safeObject=error;
                    }
                }
                else
                {
                    safeObject=[NSMutableDictionary dictionaryWithDictionary:object];
                    [safeObject makeSafe];
                }
            }
            else if([objectClass isSubclassOfClass:[NSArray class]])
            {
                GTLOG(@"返回数据类型为数组\n");
                
                safeObject=[NSMutableArray arrayWithArray:object];
                [safeObject makeSafe];
            }
            else if([objectClass isSubclassOfClass:[NSString class]])
            {
                GTLOG(@"返回数据类型为字符串\n");
                
                GTError* error=[[[GTError alloc] init] autorelease];
                error.code=GTErrorCodeParseWrong;
                safeObject=error;
            }
        }
        else
        {
            GTLOG(@"返回数据类型为空\n");
            
            GTError* error=[[[GTError alloc] init] autorelease];
            error.code=GTErrorCodeResponseEmpty;
            safeObject=error;
        }
        GTLOG(@"安全数据\n%@",safeObject);
        
#pragma mark 根据请求的类型发出通知
        if(safeObject!=nil)
        {
            //发出通知
            [self postNotificationName:operation.request.URL.absoluteString object:safeObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        GTLOG(@"请求类型:[%@]\n状态:请求失败",operation.request.URL.absoluteString);
        [self postNotificationName:operation.request.URL.absoluteString object:error];
    }];
}



#pragma mark/ 暴露方法

@end
