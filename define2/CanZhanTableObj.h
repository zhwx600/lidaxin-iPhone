//
//  CanZhanTableObj.h
//  lidaxin-iPhone
//
//  Created by apple on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CanZhanTableObj : NSObject

@property (nonatomic,retain) NSString* m_canzhanId;//替换坐标id
@property (nonatomic,retain) NSString* m_canzhanName;//热点坐标 id
@property (nonatomic,retain) NSString* m_zhanhuiDescription;//热点坐标 id
@property (nonatomic,retain) NSString* m_versionId;
@property (nonatomic)int m_flag;//下在数据时 标记操作 类型 -1 删除，0修改，1添加




//产品 分类 显示用
@property (nonatomic,retain)NSMutableArray* m_typeCanZhanArray;
@property (nonatomic)BOOL m_bIsOpen;

@end
