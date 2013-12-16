//
//  GTDataCache.m
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import "GTDataCache.h"

#define lsDocuments         @"Documents"
#define lsLibraryCaches     @"Library/Caches"
#define lsTmp               @"tmp"

@implementation GTDataCache

//默认存储于tmp文件夹
+ (void)saveForName:(NSString *)fileName data:(id)data
{
    [self saveWithFolderType:LSFolderTypeTmp subFolder:LSSubFolderTypeNon name:fileName data:data];
}

+ (id)readOfName:(NSString *)fileName
{
    return [self readOfFolderType:LSFolderTypeTmp subFolder:LSSubFolderTypeNon name:fileName];
}

+ (void)saveWithFolderType:(LSFolderType)folderType subFolder:(LSSubFolderType)subFolderType name:(NSString *)fileName data:(id)data
{
    
    if([NSKeyedArchiver archiveRootObject:data toFile:[self makeFilePathWithFolderType:folderType subFolder:subFolderType name:fileName]])
    {
        GTLOG(@"%@ : 持久化数据成功",[NSDate date]);
    }
    else
    {
        GTLOG(@"%@ : 持久化数据失败",[NSDate date]);
        [NSKeyedArchiver archiveRootObject:nil toFile:[self makeFilePathWithFolderType:folderType subFolder:subFolderType name:fileName]];
    }
}
+ (id)readOfFolderType:(LSFolderType)folderType subFolder:(LSSubFolderType)subFolderType name:(NSString *)fileName
{
    id data=[NSKeyedUnarchiver unarchiveObjectWithFile:[self makeFilePathWithFolderType:folderType subFolder:subFolderType name:fileName]];
    if (data!=nil)
    {
        GTLOG(@"%@ : 数据获取成功",[NSDate date]);
    }
    else
    {
        GTLOG(@"%@ : 数据获取失败",[NSDate date]);
    }
    return data;
}

//私有方法,组装文件路径
+ (NSString*)makeFilePathWithFolderType:(LSFolderType)folderType subFolder:(LSSubFolderType)subFolderType name:(NSString *)fileName
{
    NSMutableArray* pathMArray=[NSMutableArray arrayWithObject:NSHomeDirectory()];
    
    if(folderType==LSFolderTypeDocuments)
    {
        [pathMArray addObject:lsDocuments];
    }
    else if(folderType==LSFolderTypeLibrary)
    {
        [pathMArray addObject:lsLibraryCaches];
    }
    else if(folderType==LSFolderTypeTmp)
    {
        [pathMArray addObject:lsTmp];
    }
    
    [pathMArray addObject:fileName];
    NSString* filePath=[NSString pathWithComponents:pathMArray];
    
    GTLOG(@"当前操作文件路径:\n%@",filePath);
    return filePath;//拼接文件路径
}

+ (CGFloat)calculateImageCache
{
    NSString* path=[GTDataCache makeFilePathWithFolderType:LSFolderTypeLibrary subFolder:LSSubFolderTypeCaches name:@"com.hackemist.SDWebImageCache.default"];
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray* subPathArray=[fileManager subpathsOfDirectoryAtPath:path error:nil];
    NSMutableData* mData=[NSMutableData dataWithCapacity:0];
    for(NSString* subPath in subPathArray)
    {
        NSData* _data=[fileManager contentsAtPath:[path stringByAppendingPathComponent:subPath]];
        [mData appendData:_data];
    }
    return mData.length/1024/1024;
}
+ (void)clearImageCache
{
    NSString* path=[GTDataCache makeFilePathWithFolderType:LSFolderTypeLibrary subFolder:LSSubFolderTypeCaches name:@"com.hackemist.SDWebImageCache.default"];
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray* subPathArray=[fileManager contentsOfDirectoryAtPath:path error:nil];
    for(NSString* subPath in subPathArray)
    {
        [fileManager removeItemAtPath:[path stringByAppendingPathComponent:subPath] error:nil];
    }
}

@end
