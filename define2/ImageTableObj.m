//
//  ImageTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageTableObj.h"

@implementation ImageTableObj
@synthesize m_flag,m_versionId,m_imageId,m_imageUrl,m_imageType,m_imageDescription,m_typeProArray,m_bIsOpen;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_flag = 2;
        self.m_imageUrl = nil;
        self.m_imageId = nil;
        self.m_imageType = nil;
        self.m_imageDescription = nil;
        self.m_typeProArray = nil;
        self.m_bIsOpen = NO;
    }
    return self;
}

-(void) dealloc
{
    [m_imageId release];
    [m_imageUrl release];
    [m_imageType release];
    [m_imageDescription release];
    [m_typeProArray release];
    [m_versionId release];
    [super dealloc];
}
@end
