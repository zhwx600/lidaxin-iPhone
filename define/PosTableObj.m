//
//  PosTableObj.m
//  LiDaXin-iPad
//
//  Created by zheng wanxiang on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PosTableObj.h"

@implementation PosTableObj

@synthesize m_posX,m_posY,m_bulbId,m_posId,m_versionId,m_imageId,m_flag,m_posName;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_posY = nil;
        self.m_posX = nil;
        self.m_posId = nil;
        self.m_bulbId = nil;
        self.m_imageId = nil;
        self.m_posName = nil;
        self.m_flag = 2;
    }
    return self;
}

-(void) dealloc
{
    [m_posX release];
    [m_posY release];
    [m_versionId release];
    [m_posId release];
    [m_bulbId release];
    [m_imageId release];
    [m_posName release];
    [super dealloc];
}


@end
