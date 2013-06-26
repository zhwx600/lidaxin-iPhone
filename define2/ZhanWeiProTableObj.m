//
//  ZhanWeiProTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZhanWeiProTableObj.h"

@implementation ZhanWeiProTableObj
@synthesize m_flag,m_versionId,m_showId,m_showProId,m_showProImageId,m_changjingDescription;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_flag = 2;
        self.m_showId = nil;
        self.m_showProId = nil;
        self.m_showProImageId = nil;
        self.m_changjingDescription = nil;
        self.m_order = 0;
    }
    return self;
}

-(void) dealloc
{
    [m_showId release];
    [m_showProId release];
    [m_showProImageId release];
    [m_changjingDescription release];
    [m_versionId release];
    [super dealloc];
}
@end
