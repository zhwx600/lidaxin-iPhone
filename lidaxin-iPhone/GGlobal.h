//
//  GGlobal.h
//  lidaxin-iPhone
//
//  Created by apple on 12-11-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#define CUXIAO_PRODUCT_TYPE_NAME @"促销"
#define XINPIN_PRODUCT_TYPE_NAME @"新品"
#define ZHANPIN_PRODUCT_TYPE_NAME @"展品"

#import <Foundation/Foundation.h>

@interface GGlobal : NSObject

@property (nonatomic) bool m_zhanweiViewFresh;
@property (nonatomic) bool m_diaochanViewFresh;
@property (nonatomic) bool m_zhanweiListViewFresh;
@property (nonatomic) NSString* m_productType;

+(GGlobal*)getGlobalInstance;

@end
