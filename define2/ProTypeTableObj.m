//
//  ProTypeTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProTypeTableObj.h"

@implementation ProTypeTableObj
@synthesize m_flag,m_versionId,m_typeId,m_typeName;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_flag = 2;
        self.m_typeName = nil;
        self.m_typeId = nil;
    }
    return self;
}

-(void) dealloc
{
    [m_typeId release];
    [m_typeName release];
    
    [m_versionId release];
    [super dealloc];
}
@end
