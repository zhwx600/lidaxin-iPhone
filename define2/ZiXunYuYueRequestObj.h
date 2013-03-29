//
//  ZiXunYuYueRequestObj.h
//  lidaxin-iPhone
//
//  Created by apple on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZiXunYuYueRequestObj : NSObject
@property (nonatomic,retain) NSString* m_proId;
@property (nonatomic,retain) NSString* m_company;
@property (nonatomic,retain) NSString* m_contact;
@property (nonatomic,retain) NSString* m_email;
@property (nonatomic,retain) NSString* m_todate;//日期 预约 才有的
@property (nonatomic,retain) NSString* m_description;

@property (nonatomic,retain) NSString* m_fromid;
@property (nonatomic,retain) NSString* m_dcId;
@property (nonatomic,retain) NSString* m_selId;// diaocha

@property (nonatomic,retain)NSString* m_country;
@property (nonatomic,retain)NSString* m_name;
@property (nonatomic,retain)NSString* m_tel;

@property (nonatomic)int m_flag;//1 预约  0咨询
@end
