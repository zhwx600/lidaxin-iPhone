//
//  RoomTableObj.m
//  LiDaXin-iPad
//
//  Created by apple on 12-9-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomTableObj.h"

@implementation RoomTableObj

@synthesize m_roomId,m_hallId,m_roomName,m_imageTableObjArr;

-(id) init
{
    if (self = [super init]) {
        self.m_roomId = nil;
        self.m_roomName = nil;
        self.m_hallId = nil;
        self.m_imageTableObjArr = nil;
    }
    return self;
}

-(void) dealloc
{

    [m_roomId release];
    [m_hallId release];
    [m_roomName release];
    [m_imageTableObjArr release];
    [super dealloc];
}

@end
