//
//  GTUser.h
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface GTUser : NSObject
{
    NSString* _userID;//拉手网的用户ID
    NSString* _userName;//姓名
#warning 用户密码一定是以密文储存的
    NSString* _password;//密码
    NSString* _email;//邮箱
    NSString* _mobile;//手机号
    NSString* _balance;//余额
    NSString* _cityID;//城市ID
    NSString* _cityName;//城市名
    CLLocation* _location;//地理位置

    
    BOOL _isImageOnlyWhenWifi;
    NetworkStatus _networkStatus;
}

@property(nonatomic,retain) NSString* userID;
@property(nonatomic,retain) NSString* userName;
@property(nonatomic,retain) NSString* password;
@property(nonatomic,retain) NSString* email;
@property(nonatomic,retain) NSString* mobile;
@property(nonatomic,retain) NSString* balance;
@property(nonatomic,retain) NSString* cityID;
@property(nonatomic,retain) NSString* cityName;
@property(nonatomic,retain) CLLocation* location;


@property(nonatomic,assign) BOOL isImageOnlyWhenWifi;
@property(nonatomic,assign) NetworkStatus networkStatus;

+ (GTUser *)currentUser;
- (void)logout;
- (void)copyPreUser:(GTUser*)preUser;

@end
