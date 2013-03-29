//
//  GGlobal.h
//  lidaxin-iPhone
//
//  Created by apple on 12-11-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGlobal : NSObject

@property (nonatomic) bool m_zhanweiViewFresh;
@property (nonatomic) bool m_diaochanViewFresh;
@property (nonatomic) bool m_zhanweiListViewFresh;

+(GGlobal*)getGlobalInstance;

@end
