//
//  ReplacePosTableObj.m
//  LiDaXin-iPad
//
//  Created by apple on 12-9-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReplacePosTableObj.h"

@implementation ReplacePosTableObj
@synthesize m_flag,m_posX,m_posY,m_hotPosId,m_versionId,m_replacePosId,m_faceProductId,m_replaceProductId;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_posY = nil;
        self.m_posX = nil;
        self.m_hotPosId = nil;
        self.m_replacePosId = nil;
        self.m_replaceProductId = nil;
        self.m_faceProductId = nil;
        self.m_flag = 2;
    }
    return self;
}

-(void) dealloc
{
    [m_posX release];
    [m_posY release];
    [m_versionId release];
    [m_faceProductId release];
    [m_replacePosId release];
    [m_replaceProductId release];
    [m_hotPosId release];
    [super dealloc];
}

@end
