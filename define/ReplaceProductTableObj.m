//
//  ReplaceProductTableObj.m
//  LiDaXin-iPad
//
//  Created by apple on 12-9-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReplaceProductTableObj.h"

@implementation ReplaceProductTableObj
@synthesize m_faceProductId,m_replaceProductId,m_flag,m_replaceProductImage,m_replaceProductVersionId;

-(id) init
{
    if (self = [super init]) {
        self.m_replaceProductVersionId = nil;
        self.m_replaceProductImage = nil;
        self.m_replaceProductId = nil;
        self.m_faceProductId = nil;
        self.m_flag = 2;
    }
    return self;
}

-(void) dealloc
{
    [m_replaceProductImage release];
    [m_replaceProductId release];
    [m_replaceProductVersionId release];
    [m_faceProductId release];

    [super dealloc];
}

@end
