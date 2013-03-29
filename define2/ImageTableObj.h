//
//  ImageTableObj.h
//  lidaxin-iPhone
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageTableObj : NSObject
@property (nonatomic,retain) NSString* m_imageId;
@property (nonatomic,retain) NSString* m_imageUrl;
@property (nonatomic,retain) NSString* m_imageType;
@property (nonatomic,retain) NSString* m_imageDescription;
@property (nonatomic,retain) NSString* m_versionId;
@property (nonatomic)int m_flag;//下在数据时 标记操作 类型 -1 删除，0修改，1添

//产品 分类 显示用
@property (nonatomic,retain)NSMutableArray* m_typeProArray;
@property (nonatomic)BOOL m_bIsOpen;

@end
