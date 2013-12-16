//
//  GTLocation.h
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GTLocationManager : CLLocationManager<CLLocationManagerDelegate>

@property(nonatomic,assign) NSInteger locationNumber;
@property(nonatomic,retain) GTUser* user;
@property(nonatomic,retain) GTMessageCenter* messageCenter;

//定位开始
+ (void)start;
//定位停止
+ (void)end;
@end
