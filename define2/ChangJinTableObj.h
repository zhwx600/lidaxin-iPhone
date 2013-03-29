//
//  ChangJinTableObj.h
//  lidaxin-iPhone
//
//  Created by apple on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangJinTableObj : NSObject

@property (nonatomic,retain) NSString* m_changjinId;
@property (nonatomic,retain) NSString* m_typeName;
@property (nonatomic,retain) NSString* m_productId;
@property (nonatomic,retain) NSString* m_imageId;
@property (nonatomic,retain) NSString* m_versionId;
@property (nonatomic)int m_flag;//下在数据时 标记操作 类型 -1 删除，0修改，1添

@end
