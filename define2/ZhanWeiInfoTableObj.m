//
//  ZhanWeiInfoTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZhanWeiInfoTableObj.h"

@implementation ZhanWeiInfoTableObj
@synthesize m_flag,m_versionId,m_showId,m_showInfoId,m_showInfoImageId;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_flag = 2;
        self.m_showId = nil;
        self.m_showInfoId = nil;
        self.m_showInfoImageId = nil;
    }
    return self;
}

-(void) dealloc
{
    [m_showId release];
    [m_showInfoId release];
    [m_showInfoImageId release];
    
    [m_versionId release];
    [super dealloc];
}

@end
