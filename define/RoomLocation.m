//
//  RoomLocation.m
//  LiDaXin-iPad
//
//  Created by apple on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomLocation.h"

@implementation RoomLocation
@synthesize m_hallId,m_roomId,m_roomName,m_imageUrl,m_posX,m_posY,m_posRadius;

-(id) init
{
    if (self = [super init]) {
        self.m_hallId = nil;
        self.m_roomId = nil;
        self.m_roomName = nil;
        self.m_imageUrl = nil;
        self.m_posX = nil;
        self.m_posY = nil;
        self.m_posRadius = nil;
    }
    
    return self;
}


-(void) dealloc
{
    [m_roomId release];
    [m_roomName release];
    [m_hallId release];
    [m_imageUrl release];
    [m_posX release];
    [m_posRadius release];
    [m_posY release];
    
    [super dealloc]; 
}


@end
