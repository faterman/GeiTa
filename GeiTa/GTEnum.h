//
//  GTEnum.h
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import <Foundation/Foundation.h>

@interface GTEnum : NSObject

#pragma mark- 错误码
typedef enum
{
    GTErrorCodeFailed              = 0,
    GTErrorCodeParseWrong          = 1,//数据格式错误
    GTErrorCodeResponseEmpty       = 2,//响应空
    GTErrorCodeNetworkInterruption = 3,//网络中断
    GTErrorCodeParamatersIsNull    = 4 //参数空
}GTErrorCode;

@end
