//
//  GTStatus.h
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import <Foundation/Foundation.h>

@interface GTStatus : NSObject
{
    NSInteger _code;
    NSString* _message;
}

@property(nonatomic,assign) NSInteger code;
@property(nonatomic,retain) NSString* message;

- (id)initWithDictionary:(NSDictionary*)safeDic;
@end
