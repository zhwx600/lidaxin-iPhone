//
//  BulbDetailParam.m
//  LiDaXin-iPad
//
//  Created by apple on 12-9-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BulbDetailParam.h"

@implementation BulbDetailParam

@synthesize m_image,m_param1,m_param2,m_param3,m_param4,m_param5,m_param6,m_param7;

-(id) init
{
    if (self = [super init]) {
        self.m_image = nil;
        self.m_param1 = nil;
        self.m_param2 = nil;
        self.m_param3 = nil;
        self.m_param4 = nil;
        self.m_param5 = nil;
        self.m_param6 = nil;
        self.m_param7 = nil;
    }
    
    return self;
}


-(void) dealloc
{
    [m_image release];
    [m_param1 release];
    [m_param2 release];
    [m_param3 release];
    [m_param4 release];
    [m_param5 release];
    [m_param6 release];
    [m_param7 release];
    
    [super dealloc]; 
}

@end
