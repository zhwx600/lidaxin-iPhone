//
//  CanZhanReleaseTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CanZhanReleaseTableObj.h"

@implementation CanZhanReleaseTableObj
@synthesize m_flag,m_versionId,m_imageId,m_productId,m_productCls,m_changjingDescription;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_flag = 2;
        self.m_productCls = nil;
        self.m_imageId = nil;
        self.m_productId = nil;
        self.m_changjingDescription = nil;
    }
    return self;
}

-(void) dealloc
{
    [m_productId release];
    [m_productCls release];
    [m_imageId release];
    
    [m_versionId release];
    [m_changjingDescription release];
    [super dealloc];
}

@end
