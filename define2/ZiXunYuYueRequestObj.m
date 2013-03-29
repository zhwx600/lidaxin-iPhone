//
//  ZiXunYuYueRequestObj.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZiXunYuYueRequestObj.h"

@implementation ZiXunYuYueRequestObj
@synthesize m_flag,m_email,m_proId,m_todate,m_company,m_contact,m_description,m_fromid,m_dcId,m_selId;

@synthesize m_tel,m_name,m_country;

-(id) init
{
    if (self = [super init]) {
        self.m_company = nil;
        self.m_flag = 1;
        self.m_contact = nil;
        self.m_description = nil;
        self.m_todate = nil;
        self.m_proId = nil;
        self.m_email = nil;
        self.m_dcId = nil;
        self.m_selId = nil;
        self.m_tel = nil;
        self.m_country = nil;
        self.m_name = nil;
        self.m_fromid = nil;
    }
    return self;
}

-(void) dealloc
{
    [m_company release];
    [m_contact release];
    [m_description release];
    [m_todate release];
    [m_email release];
    [m_proId release];
    [m_dcId release];
    [m_selId release];
    
    [m_tel release];
    [m_name release];
    [m_country release];
    [m_fromid release];
    
    [super dealloc];
}
@end
