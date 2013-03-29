//
//  ReplaceProductTableObj.h
//  LiDaXin-iPad
//
//  Created by apple on 12-9-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplaceProductTableObj : NSObject

@property (nonatomic,retain) NSString* m_replaceProductId;//替换的产品id
@property (nonatomic,retain) NSString* m_faceProductId;//绑定的正面的 产品id
@property (nonatomic,retain) NSString* m_replaceProductImage;
@property (nonatomic,retain) NSString* m_replaceProductVersionId;
@property (nonatomic)int m_flag;//下在数据时 标记操作 类型 -1 删除，0修改，1添加

@end
