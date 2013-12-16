//
//  GTError.h
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import <Foundation/Foundation.h>

@interface GTError : NSObject
{
    GTErrorCode _code;
    NSString* _message;
    NSString* _detail;
}

@property(nonatomic,assign) GTErrorCode code;
@property(nonatomic,retain) NSString* message;
@property(nonatomic,retain) NSString* detail;

+ (GTError *)errorWithCode:(NSInteger)code message:(NSString*)message detail:(NSString*)detail;

@end
