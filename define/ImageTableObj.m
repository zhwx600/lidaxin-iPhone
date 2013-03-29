//
//  ImageTableObj.m
//  LiDaXin-iPad
//
//  Created by apple on 12-9-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageTableObj.h"

@implementation ImageTableObj

@synthesize m_imageId,m_roomId,m_imageUrl,m_bulbVersionId,m_posTableObjArr,m_description,m_flag;

-(id) init
{
    if (self = [super init]) {
        self.m_imageId = nil;
        self.m_roomId = nil;
        self.m_imageUrl = nil;
        self.m_bulbVersionId = nil;
        self.m_posTableObjArr = nil;
        self.m_description = nil;
        self.m_flag = 2;
    }
    return self;
}

-(void) dealloc
{
    [m_roomId release];
    [m_imageId release];
    [m_bulbVersionId release];
    [m_imageUrl release];
    [m_posTableObjArr release];
    [m_description release];
    [super dealloc];
}

@end
