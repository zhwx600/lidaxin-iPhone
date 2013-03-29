//
//  DiaoChaItemTableObj.m
//  lidaxin-iPhone
//
//  Created by apple on 13-3-12.
//
//

#import "DiaoChaItemTableObj.h"

@implementation DiaoChaItemTableObj
@synthesize m_flag,m_versionId,m_diaochaId,m_diaochaItemId,m_diaochaQuestion,m_selectDidaoDetailId,m_itemArray,m_bIsOpen;

-(id) init
{
    if (self = [super init]) {
        self.m_versionId = nil;
        self.m_flag = 2;
        self.m_diaochaId = nil;
        self.m_diaochaItemId = nil;
        self.m_diaochaQuestion = nil;
        
        self.m_selectDidaoDetailId = nil;
        self.m_itemArray = nil;
        m_bIsOpen = YES;
    }
    return self;
}

-(void) dealloc
{
    [m_diaochaId release];
    [m_diaochaItemId release];
    [m_diaochaQuestion release];
    [m_versionId release];
    [m_selectDidaoDetailId release];
    [m_itemArray release];
    
    [super dealloc];
}

@end
