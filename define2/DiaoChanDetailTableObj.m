//
//  DiaoChanDetailTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DiaoChanDetailTableObj.h"

@implementation DiaoChanDetailTableObj
@synthesize m_flag,m_versionId,m_detailId,m_diaochaId,m_diaochaContent;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_flag = 2;
        self.m_diaochaId = nil;
        self.m_detailId = nil;
        self.m_diaochaContent = nil;
    }
    return self;
}

-(void) dealloc
{
    [m_diaochaContent release];
    [m_diaochaId release];
    [m_detailId release];
    
    [m_versionId release];
    [super dealloc];
}
@end
