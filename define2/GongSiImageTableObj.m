//
//  GongSiImageTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GongSiImageTableObj.h"

@implementation GongSiImageTableObj
@synthesize m_flag,m_versionId,m_companyId,m_companyImageId,m_companyDescription;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_flag = 2;
        self.m_companyId = nil;
        self.m_companyImageId = nil;
        self.m_companyDescription = nil;
    }
    return self;
}

-(void) dealloc
{
    [m_companyId release];
    [m_companyImageId release];
    [m_companyDescription release];
    
    [m_versionId release];
    [super dealloc];
}
@end
