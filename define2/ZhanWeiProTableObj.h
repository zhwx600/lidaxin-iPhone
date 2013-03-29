//
//  ZhanWeiProTableObj.h
//  lidaxin-iPhone
//
//  Created by apple on 12-11-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhanWeiProTableObj : NSObject
@property (nonatomic,retain) NSString* m_showProId;
@property (nonatomic,retain) NSString* m_showId;
@property (nonatomic,retain) NSString* m_showProImageId;
@property (nonatomic,retain) NSString* m_changjingDescription;//应用场景描述
@property (nonatomic,retain) NSString* m_versionId;
@property (nonatomic)int m_flag;//下在数据时 标记操作 类型 -1 删除，0修改，1添
@end
