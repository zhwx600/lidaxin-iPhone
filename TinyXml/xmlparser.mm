//
//  xmlparser.cpp
//  TinyXml
//
//  Created by user on 11-7-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#include "xmlparser.h"
#include "tinyxml.h"


#import "CanZhanTableObj.h"
#import "CanZhanReleaseTableObj.h"
#import "ProTypeTableObj.h"
#import "DiaoChanDetailTableObj.h"
#import "DiaoChaTableObj.h"
#import "GongSiImageTableObj.h"
#import "ImageTableObj.h"
#import "ZhanWeiProTableObj.h"
#import "ZhanWeiInfoTableObj.h"
#import "ZiXunYuYueRequestObj.h"
#import "ChangJinTableObj.h"
#import "DiaoChaItemTableObj.h"


NSCondition             *_mutexEn = NULL;
NSCondition             *_mutexDe = NULL;



void xmlparser::Encode(S_Data *sData,string &xml)
{
	TTiXmlDocument doc; 
    if(!_mutexEn)
    {
       _mutexEn = [[NSCondition alloc] init];
    }
    [_mutexEn lock];
	TTiXmlDeclaration *decl = new TTiXmlDeclaration("1.0", "utf-8", ""); 
	doc.LinkEndChild( decl );
    
	TTiXmlElement *lmtRoot = new TTiXmlElement("command"); 
	doc.LinkEndChild(lmtRoot);
//    
//	TTiXmlElement *lmtId = new TTiXmlElement("id");
//	lmtRoot->LinkEndChild(lmtId);
//    if(sData->commandId.length() <= 0)
//    {
//        printf("sData->commandId.length() <= 0\n");
//        [_mutexEn unlock];
//        return;
//    }
//	TTiXmlText *txtId = new TTiXmlText(sData->commandId.c_str());
//	lmtId->LinkEndChild(txtId);
    
	TTiXmlElement *lmtName = new TTiXmlElement("name");
	lmtRoot->LinkEndChild(lmtName);
    if(sData->commandName.length() <= 0)
    {
        printf("sData->commandName.length() <= 0\n");
        [_mutexEn unlock];
        return;
    }
	TTiXmlText *txtName = new TTiXmlText(sData->commandName.c_str());
	lmtName->LinkEndChild(txtName);
//    
//	TTiXmlElement *lmtType = new TTiXmlElement("type");
//	lmtRoot->LinkEndChild(lmtType);
//    if(sData->type.length() <= 0)
//    {
//        printf("sData->type.length() <= 0\n");
//        [_mutexEn unlock];
//        return;
//    }    
//	TTiXmlText *txtType = new TTiXmlText(sData->type.c_str());
//	lmtType->LinkEndChild(txtType);
    
	TTiXmlElement *lmtParamRoot = new TTiXmlElement("params");
	lmtRoot->LinkEndChild(lmtParamRoot);
    
    map<string, string>::iterator iter;
    for(iter = sData->params.begin(); iter != sData->params.end(); iter++)
    {
		TTiXmlElement *lmtTmp = new TTiXmlElement("param");
		lmtParamRoot->LinkEndChild(lmtTmp);
        
		TTiXmlElement *lmtKey = new TTiXmlElement("key");
		lmtTmp->LinkEndChild(lmtKey);
		TTiXmlText *txtKey = new TTiXmlText(iter->first.c_str());
		lmtKey->LinkEndChild(txtKey);
        
		TTiXmlElement *lmtValue = new TTiXmlElement("value");
		lmtTmp->LinkEndChild(lmtValue);
		TTiXmlText *txtValue = new TTiXmlText(iter->second.c_str());
        
		lmtValue->LinkEndChild(txtValue);     
	}
	TiXmlPrinter printer;
    printer.SetStreamPrinting();
	doc.Accept(&printer);
    
	xml.assign(printer.CStr());
    [_mutexEn unlock];
    //	xml.a("%s",printer.CStr());
}

bool xmlparser::Decode(const char *xml,S_Data *sData)
{
	TTiXmlDocument doc;
    if(!_mutexDe)
    {
        _mutexDe = [[NSCondition alloc] init];
    }    
    [_mutexDe lock];
	if(doc.Parse(xml)==0)
	{
        printf("TTiXmlDocument parser error\n");
        [_mutexDe unlock];
		return false;
	}

	TTiXmlElement *lmtRoot = doc.RootElement();
	if(!lmtRoot)
    {
        [_mutexDe unlock];
		return false;
    }
	TTiXmlElement *lmtName = lmtRoot->FirstChildElement("name");
	if (lmtName)
	{
//		const char *id = lmtId->GetText();
//        //		sData->commandId = atoi(id);
//        sData->commandId.assign(id);
        
        const char *name = lmtName->GetText();
        sData->commandName.assign(name);

//		TTiXmlElement *lmtName = lmtId->NextSiblingElement("name");
//		if (lmtName)
//		{
//			const char *name = lmtName->GetText();
//			sData->commandName.assign(name);
//		}
        
//        
//		TTiXmlElement *lmtType = lmtName->NextSiblingElement("type");
//		if (lmtType)
//		{
//			const char *type = lmtType->GetText();
//			sData->type.assign(type);
//		}
        
		TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("params");
		if (lmtParamRoot)
		{
            string strKey;
            string strValue;
			TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
			while (lmtTmp)
			{
				TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("key");
				if (lmtKey)
				{
					TTiXmlElement *lmtValue = lmtKey->NextSiblingElement("value");
					if (lmtValue)
					{
						strKey.assign(lmtKey->GetText());
                        
						strValue.assign(lmtValue->GetText());
						strValue = strValue=="(null)"?"":strValue;
                        
                        sData->params[strKey]=strValue;
						//sData->params.insert(pair<string, string>(strKey,strValue));
                        
                        //NSLog(@"key=%s,value=%s",strKey.c_str(),strValue.c_str());
					}
				}
                
				lmtTmp = lmtTmp->NextSiblingElement();
//                printf("%s++++\n",sData->params.at(strKey).c_str());
//                NSLog(@"%s----size=%d",sData->params.at(strKey).c_str(),sData->params.size());
//                NSLog(@"%s****size=%d",sData->params[strKey.c_str()].c_str(),sData->params.size());
			}
		}
	}
    [_mutexDe unlock];
	return true;
}


@implementation MyXMLParser

+(NSString*) EncodeToStr:(NSObject *)obj Type:(NSString *)type
{
    TTiXmlDocument doc; 
    if(!_mutexEn)
    {
        _mutexEn = [[NSCondition alloc] init];
    }
    [_mutexEn lock];
	TTiXmlDeclaration *decl = new TTiXmlDeclaration("1.0", "utf-8", ""); 
	doc.LinkEndChild( decl );
    
	TTiXmlElement *lmtRoot = new TTiXmlElement("command"); 
	doc.LinkEndChild(lmtRoot);
    
    TTiXmlElement *lmtName = new TTiXmlElement("commandid");
    lmtRoot->LinkEndChild(lmtName);
    if(type.length <= 0)
    {
        printf("type <= 0\n");
        [_mutexEn unlock];
        return nil;
    }
    TTiXmlText *txtId = new TTiXmlText([type UTF8String]);
    lmtName->LinkEndChild(txtId);
    
    //版本表
    if (0 == [type compare:@"version3"]) {
        
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestver");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("version");
        lmtParamRoot->LinkEndChild(lmtTmp);
        NSString*  strin = nil;
        if (!obj || ([(NSString*)obj length] <= 0)) {
            strin = @"0";
        }else{
            strin = (NSString*)obj;
        }
        
        TTiXmlText *txtId = new TTiXmlText([strin UTF8String]);
        lmtTmp->LinkEndChild(txtId);
    //参展
    }else if(0 == [type compare:@"ihshow"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestshow");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("showid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            CanZhanTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_canzhanId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];
        //展位预约咨询
    }else if(0 == [type compare:@"zwinquiry"]){
        
        ZiXunYuYueRequestObj* temObj = (ZiXunYuYueRequestObj*)obj;
        
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestquiry");
        lmtRoot->LinkEndChild(lmtParamRoot);
        
        TTiXmlElement *lmtTmp = new TTiXmlElement("zwid");
        TTiXmlText *txtId = new TTiXmlText([temObj.m_proId UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("company");
        txtId = new TTiXmlText([temObj.m_company UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("country");
        txtId = new TTiXmlText([temObj.m_country UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("name");
        txtId = new TTiXmlText([temObj.m_name UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("tel");
        txtId = new TTiXmlText([temObj.m_tel UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("email");
        txtId = new TTiXmlText([temObj.m_email UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("todate");
        txtId = new TTiXmlText([temObj.m_todate UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("description");
        txtId = new TTiXmlText([temObj.m_description UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        //调查 请求
    }else if(0 == [type compare:@"looksubmit"]){
        
        ZiXunYuYueRequestObj* temObj = (ZiXunYuYueRequestObj*)obj;
        
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestquiry");
        lmtRoot->LinkEndChild(lmtParamRoot);
        
        TTiXmlElement *lmtTmp = new TTiXmlElement("fromid");
        TTiXmlText *txtId = new TTiXmlText([temObj.m_fromid UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("dcid");
        txtId = new TTiXmlText([temObj.m_dcId UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("selid");
        txtId = new TTiXmlText([temObj.m_selId UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("description");
        txtId = new TTiXmlText([temObj.m_description UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        //产品咨询
    }else if(0 == [type compare:@"proinquiry"]){
        
        ZiXunYuYueRequestObj* temObj = (ZiXunYuYueRequestObj*)obj;
        
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestquiry");
        lmtRoot->LinkEndChild(lmtParamRoot);
        
        TTiXmlElement *lmtTmp = new TTiXmlElement("productid");
        TTiXmlText *txtId = new TTiXmlText([temObj.m_proId UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("company");
        txtId = new TTiXmlText([temObj.m_company UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("contact");
        txtId = new TTiXmlText([temObj.m_contact UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("email");
        txtId = new TTiXmlText([temObj.m_email UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("description");
        txtId = new TTiXmlText([temObj.m_description UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);

        //产品发布
    }else if(0 == [type compare:@"ihproduct"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestproduct");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("productid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }

        for (int i=0; i<temArr.count; i++) {
            
            CanZhanReleaseTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_productId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];
        //产品类型
    }else if(0 == [type compare:@"ihprotype"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requesttype");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("typeid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            ProTypeTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_typeId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];
        //产品咨询
    }else if(0 == [type compare:@"proinquiry"]){
        
        ZiXunYuYueRequestObj* temObj = (ZiXunYuYueRequestObj*)obj;
        
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestquiry");
        lmtRoot->LinkEndChild(lmtParamRoot);
        
        TTiXmlElement *lmtTmp = new TTiXmlElement("productid");
        TTiXmlText *txtId = new TTiXmlText([temObj.m_proId UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("company");
        txtId = new TTiXmlText([temObj.m_proId UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("contact");
        txtId = new TTiXmlText([temObj.m_proId UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("email");
        txtId = new TTiXmlText([temObj.m_proId UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        lmtTmp = new TTiXmlElement("description");
        txtId = new TTiXmlText([temObj.m_proId UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        lmtParamRoot->LinkEndChild(lmtTmp);
        
                //调查明细
    }else if(0 == [type compare:@"ihlookitem"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestitem");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("itemid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            DiaoChanDetailTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_detailId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];

        //调查请求
    }else if(0 == [type compare:@"ihlook"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestlook");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("lookid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            DiaoChaTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_diaochaId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];

        //公司图片
    }else if(0 == [type compare:@"ihcompany"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestcompany");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("companyid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            GongSiImageTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_companyId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];

        //图片表请求
    }else if(0 == [type compare:@"ihimage"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestimage");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("imageid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            ImageTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_imageId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];

        //站位产品表
    }else if(0 == [type compare:@"isshowproduct"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestshowproduct");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("showproductid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            ZhanWeiProTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_showProId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];

        //展位信息
    }else if(0 == [type compare:@"ihshowitem"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestshowitem");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("showitemid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            ZhanWeiInfoTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_showId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];

        //场景
    }else if(0 == [type compare:@"ihcjlist"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestcjlist");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("cjlistid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            ChangJinTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_changjinId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];
        
       
        //调查ITEM
    }else if(0 == [type compare:@"ihlookcaption"]){
        TTiXmlElement *lmtParamRoot = new TTiXmlElement("requestcaption");
        lmtRoot->LinkEndChild(lmtParamRoot);
        TTiXmlElement *lmtTmp = new TTiXmlElement("captionid");
        lmtParamRoot->LinkEndChild(lmtTmp);
        
        NSArray* temArr = (NSArray*)obj;
        NSMutableString* temStr = [[NSMutableString alloc] init];
        
        if (!temArr || temArr.count <= 0) {
            [temStr appendString:@"0=0"];
        }
        
        for (int i=0; i<temArr.count; i++) {
            
            DiaoChaItemTableObj* proobj = [temArr objectAtIndex:i];
            
            [temStr appendFormat:@"%@=%@",proobj.m_diaochaItemId,proobj.m_versionId];
            if (i < temArr.count-1) {
                [temStr appendString:@";"];
            }
        }
        
        TTiXmlText *txtId = new TTiXmlText([temStr UTF8String]);
        lmtTmp->LinkEndChild(txtId);
        [temStr release];
        
        
    }


    
   	TiXmlPrinter printer;
    printer.SetStreamPrinting();
	doc.Accept(&printer);

    NSString* returnstr = [[[NSString alloc] initWithCString:printer.CStr() encoding:NSUTF8StringEncoding] autorelease];
    
    [_mutexEn unlock];

    return returnstr;
}

+(NSObject*) DecodeToObj:(NSString *)str
{
    TTiXmlDocument doc;
    if(!_mutexDe)
    {
        _mutexDe = [[NSCondition alloc] init];
    }    
    [_mutexDe lock];
	if(doc.Parse([str UTF8String])==0)
	{
        printf("TTiXmlDocument parser error\n");
        [_mutexDe unlock];
		return nil;
	}
    
	TTiXmlElement *lmtRoot = doc.RootElement();
	if(!lmtRoot)
    {
        [_mutexDe unlock];
		return nil;
    }
	TTiXmlElement *lmtName = lmtRoot->FirstChildElement("commandid");
	if (lmtName)
	{
        const char *name = lmtName->GetText();
        NSString* commid = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        if (0 == [commid compare:@"version3"]) {
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("requestver");
            TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
            NSString* ver = [[[NSString alloc] initWithCString:lmtTmp->GetText() encoding:NSUTF8StringEncoding] autorelease];
            [_mutexDe unlock];
            return ver;
            
            //参展请求 返回
        }else if(0 == [commid compare:@"ihshow"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {

                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    CanZhanTableObj* imageObj = [[CanZhanTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("showid");
                    imageObj.m_canzhanId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showname");
                    imageObj.m_canzhanName = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showmemo");
                    if (lmtKey) {
                        imageObj.m_zhanhuiDescription = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    }
                    
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 1;
                    
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    CanZhanTableObj* imageObj = [[CanZhanTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("showid");
                    imageObj.m_canzhanId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showname");
                    imageObj.m_canzhanName = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showmemo");
                    if (lmtKey) {
                        imageObj.m_zhanhuiDescription = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    }
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 0;
                    
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                    while (lmtTmp)
                    {
                        TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("showid");
                        CanZhanTableObj* imageObj = [[CanZhanTableObj alloc] init];
                        
                        imageObj.m_canzhanId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                        imageObj.m_flag = -1;
                        [imageArr addObject:imageObj];
                        [imageObj release];

                        //进入下一个 param
                        lmtTmp = lmtTmp->NextSiblingElement();
                        
                    }
                
            }

            [_mutexDe unlock];
            return imageArr;
            
                       
        }else if(0 == [commid compare:@"ihproduct"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    CanZhanReleaseTableObj* imageObj = [[CanZhanReleaseTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("productid");
                    imageObj.m_productId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("productcls");
                    imageObj.m_productCls = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imageid");
                    imageObj.m_imageId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("cjmemo");
                    if (lmtKey) {
                        imageObj.m_changjingDescription = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    }
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = 1;
                    
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    CanZhanReleaseTableObj* imageObj = [[CanZhanReleaseTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("productid");
                    imageObj.m_productId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("productcls");
                    imageObj.m_productCls = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imageid");
                    imageObj.m_imageId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("cjmemo");
                    if (lmtKey) {
                        imageObj.m_changjingDescription = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    }
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = 0;
                    
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("productid");
                    CanZhanReleaseTableObj* imageObj = [[CanZhanReleaseTableObj alloc] init];
                    
                    imageObj.m_productId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
            [_mutexDe unlock];
            return imageArr;

            //产品 类型
        }else if(0 == [commid compare:@"ihprotype"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ProTypeTableObj* imageObj = [[ProTypeTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("typeid");
                    imageObj.m_typeId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("typename");
                    imageObj.m_typeName = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = 1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ProTypeTableObj* imageObj = [[ProTypeTableObj alloc] init];
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("typeid");
                    imageObj.m_typeId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("typename");
                    imageObj.m_typeName = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = 0;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("typeid");
                    ProTypeTableObj* imageObj = [[ProTypeTableObj alloc] init];
                    
                    imageObj.m_typeId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
                        
            [_mutexDe unlock];
            return imageArr;
            
            //内销的 替换坐标用的
        }else if(0 == [commid compare:@"ihlookitem"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    DiaoChanDetailTableObj* imageObj = [[DiaoChanDetailTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("itemid");
                    imageObj.m_detailId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("lookid");
                    imageObj.m_diaochaId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("lookitem");
                    imageObj.m_diaochaContent = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];

                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    DiaoChanDetailTableObj* imageObj = [[DiaoChanDetailTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("itemid");
                    imageObj.m_detailId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("lookid");
                    imageObj.m_diaochaId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("lookitem");
                    imageObj.m_diaochaContent = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 0;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("itemid");
                    DiaoChanDetailTableObj* imageObj = [[DiaoChanDetailTableObj alloc] init];
                    
                    imageObj.m_detailId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
            
            [_mutexDe unlock];
            return imageArr;
            //调查请求返回
        }else if(0 == [commid compare:@"ihlook"]){
        
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    DiaoChaTableObj* imageObj = [[DiaoChaTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("lookid");
                    imageObj.m_diaochaId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("lookname");
                    imageObj.m_diaochaName= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    DiaoChaTableObj* imageObj = [[DiaoChaTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("lookid");
                    imageObj.m_diaochaId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("lookname");
                    imageObj.m_diaochaName= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 0;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("lookid");
                    DiaoChaTableObj* imageObj = [[DiaoChaTableObj alloc] init];
                    
                    imageObj.m_diaochaId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
            
            [_mutexDe unlock];
            return imageArr;
            //公司图片
        }else if(0 == [commid compare:@"ihcompany"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamBody = lmtName->NextSiblingElement("companybody");
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    GongSiImageTableObj* imageObj = [[GongSiImageTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("companyid");
                    imageObj.m_companyId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("companyimgid");
                    imageObj.m_companyImageId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_companyDescription = [[NSString alloc] initWithCString:lmtParamBody->GetText() encoding:NSUTF8StringEncoding];
                    NSLog(@"ima = %@",imageObj.m_companyDescription);

                    imageObj.m_flag = 1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                                        
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    GongSiImageTableObj* imageObj = [[GongSiImageTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("companyid");
                    imageObj.m_companyId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("companyimgid");
                    imageObj.m_companyImageId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_companyDescription = [[NSString alloc] initWithCString:lmtParamBody->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 0;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                  
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("companyid");
                    GongSiImageTableObj* imageObj = [[GongSiImageTableObj alloc] init];
                    
                    imageObj.m_companyId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
            
            [_mutexDe unlock];
            return imageArr;
            //图片请求表
        }else if(0 == [commid compare:@"ihimage"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ImageTableObj* imageObj = [[ImageTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("imageid");
                    imageObj.m_imageId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imageurl");
                    imageObj.m_imageUrl= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imagetype");
                    imageObj.m_imageType= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("description");
                    imageObj.m_imageDescription= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ImageTableObj* imageObj = [[ImageTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("imageid");
                    imageObj.m_imageId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imageurl");
                    imageObj.m_imageUrl= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imagetype");
                    imageObj.m_imageType= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("description");
                    imageObj.m_imageDescription= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 0;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("imageid");
                    ImageTableObj* imageObj = [[ImageTableObj alloc] init];
                    
                    imageObj.m_imageId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
            
            [_mutexDe unlock];
            return imageArr;
            
            //站位产品请求
        }else if(0 == [commid compare:@"isshowproduct"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ZhanWeiProTableObj* imageObj = [[ZhanWeiProTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("showproductid");
                    imageObj.m_showProId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showid");
                    imageObj.m_showId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showproductimageid");
                    imageObj.m_showProImageId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("cjmemo");
                    if (lmtKey) {
                        imageObj.m_changjingDescription = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    }
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ZhanWeiProTableObj* imageObj = [[ZhanWeiProTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("showproductid");
                    imageObj.m_showProId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showid");
                    imageObj.m_showId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showproductimageid");
                    imageObj.m_showProImageId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("cjmemo");
                    if (lmtKey) {
                        imageObj.m_changjingDescription = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    }
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 0;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("showproductid");
                    ZhanWeiProTableObj* imageObj = [[ZhanWeiProTableObj alloc] init];
                    
                    imageObj.m_showProId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
            
            [_mutexDe unlock];
            return imageArr;
            
            //站位信息
        }else if(0 == [commid compare:@"ihshowitem"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ZhanWeiInfoTableObj* imageObj = [[ZhanWeiInfoTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("showitemid");
                    imageObj.m_showInfoId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showid");
                    imageObj.m_showId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
//                    lmtKey = lmtKey->NextSiblingElement("showitemname");
//                    imageObj.m_showInfoName= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showitemimageid");
                    imageObj.m_showInfoImageId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ZhanWeiInfoTableObj* imageObj = [[ZhanWeiInfoTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("showitemid");
                    imageObj.m_showInfoId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showid");
                    imageObj.m_showId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
//                    lmtKey = lmtKey->NextSiblingElement("showitemname");
//                    imageObj.m_showInfoName= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("showitemimageid");
                    imageObj.m_showInfoImageId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 0;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("showitemid");
                    ZhanWeiInfoTableObj* imageObj = [[ZhanWeiInfoTableObj alloc] init];
                    
                    imageObj.m_showInfoId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
            
            [_mutexDe unlock];
            return imageArr;
            
            //场景信息
        }else if(0 == [commid compare:@"ihcjlist"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ChangJinTableObj* imageObj = [[ChangJinTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("cjlistid");
                    imageObj.m_changjinId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("cjlistcls");
                    imageObj.m_typeName= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
 
                    lmtKey = lmtKey->NextSiblingElement("fromid");
                    imageObj.m_productId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imageid");
                    imageObj.m_imageId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    ChangJinTableObj* imageObj = [[ChangJinTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("cjlistid");
                    imageObj.m_changjinId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("cjlistcls");
                    imageObj.m_typeName= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("fromid");
                    imageObj.m_productId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("imageid");
                    imageObj.m_imageId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];

                    imageObj.m_flag = 0;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("cjlistid");
                    ChangJinTableObj* imageObj = [[ChangJinTableObj alloc] init];
                    
                    imageObj.m_changjinId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
            
            [_mutexDe unlock];
            return imageArr;
            
            //调查选项 信息
        }else if(0 == [commid compare:@"ihlookcaption"]){
            
            NSMutableArray* imageArr = [[[NSMutableArray alloc] init] autorelease];
            
            TTiXmlElement *lmtParamRoot = lmtName->NextSiblingElement("add");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    DiaoChaItemTableObj* imageObj = [[DiaoChaItemTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("captionid");
                    imageObj.m_diaochaItemId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("lookid");
                    imageObj.m_diaochaId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("captionnm");
                    imageObj.m_diaochaQuestion= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];

                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("modify");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();
                while (lmtTmp)
                {
                    DiaoChaItemTableObj* imageObj = [[DiaoChaItemTableObj alloc] init];
                    
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("captionid");
                    imageObj.m_diaochaItemId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("lookid");
                    imageObj.m_diaochaId= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("captionnm");
                    imageObj.m_diaochaQuestion= [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    lmtKey = lmtKey->NextSiblingElement("ver");
                    imageObj.m_versionId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    
                    imageObj.m_flag = 0;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
            }
            
            lmtParamRoot = lmtParamRoot->NextSiblingElement("delete");
            
            if (lmtParamRoot)
            {
                
                TTiXmlElement *lmtTmp = lmtParamRoot->FirstChildElement();//param
                while (lmtTmp)
                {
                    TTiXmlElement *lmtKey = lmtTmp->FirstChildElement("captionid");
                    DiaoChaItemTableObj* imageObj = [[DiaoChaItemTableObj alloc] init];
                    
                    imageObj.m_diaochaItemId = [[NSString alloc] initWithCString:lmtKey->GetText() encoding:NSUTF8StringEncoding];
                    imageObj.m_flag = -1;
                    [imageArr addObject:imageObj];
                    [imageObj release];
                    
                    //进入下一个 param
                    lmtTmp = lmtTmp->NextSiblingElement();
                    
                }
                
            }
            
            
            [_mutexDe unlock];
            return imageArr;
        }

        
    }

    
    [_mutexDe unlock];
    return  nil;
}

@end










