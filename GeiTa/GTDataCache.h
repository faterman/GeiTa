//
//  GTDataCache.h
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import <Foundation/Foundation.h>
#define lsDataCachePaidOrders          @"lsDataCachePaidOrders"

typedef enum
{
    LSFolderTypeDocuments=0,//用于存储用户数据或其它应该定期备份的信息
    LSFolderTypeLibrary=1,//用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息
    LSFolderTypeTmp=2//用于存放临时文件，保存应用程序再次启动过程中不需要的信息
    
} LSFolderType;
typedef enum
{
    LSSubFolderTypeNon=0,//存放于根目录
    LSSubFolderTypeCaches=1,
    LSSubFolderTypeCookies=2,
    LSSubFolderTypePreferences=3
    
} LSSubFolderType;


@interface GTDataCache : NSObject

+(void)saveForName:(NSString *)fileName data:(id)data;
+(id)readOfName:(NSString *)fileName;

+ (void)saveWithFolderType:(LSFolderType)folderType subFolder:(LSSubFolderType)subFolderType name:(NSString *)fileName data:(id)data;
+ (id)readOfFolderType:(LSFolderType)folderType subFolder:(LSSubFolderType)subFolderType name:(NSString *)fileName;

+ (CGFloat)calculateImageCache;
+ (void)clearImageCache;

@end
