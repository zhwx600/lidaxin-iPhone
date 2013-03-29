//
//  ImageTableObj.h
//  LiDaXin-iPad
//
//  Created by apple on 12-9-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageTableObj : NSObject

@property (nonatomic,retain) NSString* m_imageId;
@property (nonatomic,retain) NSString* m_imageUrl;
@property (nonatomic,retain) NSString* m_roomId;
@property (nonatomic,retain) NSString* m_description;
@property (nonatomic,retain) NSString* m_bulbVersionId;
@property (nonatomic,retain) NSMutableArray* m_posTableObjArr;
@property (nonatomic)int m_flag;//下在数据时 标记操作 类型 -1 删除，0修改，1添加

@end
