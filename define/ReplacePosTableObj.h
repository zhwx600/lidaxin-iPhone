//
//  ReplacePosTableObj.h
//  LiDaXin-iPad
//
//  Created by apple on 12-9-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplacePosTableObj : NSObject

@property (nonatomic,retain) NSString* m_replacePosId;//替换坐标id
@property (nonatomic,retain) NSString* m_hotPosId;//热点坐标 id
@property (nonatomic,retain) NSString* m_replaceProductId;//替换产品id
@property (nonatomic,retain) NSString* m_faceProductId;//正面的产品id
@property (nonatomic,retain) NSString* m_posX;//替换产品的 坐标
@property (nonatomic,retain) NSString* m_posY;
@property (nonatomic,retain) NSString* m_versionId;
@property (nonatomic)int m_flag;//下在数据时 标记操作 类型 -1 删除，0修改，1添加

@end
