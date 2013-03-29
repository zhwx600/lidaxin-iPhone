//
//  PosTableObj.h
//  LiDaXin-iPad
//
//  Created by zheng wanxiang on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PosTableObj : NSObject

@property (nonatomic,retain) NSString* m_posId;
@property (nonatomic,retain) NSString* m_posName;
@property (nonatomic,retain) NSString* m_imageId;
@property (nonatomic,retain) NSString* m_bulbId;
@property (nonatomic,retain) NSString* m_posX;
@property (nonatomic,retain) NSString* m_posY;
@property (nonatomic,retain) NSString* m_versionId;
@property (nonatomic)int m_flag;//下在数据时 标记操作 类型 -1 删除，0修改，1添加
@end
