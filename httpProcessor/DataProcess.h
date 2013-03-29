//
//  DataProcess.h
//  http
//
//  Created by zheng wanxiang on 11-6-22.
//  Copyright 2011 mjxy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataProcess : NSObject {

}

+(int) byteToShortInt:(Byte*)byte;
+(UInt32) littleToBig:(UInt32) value;
+(int) shortLittleToBig:(short) value;
+(void) doubleByteChange:(Byte*)byte;
//+(int) isInRect:(CGPoint*) rect Point:(CGPoint*)points;

//获取数据库文件路径
+(NSString*) getMainPath;

//获取数据库文件路径
+(NSString*) getDocumentsPath;

//将内容写入文件 若存在，则覆盖 文件 (文件都是 存在 document 文件夹 下面)
+(BOOL) writeData:(NSData*) data FileName:(NSString*) fileName;

//判断某个 文件 是否在 （document）下存在
+(BOOL) fileIsExists:(NSString*) fileName;

//删除文件
+(BOOL) removeFileByName:(NSString*) fileName;

+(NSString*) getImageFileNameByUrl:(NSString*) url;

+(NSString*) getImageFilePathByUrl:(NSString*) url;//获取下载图片文件的 绝对路径

//下载图片的 路径
+(NSString*) getImageFilePath;

+(BOOL) downAndWriteImgeforUrl:(NSString*) urlStr;

//将内容写入文件 若存在，则覆盖 文件
+(BOOL) writeData:(NSData*) data FileNameAndPath:(NSString*) path;

+(BOOL) IsConnectedToNetwork;

+(BOOL) copyDatabaseSqliteFileToDownImage;


@end
