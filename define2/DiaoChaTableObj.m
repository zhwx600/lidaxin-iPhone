//
//  DiaoChaTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DiaoChaTableObj.h"

@implementation DiaoChaTableObj
@synthesize m_flag,m_versionId,m_diaochaId,m_diaochaName;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_flag = 2;
        self.m_diaochaId = nil;
        self.m_order = 0;
        self.m_diaochaName = nil;
    }
    return self;
}

-(void) dealloc
{
    [m_diaochaId release];
    [m_diaochaName release];
    
    [m_versionId release];
    [super dealloc];
}
@end
