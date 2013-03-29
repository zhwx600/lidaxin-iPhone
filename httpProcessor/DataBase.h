//
//  DataBase.h
//  LiDaXin-iPad
//
//  Created by zheng wanxiang on 12-9-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "DataProcess.h"

#import "CanZhanTableObj.h"
#import "CanZhanReleaseTableObj.h"
#import "ProTypeTableObj.h"
#import "DiaoChanDetailTableObj.h"
#import "DiaoChaTableObj.h"
#import "GongSiImageTableObj.h"
#import "ImageTableObj.h"
#import "ZhanWeiProTableObj.h"
#import "ZhanWeiInfoTableObj.h"
#import "ChangJinTableObj.h"
#import "DiaoChaItemTableObj.h"


@interface DataBase : NSObject
//创建数据库
+(sqlite3*) createDB;

//-------------------------参展请求------------------------------
+(BOOL) addCanZhanTableObj:(CanZhanTableObj*)showobj;
+(BOOL) deleteCanZhanTableObj:(CanZhanTableObj*) showobj;
+(BOOL) alterCanZhanTableObj:(CanZhanTableObj*) showobj;

//获取所有信息
+(NSArray*) getAllCanZhanTableObj;
//获取某 图片的 信息
+(CanZhanTableObj*) getOneCanZhanTableInfoShowid:(NSString*) showid;


//-------------------------产品发布------------------------------
+(BOOL) addCanZhanReleaseTableObj:(CanZhanReleaseTableObj*) releaseobj;
+(BOOL) deleteCanZhanReleaseTableObj:(CanZhanReleaseTableObj*) releaseobj;
+(BOOL) alterCanZhanReleaseTableObj:(CanZhanReleaseTableObj*) releaseobj;

//获取所有信息
+(NSArray*) getAllCanZhanReleaseTableObj;
//获取某 图片的 信息
+(CanZhanReleaseTableObj*) getOneReleaseProTableInfoShowid:(NSString*) proid;
//获取所有信息
+(NSArray*) getSomeCanZhanReleaseTableObjByType:(NSString*) type;


//-------------------------产品类别------------------------------
+(BOOL) addProTypeTableObj:(ProTypeTableObj*) protypeobj;
+(BOOL) deleteProTypeTableObj:(ProTypeTableObj*) protypeobj;
+(BOOL) alterProTypeTableObj:(ProTypeTableObj*) protypeobj;

//获取所有信息
+(NSArray*) getAllProTypeTableObj;
//获取某 图片的 信息
+(ProTypeTableObj*) getOneProTypeTableInfoShowid:(NSString*) protypeid;

//-------------------------调查明细------------------------------
+(BOOL) addDiaoChaDetailTableObj:(DiaoChanDetailTableObj*) detailobj;
+(BOOL) deleteDiaoChaDetailTableObj:(DiaoChanDetailTableObj*) detailobj;
+(BOOL) alterDiaoChaDetailTableObj:(DiaoChanDetailTableObj*) detailobj;

//获取所有信息
+(NSArray*) getAllDiaoChaDetailTableObj;
//获取某 图片的 信息
+(DiaoChanDetailTableObj*) getOneDiaoChaDetailTableInfoDetailid:(NSString*) detailid;
//获取所有信息
+(NSArray*) getSomeDiaoChaDetailTableObjById:(NSString*) diaochaid;

//-------------------------调查------------------------------
+(BOOL) addDiaoChaTableObj:(DiaoChaTableObj*) diaochaobj;
+(BOOL) deleteDiaoChaTableObj:(DiaoChaTableObj*) diaochaobj;
+(BOOL) alterDiaoChaTableObj:(DiaoChaTableObj*) diaochaobj;

//获取所有信息
+(NSArray*) getAllDiaoChaTableObj;
//获取某 图片的 信息
+(DiaoChaTableObj*) getOneDiaoChaTableInfoDiaoChaid:(NSString*) diaochaid;


//-------------------------公司图片------------------------------
+(BOOL) addGongSiTableObj:(GongSiImageTableObj*) gongsiobj;
+(BOOL) deleteGongSiTableObj:(GongSiImageTableObj*) gongsiobj;
+(BOOL) alterGongSiTableObj:(GongSiImageTableObj*) gongsiobj;

//获取所有信息
+(NSArray*) getAllGongSiTableObj;
//获取某 图片的 信息
+(GongSiImageTableObj*) getOneGongSiTableInfoGongSiid:(NSString*) gongsiobj;


//-------------------------房间图片------------------------------
+(BOOL) addImageTableObj:(ImageTableObj*)imageobj;
+(BOOL) deleteImageTableObj:(ImageTableObj*) imageobj;
+(BOOL) alterImageTableObj:(ImageTableObj*) imageobj;

//获取所有信息
+(NSArray*) getAllImageTableObj;
//获取某 图片的 信息
+(ImageTableObj*) getOneImageTableInfoImageid:(NSString*) imageid;

//-------------------------站位产品------------------------------
+(BOOL) addZhanWeiProTableObj:(ZhanWeiProTableObj*) zhanweiproobj;
+(BOOL) deleteZhanWeiProTableObj:(ZhanWeiProTableObj*) zhanweiproobj;
+(BOOL) alterZhanWeiProTableObj:(ZhanWeiProTableObj*) zhanweiproobj;

//获取所有信息
+(NSArray*) getAllZhanWeiProTableObj;
//获取某 图片的 信息
+(ZhanWeiProTableObj*) getOneZhanWeiProTableInfoProId:(NSString*) proid;
//获取 同一展位 的产品
+(NSArray*) getSomeZhanWeiProTableInfoZWId:(NSString*) zhanweiid;

//-------------------------站位信息------------------------------
+(BOOL) addZhanWeiInfoTableObj:(ZhanWeiInfoTableObj*) zhanweiinfoobj;
+(BOOL) deleteZhanWeiInfoTableObj:(ZhanWeiInfoTableObj*) zhanweiinfoobj;
+(BOOL) alterZhanWeiInfoTableObj:(ZhanWeiInfoTableObj*) zhanweiinfoobj;

//获取所有信息
+(NSArray*) getAllZhanWeiInfoTableObj;
//获取某 图片的 信息
+(ZhanWeiInfoTableObj*) getOneZhanWeiInfoTableInfoProId:(NSString*) zhanweiid;
//获取某 zhanweixin  信息
+(NSArray*) getOneZhanWeiInfoByZhanweiId:(NSString*) zhanweiid;

//-------------------------总版本------------------------------
+(BOOL) addVersionTableObj:(NSString*) version;
+(BOOL) deleteVersionTableObj;
+(NSString*) getAllVersionTableObj;


//-------------------------场景信息------------------------------
+(BOOL) addChangJingInfoTableObj:(ChangJinTableObj*)changjingobj;
+(BOOL) deleteChangJingInfoTableObj:(ChangJinTableObj*) changjingobj;
+(BOOL) alterChangJingInfoTableObj:(ChangJinTableObj*) changjingobj;

//获取所有信息
+(NSArray*) getAllChangJingInfoTableObj;
//获取某 图片的 信息
+(ChangJinTableObj*) getOneChangJingTableInfoChangJingId:(NSString*) changjingId;
//获取某 zhanweixin  信息
+(NSArray*) getOneZChangJingInfoByProductId:(NSString*) productid;


//-------------------------调查选项------------------------------
+(BOOL) addDiaochaItemInfoTableObj:(DiaoChaItemTableObj*)itemobj;
+(BOOL) deleteDiaochaItemInfoTableObj:(DiaoChaItemTableObj*) itemobj;
+(BOOL) alterDiaochaItemInfoTableObj:(DiaoChaItemTableObj*) itemobj;

//获取所有信息
+(NSArray*) getAllDiaochaItemInfoTableObj;
//获取某 图片的 信息
+(DiaoChaItemTableObj*) getOneDiaochaItemTableInfoItemId:(NSString*) itemId;
//获取某 zhanweixin  信息
+(NSArray*) getOneDiaochaItemInfoByDiaochaId:(NSString*) diaochaId;

@end
