//
//  GTMessageCenter.h
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import <Foundation/Foundation.h>

#pragma mark- 全局的通知名，非网络通知
/*
#define LSNotificationAlipaySuccess         @"LSNotificationAlipaySuccess"
#define LSNotificationAlipayUserInfo        @"LSNotificationAlipayUserInfo"
*/
#define LSNotificationNetworkStatusChanged  @"LSNotificationNetworkStatusChanged"
#define LSNotificationLocationChanged       @"LSNotificationLocationChanged"

#pragma mark- 请求的状态参数
#define LSRequestFailed        @"LSRequestFailed"

#pragma mark- 请求类型
/*
 #pragma mark 影片相关
 #define lsRequestTypeFilmsByStatusShowing               @"此处使用接口来作为标识"
 */

@interface GTMessageCenter : NSObject

#pragma mark- 类方法
+ (GTMessageCenter *)defaultCenter;

#pragma mark- 覆载方法
//自定义通知相关函数
- (void)postNotificationName:(NSString *)aName object:(id)anObject;
- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject;

#pragma mark/ 请求方法
/*
 #pragma mark- 影片相关
 - (void)LSMCFilmsWithStatus:(LSFilmShowStatus)status;
 */
@end
