//
//  DataBase.m
//  LiDaXin-iPad
//
//  Created by zheng wanxiang on 12-9-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataBase.h"

static NSString* dbFileName = @"data.sqlite3";


@implementation DataBase


//创建数据库
+(sqlite3*) createDB
{
    sqlite3* database = nil;
    
    NSString* path = [[DataProcess getDocumentsPath] stringByAppendingPathComponent:dbFileName];
    
    @try {
//        
//        NSError* error = nil;
//        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
//            NSLog(@"文件 已经 在 document");
//
//        }else{
//            [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
//        }
//        if (error) {
//            return NO;
//        }
        
        if (sqlite3_open([path UTF8String], &database) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0,@"创建数据库文件失败！");
            NSLog(@"创建数据库文件失败！");
            return nil;
        }
        NSString* sql = nil;
        char* message;
        
        //参展请求返回
        static bool bCreateCanZhan = false;
        if (!bCreateCanZhan) {
             sql = [NSString stringWithFormat:@"create table if not exists canzhantable(showid text,showname text,showmemo text,versionid text,primary key (showid))"];
            // @"create table if not exists statversion(row integer primary key,db_statversion text);";
            
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建canzhantable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateCanZhan = true;
        }
        
        //产品发布表
        static bool bCreateProRelease = false;
        if (!bCreateProRelease) {
            
            sql = [NSString stringWithFormat:@"create table if not exists chanpinfabutable(productid text,productcls text,imageid text,cjmemo text,versionid text,primary key (productid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建chanpinfabutable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateProRelease = true;
        }

        //产品类型 表
        static bool bCreateProType = false;
        if (!bCreateProType) {

            sql = [NSString stringWithFormat:@"create table if not exists chanpintypetable(typeid text,typename text,versionid text,primary key (typeid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建chanpintypetable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateProType = true;
        }
        //调查明细表
        static bool bCreateDiaochanDetail = false;
        if (!bCreateDiaochanDetail) {
            
            sql = [NSString stringWithFormat:@"create table if not exists diaochandetailtable(detailid text,diaochaid text,diaochacontent text,versionid text,primary key (detailid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建diaochandetailtable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateDiaochanDetail = true;
        }

        //调查请求
        static bool bCreateDiaochanRequest = false;
        if (!bCreateDiaochanRequest) {
            
            sql = [NSString stringWithFormat:@"create table if not exists diaochanrequesttable(diaochaid text,diaochaname text,versionid text,primary key (diaochaid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建diaochanrequesttable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateDiaochanRequest = true;
        }

        //公司图片请求
        static bool bCreateCompanyImage = false;
        if (!bCreateCompanyImage) {
            
            sql = [NSString stringWithFormat:@"create table if not exists companyimagetable(companyid text,companydes text,companyimageid text,versionid text,primary key (companyid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建companyimagetable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateCompanyImage = true;
        }

        //图片表请求
        static bool bCreateImageRequest = false;
        if (!bCreateImageRequest) {
            
            sql = [NSString stringWithFormat:@"create table if not exists imagerequesttable(imageid text,imageurl text,imagetype text,description text,versionid text,primary key (imageid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建imagerequesttable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateImageRequest = true;
        }

        //站位产品
        static bool bCreateZhanweiPro = false;
        if (!bCreateZhanweiPro) {
            
            sql = [NSString stringWithFormat:@"create table if not exists zhanweiprotable(showproid text,showid text,showproimageid text,showpromemo text,versionid text,primary key (showproid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建zhanweiprotable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateZhanweiPro = true;
        }

        //站位产品
        static bool bCreateZhanweiMes = false;
        if (!bCreateZhanweiMes) {
            
            sql = [NSString stringWithFormat:@"create table if not exists zhanweimestable(showitemid text,showid text,showitemimageid text,versionid text,primary key (showitemid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建zhanweimestable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateZhanweiMes = true;
        }

        //总版本
        static bool bCreateVersion = false;
        if (!bCreateVersion) {
            sql = [NSString stringWithFormat:@"create table if not exists versiontable(versionid text)"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建versiontable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateVersion = true;
        }  
        
        //站位产品
        static bool bCreateChangJing = false;
        if (!bCreateChangJing) {
            
            sql = [NSString stringWithFormat:@"create table if not exists changjingtable(changjingid text,changjingtype text,productid text,imageid text,versionid text,primary key (changjingid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建changjingtable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateChangJing = true;
        }
        
        //调查选项表
        static bool bCreateDiaochaItem = false;
        if (!bCreateDiaochaItem) {
            
            sql = [NSString stringWithFormat:@"create table if not exists diaochaitemtable(itemid text,diaochaid text,diaochazhuti text,versionid text,primary key (itemid))"];
            if (sqlite3_exec(database, [sql UTF8String],nil, nil, &message) != SQLITE_OK) {
                sqlite3_close(database);
                NSAssert1(0,@"创建diaochaitemtable表失败：%s",message);
                sqlite3_free(message);
                return nil;
            }
            bCreateDiaochaItem = true;
        }

        
        return database;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }
    
}

#pragma mark  参展请求表
//-------------------------参展请求------------------------------
+(BOOL) addCanZhanTableObj:(CanZhanTableObj*)showobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into canzhantable values('%@','%@','%@','%@');",showobj.m_canzhanId,showobj.m_canzhanName,showobj.m_zhanhuiDescription,showobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addImagaddCanZhanTableObj:(CanZhanTableObj*)showobj表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteCanZhanTableObj:(CanZhanTableObj*) showobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from canzhantable where showid='%@';",showobj.m_canzhanId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 canzhantable where showi 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 canzhantable where showi 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

+(BOOL) alterCanZhanTableObj:(CanZhanTableObj*) showobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into canzhantable values('%@','%@','%@','%@');",showobj.m_canzhanId,showobj.m_canzhanName,showobj.m_zhanhuiDescription,showobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addImagaddCanZhanTableObj:(CanZhanTableObj*)showobj表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllCanZhanTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from canzhantable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                CanZhanTableObj* line = [[CanZhanTableObj alloc] init];
                
                line.m_canzhanId = [[NSString alloc] initWithUTF8String:data0];
                line.m_canzhanName = [[NSString alloc] initWithUTF8String:data1];
                line.m_zhanhuiDescription = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询ggetAllCanZhanTableObj canzhantable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 图片的 信息
+(CanZhanTableObj*) getOneCanZhanTableInfoShowid:(NSString*) showid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = [NSString stringWithFormat:@"select * from canzhantable where showid='%@';",showid];
        
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            CanZhanTableObj* line = [[[CanZhanTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                
                line.m_canzhanId= [[NSString alloc] initWithUTF8String:data0];
                line.m_canzhanName = [[NSString alloc] initWithUTF8String:data1];
                line.m_zhanhuiDescription = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"查询getOneCanZhanTableInfoShowid:(NSString*) showid canzhantable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}


#pragma mark  产品发布
//-------------------------产品发布------------------------------
+(BOOL) addCanZhanReleaseTableObj:(CanZhanReleaseTableObj*) releaseobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into chanpinfabutable values('%@','%@','%@','%@','%@');",releaseobj.m_productId,releaseobj.m_productCls,releaseobj.m_imageId,releaseobj.m_changjingDescription,releaseobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"ddCanZhanReleaseTableObj:(CanZhanRe 表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteCanZhanReleaseTableObj:(CanZhanReleaseTableObj*) releaseobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from chanpinfabutable where productid='%@';",releaseobj.m_productId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 chanpinfabutable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 chanpinfabutable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterCanZhanReleaseTableObj:(CanZhanReleaseTableObj*) releaseobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into chanpinfabutable values('%@','%@','%@','%@','%@');",releaseobj.m_productId,releaseobj.m_productCls,releaseobj.m_imageId,releaseobj.m_changjingDescription,releaseobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"ddCanZhanReleaseTableObj:(CanZhanRe 表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllCanZhanReleaseTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from chanpinfabutable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                CanZhanReleaseTableObj* line = [[CanZhanReleaseTableObj alloc] init];
                
                line.m_productId = [[NSString alloc] initWithUTF8String:data0];
                line.m_productCls = [[NSString alloc] initWithUTF8String:data1];
                line.m_imageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_changjingDescription = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询getAllCanZhanReleaseTableObj chanpinfabutable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}


//获取所有信息
+(NSArray*) getSomeCanZhanReleaseTableObjByType:(NSString*) type
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = [NSString stringWithFormat:@"select * from chanpinfabutable where productcls='%@';",type];
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                CanZhanReleaseTableObj* line = [[CanZhanReleaseTableObj alloc] init];
                
                line.m_productId = [[NSString alloc] initWithUTF8String:data0];
                line.m_productCls = [[NSString alloc] initWithUTF8String:data1];
                line.m_imageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_changjingDescription = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询getAllCanZhanReleaseTableObj chanpinfabutable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }
}


//获取某 图片的 信息
+(CanZhanReleaseTableObj*) getOneReleaseProTableInfoShowid:(NSString*) proid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from chanpinfabutable where productid='%@';",proid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            CanZhanReleaseTableObj* line = [[[CanZhanReleaseTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                
                line.m_productId= [[NSString alloc] initWithUTF8String:data0];
                line.m_productCls = [[NSString alloc] initWithUTF8String:data1];
                line.m_imageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_changjingDescription = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"getOneReleaseProTableInfoShowid:(NSString*) proid 表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}


#pragma mark  产品类别
//-------------------------产品类别------------------------------
+(BOOL) addProTypeTableObj:(ProTypeTableObj*) protypeobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into chanpintypetable values('%@','%@','%@');",protypeobj.m_typeId,protypeobj.m_typeName,protypeobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addProTypeTableObj:(ProTypeTableObj*) protypeobj 表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteProTypeTableObj:(ProTypeTableObj*) protypeobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from chanpintypetable where typeid='%@';",protypeobj.m_typeId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 chanpintypetable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 chanpintypetable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterProTypeTableObj:(ProTypeTableObj*) protypeobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into chanpintypetable values('%@','%@','%@');",protypeobj.m_typeId,protypeobj.m_typeName,protypeobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addProTypeTableObj:(ProTypeTableObj*) protypeobj 表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }
}

//获取所有信息
+(NSArray*) getAllProTypeTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from chanpintypetable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);

                ProTypeTableObj* line = [[ProTypeTableObj alloc] init];
                
                line.m_typeId = [[NSString alloc] initWithUTF8String:data0];
                line.m_typeName = [[NSString alloc] initWithUTF8String:data1];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data2];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询getAllProTypeTableObj chanpintypetable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 图片的 信息
+(ProTypeTableObj*) getOneProTypeTableInfoShowid:(NSString*) protypeid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from chanpintypetable where typeid='%@';",protypeid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            ProTypeTableObj* line = [[[ProTypeTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                
                line.m_typeId = [[NSString alloc] initWithUTF8String:data0];
                line.m_typeName = [[NSString alloc] initWithUTF8String:data1];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data2];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"+(ImageTableObj*) getOneImageTableInfoIm+(ProTypeTableObj*) getOneProTypeTableInfoShowid:(NSString*) protypeid 查询chanpintypetable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

#pragma mark  调查明细
//-------------------------调查明细------------------------------
+(BOOL) addDiaoChaDetailTableObj:(DiaoChanDetailTableObj*) detailobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into diaochandetailtable values('%@','%@','%@','%@');",detailobj.m_detailId,detailobj.m_diaochaId,detailobj.m_diaochaContent,detailobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addDiaoChaDetailTableObj:(DiaoChanDetailTableObj*) detailobj diaochandetailtable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteDiaoChaDetailTableObj:(DiaoChanDetailTableObj*) detailobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from diaochandetailtable where detailid='%@';",detailobj.m_detailId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 diaochandetailtable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 diaochandetailtable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterDiaoChaDetailTableObj:(DiaoChanDetailTableObj*) detailobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into diaochandetailtable values('%@','%@','%@','%@');",detailobj.m_detailId,detailobj.m_diaochaId,detailobj.m_diaochaContent,detailobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addDiaoChaDetailTableObj:(DiaoChanDetailTableObj*) detailobj diaochandetailtable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

+(NSArray*) getSomeDiaoChaDetailTableObjById:(NSString*) diaochaid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = [NSString stringWithFormat:@"select * from diaochandetailtable where diaochaid='%@';",diaochaid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                DiaoChanDetailTableObj* line = [[DiaoChanDetailTableObj alloc] init];
                
                line.m_detailId = [[NSString alloc] initWithUTF8String:data0];
                line.m_diaochaId = [[NSString alloc] initWithUTF8String:data1];
                line.m_diaochaContent = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询ggetSomeDiaoChaDetailTableObjById 表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

//获取所有信息
+(NSArray*) getAllDiaoChaDetailTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from diaochandetailtable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                DiaoChanDetailTableObj* line = [[DiaoChanDetailTableObj alloc] init];
                
                line.m_detailId = [[NSString alloc] initWithUTF8String:data0];
                line.m_diaochaId = [[NSString alloc] initWithUTF8String:data1];
                line.m_diaochaContent = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询ggetAllDiaoChaDetailTableObj  diaochandetailtable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }
    

}
//获取某 图片的 信息
+(DiaoChanDetailTableObj*) getOneDiaoChaDetailTableInfoDetailid:(NSString*) detailid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from diaochandetailtable where detailid='%@';",detailid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            DiaoChanDetailTableObj* line = [[[DiaoChanDetailTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                
                line.m_detailId = [[NSString alloc] initWithUTF8String:data0];
                line.m_diaochaId = [[NSString alloc] initWithUTF8String:data1];
                line.m_diaochaContent = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"++(DiaoChanDetailTableObj*) getOneDiaoChaDetailTableInfoDetailid:(NSString*) detailid 查询diaochandetailtable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

#pragma mark  调查请求
//-------------------------调查------------------------------
+(BOOL) addDiaoChaTableObj:(DiaoChaTableObj*) diaochaobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into diaochanrequesttable values('%@','%@','%@');",diaochaobj.m_diaochaId,diaochaobj.m_diaochaName,diaochaobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addDiaoChaTableObj:(DiaoChaTableObj*) diaochaobj :diaochanrequesttable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteDiaoChaTableObj:(DiaoChaTableObj*) diaochaobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from diaochanrequesttable where diaochaid='%@';",diaochaobj.m_diaochaId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 diaochanrequesttable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 diaochanrequesttable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterDiaoChaTableObj:(DiaoChaTableObj*) diaochaobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into diaochanrequesttable values('%@','%@','%@');",diaochaobj.m_diaochaId,diaochaobj.m_diaochaName,diaochaobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addDiaoChaTableObj:(DiaoChaTableObj*) diaochaobj :diaochanrequesttable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }
}

//获取所有信息
+(NSArray*) getAllDiaoChaTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from diaochanrequesttable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                DiaoChaTableObj* line = [[DiaoChaTableObj alloc] init];
                
                line.m_diaochaId = [[NSString alloc] initWithUTF8String:data0];
                line.m_diaochaName = [[NSString alloc] initWithUTF8String:data1];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data2];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询getAllImageTableObj diaochanrequesttable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 图片的 信息
+(DiaoChaTableObj*) getOneDiaoChaTableInfoDiaoChaid:(NSString*) diaochaid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from diaochanrequesttable where diaochaid='%@';",diaochaid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            DiaoChaTableObj* line = [[[DiaoChaTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                
                line.m_diaochaId = [[NSString alloc] initWithUTF8String:data0];
                line.m_diaochaName = [[NSString alloc] initWithUTF8String:data1];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data2];

                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"++(DiaoChaTableObj*) getOneDiaoChaTableInfoDiaoChaid:(NSString*) diaochaid 查询diaochanrequesttable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

#pragma mark  公司图片
//-------------------------公司图片------------------------------
+(BOOL) addGongSiTableObj:(GongSiImageTableObj*) gongsiobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into companyimagetable values('%@','%@','%@','%@');",gongsiobj.m_companyId,gongsiobj.m_companyDescription,gongsiobj.m_companyImageId,gongsiobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addGongSiTableObj:(GongSiImageTableObj*) gongsiobj:companyimagetable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteGongSiTableObj:(GongSiImageTableObj*) gongsiobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from companyimagetable where companyid='%@';",gongsiobj.m_companyId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 companyimagetable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 companyimagetable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterGongSiTableObj:(GongSiImageTableObj*) gongsiobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into companyimagetable values('%@','%@','%@','%@');",gongsiobj.m_companyId,gongsiobj.m_companyDescription,gongsiobj.m_companyImageId,gongsiobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addGongSiTableObj:(GongSiImageTableObj*) gongsiobj:companyimagetable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllGongSiTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from companyimagetable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                GongSiImageTableObj* line = [[GongSiImageTableObj alloc] init];
                
                line.m_companyId = [[NSString alloc] initWithUTF8String:data0];
                line.m_companyDescription = [[NSString alloc] initWithUTF8String:data1];
                line.m_companyImageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询getAllImageTableObj companyimagetable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 图片的 信息
+(GongSiImageTableObj*) getOneGongSiTableInfoGongSiid:(NSString*) gongsiobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from companyimagetable where companyid='%@';",gongsiobj];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            GongSiImageTableObj* line = [[[GongSiImageTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                
                line.m_companyId = [[NSString alloc] initWithUTF8String:data0];
                line.m_companyDescription = [[NSString alloc] initWithUTF8String:data1];
                line.m_companyImageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"+(GongSiImageTableObj*) getOneGongSiTableInfoGongSiid:(NSString*) gongsiobj 查询companyimagetable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

#pragma mark  展位产品
//-------------------------站位产品------------------------------
+(BOOL) addZhanWeiProTableObj:(ZhanWeiProTableObj*) zhanweiproobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into zhanweiprotable values('%@','%@','%@','%@','%@');",zhanweiproobj.m_showProId,zhanweiproobj.m_showId,zhanweiproobj.m_showProImageId,zhanweiproobj.m_changjingDescription,zhanweiproobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addZhanWeiProTableObj: :zhanweiprotable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteZhanWeiProTableObj:(ZhanWeiProTableObj*) zhanweiproobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from zhanweiprotable where showproid='%@';",zhanweiproobj.m_showProId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 zhanweiprotable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 zhanweiprotable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterZhanWeiProTableObj:(ZhanWeiProTableObj*) zhanweiproobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into zhanweiprotable values('%@','%@','%@','%@','%@');",zhanweiproobj.m_showProId,zhanweiproobj.m_showId,zhanweiproobj.m_showProImageId,zhanweiproobj.m_changjingDescription,zhanweiproobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"alterZhanWeiProTableObj: :zhanweiprotable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllZhanWeiProTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from zhanweiprotable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                ZhanWeiProTableObj* line = [[ZhanWeiProTableObj alloc] init];
                
                line.m_showProId = [[NSString alloc] initWithUTF8String:data0];
                line.m_showId = [[NSString alloc] initWithUTF8String:data1];
                line.m_showProImageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_changjingDescription = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询getAllZhanWeiProTableObj zhanweiprotable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取 同一展位 的产品
+(NSArray*) getSomeZhanWeiProTableInfoZWId:(NSString*) zhanweiid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = [NSString stringWithFormat:@"select * from zhanweiprotable where showid='%@';",zhanweiid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                ZhanWeiProTableObj* line = [[ZhanWeiProTableObj alloc] init];
                
                line.m_showProId = [[NSString alloc] initWithUTF8String:data0];
                line.m_showId = [[NSString alloc] initWithUTF8String:data1];
                line.m_showProImageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_changjingDescription = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询getSomeZhanWeiProTableInfoZWId zhanweiprotable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }
    
}
//获取某 图片的 信息
+(ZhanWeiProTableObj*) getOneZhanWeiProTableInfoProId:(NSString*) proid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from zhanweiprotable where showproid='%@';",proid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            ZhanWeiProTableObj* line = [[[ZhanWeiProTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                
                line.m_showProId = [[NSString alloc] initWithUTF8String:data0];
                line.m_showId = [[NSString alloc] initWithUTF8String:data1];
                line.m_showProImageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_changjingDescription = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"+(ZhanWeiProTableObj*) getOneZhanWeiProTableInfoProId:(NSString*) proid 查询zhanweiprotable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

#pragma mark  展位信息
//-------------------------站位信息------------------------------
+(BOOL) addZhanWeiInfoTableObj:(ZhanWeiInfoTableObj*) zhanweiinfoobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into zhanweimestable values('%@','%@','%@','%@');",zhanweiinfoobj.m_showInfoId,zhanweiinfoobj.m_showId,zhanweiinfoobj.m_showInfoImageId,zhanweiinfoobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addZhanWeiInfoTableObj:(ZhanWeiInfoTableObj*) zhanweiinfoobj 表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteZhanWeiInfoTableObj:(ZhanWeiInfoTableObj*) zhanweiinfoobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from zhanweimestable where showitemid='%@';",zhanweiinfoobj.m_showInfoId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 zhanweimestable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 zhanweimestable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }
}
+(BOOL) alterZhanWeiInfoTableObj:(ZhanWeiInfoTableObj*) zhanweiinfoobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into zhanweimestable values('%@','%@','%@','%@');",zhanweiinfoobj.m_showInfoId,zhanweiinfoobj.m_showId,zhanweiinfoobj.m_showInfoImageId,zhanweiinfoobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addZhanWeiInfoTableObj:(ZhanWeiInfoTableObj*) zhanweiinfoobj 表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllZhanWeiInfoTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from zhanweimestable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                ZhanWeiInfoTableObj* line = [[ZhanWeiInfoTableObj alloc] init];
                
                line.m_showInfoId = [[NSString alloc] initWithUTF8String:data0];
                line.m_showId = [[NSString alloc] initWithUTF8String:data1];
                line.m_showInfoImageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询 getAllZhanWeiInfoTableObj zhanweimestable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 图片的 信息
+(ZhanWeiInfoTableObj*) getOneZhanWeiInfoTableInfoProId:(NSString*) zhanweiid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from zhanweimestable where showitemid='%@';",zhanweiid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            ZhanWeiInfoTableObj* line = [[[ZhanWeiInfoTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                
                line.m_showInfoId = [[NSString alloc] initWithUTF8String:data0];
                line.m_showId = [[NSString alloc] initWithUTF8String:data1];
                line.m_showInfoImageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"getOneZhanWeiInfoTableInfoProId:(NSString*) zhanweiid 查询zhanweimestable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }
}

+(NSArray*) getOneZhanWeiInfoByZhanweiId:(NSString*) zhanweiid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from zhanweimestable where showid='%@';",zhanweiid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                ZhanWeiInfoTableObj* line = [[ZhanWeiInfoTableObj alloc] init];
                
                line.m_showInfoId = [[NSString alloc] initWithUTF8String:data0];
                line.m_showId = [[NSString alloc] initWithUTF8String:data1];
                line.m_showInfoImageId = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
            
        }
        sqlite3_close(database);
        NSLog(@"getOneZhanWeiInfoByZhanweiId:(NSString*) zhanweiid 查询zhanweimestable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}


#pragma mark  图片信息
+(BOOL) addImageTableObj:(ImageTableObj*)imageobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into imagerequesttable values('%@','%@','%@','%@','%@');",imageobj.m_imageId,imageobj.m_imageUrl,imageobj.m_imageType,imageobj.m_imageDescription,imageobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addImageTableObj :imagerequesttable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteImageTableObj:(ImageTableObj*) imageobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from imagerequesttable where imageid='%@';",imageobj.m_imageId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 imagerequesttable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 imagerequesttable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterImageTableObj:(ImageTableObj*) imageobj
{
    
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into imagerequesttable values('%@','%@','%@','%@','%@');",imageobj.m_imageId,imageobj.m_imageUrl,imageobj.m_imageType,imageobj.m_imageDescription,imageobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addImageTableObj :imagerequesttable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllImageTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from imagerequesttable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                ImageTableObj* line = [[ImageTableObj alloc] init];
                
                line.m_imageId = [[NSString alloc] initWithUTF8String:data0];
                line.m_imageUrl = [[NSString alloc] initWithUTF8String:data1];
                line.m_imageType = [[NSString alloc] initWithUTF8String:data2];
                line.m_imageDescription = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询getAllImageTableObj imagerequesttable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 图片的 信息
+(ImageTableObj*) getOneImageTableInfoImageid:(NSString*) imageid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from imagerequesttable where imageid='%@';",imageid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            ImageTableObj* line = [[[ImageTableObj alloc] init] autorelease];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                
                line.m_imageId = [[NSString alloc] initWithUTF8String:data0];
                line.m_imageUrl = [[NSString alloc] initWithUTF8String:data1];
                line.m_imageType = [[NSString alloc] initWithUTF8String:data2];
                line.m_imageDescription = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"+(ImageTableObj*) getOneImageTableInfoImageid:(NSString*) imageid 查询imagerequesttable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}



#pragma mark  总版本
+(BOOL) addVersionTableObj:(NSString*) version
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        
        bool suc1 = [DataBase deleteVersionTableObj];
        if (!suc1 || !version || version.length <=0) {
            return NO;
        }
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into versiontable values('%@');",version];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"add versiontable表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}


+(BOOL) deleteVersionTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = @"delete from versiontable;";
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 versiontable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 versiontable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}


+(NSString*) getAllVersionTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from versiontable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSString* restr = nil;
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);

                restr = [[[NSString alloc] initWithUTF8String:data0] autorelease];
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return restr;
        }
        sqlite3_close(database);
        NSLog(@"getAllVersionTableObj versiontable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

#pragma mark  场景
//-------------------------场景信息------------------------------
+(BOOL) addChangJingInfoTableObj:(ChangJinTableObj*)changjingobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into changjingtable values('%@','%@','%@','%@','%@');",changjingobj.m_changjinId,changjingobj.m_typeName,changjingobj.m_productId,changjingobj.m_imageId,changjingobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addChangJingInfoTableObj:(ChangJinTableObj*)changjingobj 表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteChangJingInfoTableObj:(ChangJinTableObj*) changjingobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from changjingtable where changjingid='%@';",changjingobj.m_changjinId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 changjingtable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 changjingtable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterChangJingInfoTableObj:(ChangJinTableObj*) changjingobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into changjingtable values('%@','%@','%@','%@','%@');",changjingobj.m_changjinId,changjingobj.m_typeName,changjingobj.m_productId,changjingobj.m_imageId,changjingobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"alterChangJingInfoTableObj:(ChangJinTableObj*) changjingobj 表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}



//获取所有信息
+(NSArray*) getAllChangJingInfoTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from changjingtable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                ChangJinTableObj* line = [[ChangJinTableObj alloc] init];
                
                line.m_changjinId = [[NSString alloc] initWithUTF8String:data0];
                line.m_typeName = [[NSString alloc] initWithUTF8String:data1];
                line.m_productId = [[NSString alloc] initWithUTF8String:data2];
                line.m_imageId = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询 getAllChangJingInfoTableObj changjingtable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 图片的 信息
+(ChangJinTableObj*) getOneChangJingTableInfoChangJingId:(NSString*) changjingId
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from changjingtable where changjingid='%@';",changjingId];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            ChangJinTableObj* line = [[[ChangJinTableObj alloc] init] autorelease];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);

                line.m_changjinId = [[NSString alloc] initWithUTF8String:data0];
                line.m_typeName = [[NSString alloc] initWithUTF8String:data1];
                line.m_productId = [[NSString alloc] initWithUTF8String:data2];
                line.m_imageId = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"ghangJinTableObj*) getOneChangJingTableInfoProId:(NSString*) changjingId 查询changjingtable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}


//获取某 zhanweixin  信息
+(NSArray*) getOneZChangJingInfoByProductId:(NSString*) productid
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from changjingtable where productid='%@';",productid];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                char* data4 = (char*)sqlite3_column_text(statement, 4);
                ChangJinTableObj* line = [[ChangJinTableObj alloc] init];
                
                line.m_changjinId = [[NSString alloc] initWithUTF8String:data0];
                line.m_typeName = [[NSString alloc] initWithUTF8String:data1];
                line.m_productId = [[NSString alloc] initWithUTF8String:data2];
                line.m_imageId = [[NSString alloc] initWithUTF8String:data3];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data4];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];		
            return dataArry;
            
        }
        sqlite3_close(database);
        NSLog(@"getOneZChangJingInfoByProductId:(NSString*) productid 查询changjingtable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

#pragma mark  调查选项
//-------------------------调查选项------------------------------
+(BOOL) addDiaochaItemInfoTableObj:(DiaoChaItemTableObj*)itemobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into diaochaitemtable values('%@','%@','%@','%@');",itemobj.m_diaochaItemId,itemobj.m_diaochaId,itemobj.m_diaochaQuestion,itemobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"addDiaochaItemInfoTableObj:(DiaoChaItemTableObj*)itemobj 表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) deleteDiaochaItemInfoTableObj:(DiaoChaItemTableObj*) itemobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        NSString* deletesql = [NSString stringWithFormat:@"delete from diaochaitemtable where itemid='%@';",itemobj.m_diaochaItemId];
        
        char *message=nil;
        if (sqlite3_exec(database, [deletesql UTF8String],nil, nil, &message) != SQLITE_OK) {
            NSLog(@"删除 diaochaitemtable 数据：%s",message);
            sqlite3_free(message);
        }else {
            NSLog(@"删除 diaochaitemtable 数据成功");
        }
        
        sqlite3_close(database);
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}
+(BOOL) alterDiaochaItemInfoTableObj:(DiaoChaItemTableObj*) itemobj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database = [DataBase createDB];
        char* message;
        NSString* updateSql =[[NSString alloc] initWithFormat:@"insert or replace into diaochaitemtable values('%@','%@','%@','%@');",itemobj.m_diaochaItemId,itemobj.m_diaochaId,itemobj.m_diaochaQuestion,itemobj.m_versionId];
        if (sqlite3_exec(database, [updateSql UTF8String],nil, nil, &message) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert1(0,@"alterDiaochaItemInfoTableObj:(DiaoChaItemTableObj*)itemobj 表失败：%s",message);
            sqlite3_free(message);
            [updateSql release];
            return NO;
        }
        sqlite3_close(database);
        [updateSql release];
        return YES;
        
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return NO;
    }

}

//获取所有信息
+(NSArray*) getAllDiaochaItemInfoTableObj
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];;
        NSString* sql = @"select * from diaochaitemtable;";
        
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);

                DiaoChaItemTableObj* line = [[DiaoChaItemTableObj alloc] init];
                
                line.m_diaochaItemId = [[NSString alloc] initWithUTF8String:data0];
                line.m_diaochaId = [[NSString alloc] initWithUTF8String:data1];
                line.m_diaochaQuestion = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];
            return dataArry;
        }
        sqlite3_close(database);
        NSLog(@"查询 getAllDiaochaItemInfoTableObj diaochaitemtable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 图片的 信息
+(DiaoChaItemTableObj*) getOneDiaochaItemTableInfoItemId:(NSString*) itemId
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from diaochaitemtable where itemid='%@';",itemId];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            DiaoChaItemTableObj* line = [[[DiaoChaItemTableObj alloc] init] autorelease];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                
                line.m_diaochaItemId = [[NSString alloc] initWithUTF8String:data0];
                line.m_diaochaId = [[NSString alloc] initWithUTF8String:data1];
                line.m_diaochaQuestion = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];

                
                break;
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            return line;
            
        }
        sqlite3_close(database);
        NSLog(@"DiaoChaItemTableObj*) getOneDiaochaItemTableInfoItemId:(NSString*) itemId 查询diaochaitemtable表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}
//获取某 zhanweixin  信息
+(NSArray*) getOneDiaochaItemInfoByDiaochaId:(NSString*) diaochaId
{
    sqlite3* database = nil;
    @try {
        //打开数据库
        database  = [DataBase createDB];
        NSString* sql = [NSString stringWithFormat:@"select * from diaochaitemtable where diaochaid='%@';",diaochaId];
        //  @"select db_recordbusnum from recordbusnum";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            
            NSMutableArray* dataArry = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* data0 = (char*)sqlite3_column_text(statement, 0);
                char* data1 = (char*)sqlite3_column_text(statement, 1);
                char* data2 = (char*)sqlite3_column_text(statement, 2);
                char* data3 = (char*)sqlite3_column_text(statement, 3);
                
                DiaoChaItemTableObj* line = [[DiaoChaItemTableObj alloc] init];
                
                line.m_diaochaItemId = [[NSString alloc] initWithUTF8String:data0];
                line.m_diaochaId = [[NSString alloc] initWithUTF8String:data1];
                line.m_diaochaQuestion = [[NSString alloc] initWithUTF8String:data2];
                line.m_versionId = [[NSString alloc] initWithUTF8String:data3];
                
                [dataArry addObject:line];
                [line release];
                
            }
            sqlite3_finalize(statement);
            sqlite3_close(database);
            [dataArry autorelease];
            return dataArry;
            
        }
        sqlite3_close(database);
        NSLog(@"+(NSArray*) getOneDiaochaItemInfoByDiaochaId:(NSString*) diaochaId 表时失败！");
        return nil;
    }
    @catch (NSException *exception) {
        sqlite3_close(database);
        return nil;
    }

}

@end
