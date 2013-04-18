//
//  GGlobal.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GGlobal.h"


@implementation GGlobal

@synthesize m_zhanweiViewFresh;
@synthesize m_diaochanViewFresh;
@synthesize m_zhanweiListViewFresh;
@synthesize m_productType;

+(GGlobal*) getGlobalInstance
{
    static GGlobal* g_global = nil;
    
    if (!g_global) {
        g_global = [[GGlobal alloc] init];
    }
    return g_global;
}

-(id) init
{
    if (self = [super init]) {
        
        m_zhanweiViewFresh = NO;
        m_diaochanViewFresh = NO;
        m_zhanweiListViewFresh = NO;
    }
    return  self;
}




-(void) dealloc
{
    [m_productType release];
    [super dealloc];
}

@end
