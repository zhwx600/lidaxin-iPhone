//
//  CanZhanTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CanZhanTableObj.h"

@implementation CanZhanTableObj
@synthesize m_flag,m_canzhanId,m_versionId,m_canzhanName,m_zhanhuiDescription,m_typeCanZhanArray,m_bIsOpen;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_canzhanId = nil;
        self.m_zhanhuiDescription = nil;
        self.m_canzhanName = nil;
        self.m_flag = 2;
        self.m_bIsOpen = NO;
        self.m_typeCanZhanArray = nil;
    }
    return self;
}

-(void) dealloc
{
    [m_canzhanId release];
    [m_canzhanName release];
    [m_versionId release];
    [m_zhanhuiDescription release];
    [m_typeCanZhanArray release];
    [super dealloc];
}

@end
