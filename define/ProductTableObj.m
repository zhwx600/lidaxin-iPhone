//
//  ProductTableObj.m
//  LiDaXin-iPad
//
//  Created by apple on 12-9-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProductTableObj.h"

@implementation ProductTableObj

@synthesize m_bulbId,m_bulbType,m_bulbImage,m_bulbParam,m_bulbVersionId,m_flag;

-(id) init
{
    if (self = [super init]) {
        self.m_bulbId = nil;
        self.m_bulbImage = nil;
        self.m_bulbParam = nil;
        self.m_bulbType = nil;
        self.m_bulbVersionId = nil;
        self.m_flag = 2;
    }
    return self;
}


-(void) dealloc
{
    [m_bulbType release];
    [m_bulbId release];
    [m_bulbImage release];
    [m_bulbVersionId release];
    [m_bulbParam release];
    
    [super dealloc];
}

@end
