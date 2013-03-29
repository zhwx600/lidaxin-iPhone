//
//  ChangJinTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ChangJinTableObj.h"

@implementation ChangJinTableObj
@synthesize m_flag,m_versionId,m_imageId,m_typeName,m_productId,m_changjinId;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_flag = 2;
        self.m_changjinId = nil;
        self.m_productId = nil;
        self.m_typeName = nil;
        self.m_imageId = nil;
    }
    return self;
}

-(void) dealloc
{
    [m_imageId release];
    [m_typeName release];
    [m_productId release];
    [m_changjinId release];
    [m_versionId release];

    [super dealloc];
}

@end
