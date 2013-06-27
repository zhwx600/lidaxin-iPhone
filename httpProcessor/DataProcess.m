//
//  DataProcess.m
//  http
//
//  Created by zheng wanxiang on 11-6-22.
//  Copyright 2011 mjxy. All rights reserved.
//

#import "DataProcess.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netdb.h>


NSString* g_serverIPAndPort = @"http://ipad.leedarson.com:12345/";
NSString* g_sperateStr = @"/iphone/";

@implementation DataProcess

+(UInt32) littleToBig:(UInt32) value
{
	return (value>>24)|((value>>8)&0xFF00)|((value<<8)&0xFF0000)|(value<<24);
}

+(int) shortLittleToBig:(short) value
{
	return ((value<<8)&0xFF00)|((value>>8)&0xFF);
}

+(int) byteToShortInt:(Byte*)byte
{
	int a = (0x000000FF&byte[0])<<8;
	int b = (0x000000FF&byte[1]);
	return  a+b;
}

+(void) doubleByteChange:(Byte*)byte
{
	Byte tempBuf[8];
	for (int i=0; i<8; i++) {
		tempBuf[i] = byte[i];		
	}
	for (int i=0; i<8; i++) {
		byte[i] = tempBuf[7-i];		
	}
}

//+(int) isInRect:(CGPoint*) rect Point:(CGPoint*)points
//{
//	if (nil==points || [points count] <= 0) {
//		return 0;
//	}
//	NSMutableArray* dd;
//	CGPoint pp = CGPointMake(3, 4);
//	[dd addObject:&pp];
//	
//	[dd objectAtIndex:0].x = 8;
//	
//	int count = 0;
//	for (int i=0; i<[points count]; i++) {
//		if ((CGPoint)[points objectAtIndex:i].x >= (CGPoint)[rect objectAtIndex:0].x
//			&& ((CGPoint)[points objectAtIndex:i]).y >= ((CGPoint)[rect objectAtIndex:0]).y
//			&& ((CGPoint)[points objectAtIndex:i]).x <= ((CGPoint)[rect objectAtIndex:1]).x
//			&& ((CGPoint)[points objectAtIndex:i]).y <= ((CGPoint)[rect objectAtIndex:1]).y ) {
//			
//			count++; 
//			
//		}
//		
//	}
//	return count;
//	
//}

//获取数据库文件路径
+(NSString*) getMainPath
{
    return  [[NSBundle mainBundle] bundlePath];
    
}

//获取数据库文件路径
+(NSString*) getDocumentsPath
{
	NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* str = [path objectAtIndex:0];
	NSMutableString* pathfile = [[[NSMutableString alloc] initWithString:str] autorelease];
	return pathfile;
}

+(BOOL) writeData:(NSData*) data FileName:(NSString*) fileName
{
    NSError* error = nil;
    NSString* filePath = [[DataProcess getMainPath] stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"文件 已经 在 document");
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    }
    if (error) {
        return NO;
    }

    return [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
}

+(BOOL) fileIsExists:(NSString*) fileName
{
    NSString* filePath = [[DataProcess getMainPath] stringByAppendingPathComponent:fileName];
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

//删除文件
+(BOOL) removeFileByName:(NSString*) fileName
{
    NSString* filePath = [[DataProcess getDownImageFilePath] stringByAppendingPathComponent:fileName];
    NSError* error = nil;
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
}

+(NSString*) getImageFileNameByUrl:(NSString*) url
{

    NSArray* strArr = [url componentsSeparatedByString:g_sperateStr];
    NSString* file = [strArr objectAtIndex:1];

    return file;
    
}
//获取下载图片文件的 绝对路径
+(NSString*) getImageFilePathByUrl:(NSString*) url
{
    NSString* path = [[DataProcess getDownImageFilePath] stringByAppendingPathComponent:[DataProcess getImageFileNameByUrl:url]];
    
    NSString* path2 = [[DataProcess getMainImageFilePath] stringByAppendingPathComponent:[DataProcess getImageFileNameByUrl:url]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return path;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:path2]){
        return path2;
    }
    
    return nil;

}


+(NSString*) getDownImageFilePath
{
//    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString* str = [path objectAtIndex:0];
//    
//    
//    NSString* docpath = [str stringByAppendingPathComponent:@"Downimage"];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:docpath]) {
//        return docpath;
//    }
//    
//    NSError* error;
//    if ([[NSFileManager defaultManager] createDirectoryAtPath:docpath withIntermediateDirectories:YES attributes:nil error:&error]) {
//        return docpath;
//    }
//    return  nil;
    return [DataProcess getDocumentsPath];

}

+(NSString*) getMainImageFilePath
{
    return [DataProcess getMainPath];
}


+(BOOL) downAndWriteImgeforUrl:(NSString*) urlStr
{
    @try {
        
       // NSString* endUrl = [NSString stringWithFormat:@"%@%@",g_serverIPAndPort,urlStr];
        
        NSLog(@"get utl = %@",urlStr);
        
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        if (!data) {
            return NO;
        }
        NSString* path = [[DataProcess getDownImageFilePath] stringByAppendingPathComponent:[DataProcess getImageFileNameByUrl:urlStr]];
        NSLog(@"SString* path = [[ = %@",path);
        return [DataProcess writeData:data FileNameAndPath:path];
        
    }
    @catch (NSException *exception) {
        return NO;
    }
    return NO;
}

//将内容写入文件 若存在，则覆盖 文件
+(BOOL) writeData:(NSData*) data FileNameAndPath:(NSString*) path
{
    NSError* error = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"文件 已经 在 document");
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    }
    if (error) {
        return NO;
    }
    
    return [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
}

+ (BOOL) IsConnectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);    
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) 
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}


+(BOOL) copyDatabaseSqliteFileToDownImage
{
    NSString* filepath1 = [[DataProcess getDownImageFilePath] stringByAppendingPathComponent:@"data.sqlite3"];
    NSString* filepath2 = [[DataProcess getMainPath] stringByAppendingPathComponent:@"data.sqlite3"];
    
    NSData* data = [NSData dataWithContentsOfFile:filepath2];
    
    NSError* error = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath1]) {
        NSLog(@"data.sqlite3 文件 已经 在 DownImage");
        [[NSFileManager defaultManager] removeItemAtPath:filepath1 error:&error];
    }
    if (error) {
        
        NSLog(@"拷贝sqlite  文件 失败");
        return NO;
    }

    
    return [[NSFileManager defaultManager] createFileAtPath:filepath1 contents:data attributes:nil];
}


+(BOOL) copyDatabaseSqliteFileToDocument
{
    NSString* filepath1 = [[DataProcess getDocumentsPath] stringByAppendingPathComponent:@"data.sqlite3"];
    NSString* filepath2 = [[DataProcess getMainPath] stringByAppendingPathComponent:@"data.sqlite3"];
    
    NSData* data = [NSData dataWithContentsOfFile:filepath2];
    
    NSError* error = nil;

    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath1]) {
        NSLog(@"data.sqlite3 文件 已经 在 document");
        [[NSFileManager defaultManager] removeItemAtPath:filepath1 error:&error];
    }
    if (error) {
        
        NSLog(@"拷贝sqlite  文件 失败");
        return NO;
    }
    
    return [[NSFileManager defaultManager] createFileAtPath:filepath1 contents:data attributes:nil];
}
@end
