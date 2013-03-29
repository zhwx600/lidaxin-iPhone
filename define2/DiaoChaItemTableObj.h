//
//  DiaoChaItemTableObj.h
//  lidaxin-iPhone
//
//  Created by apple on 13-3-12.
//
//

#import <Foundation/Foundation.h>

//调查选项表
@interface DiaoChaItemTableObj : NSObject
@property (nonatomic,retain) NSString* m_diaochaItemId;
@property (nonatomic,retain) NSString* m_diaochaId;
@property (nonatomic,retain) NSString* m_diaochaQuestion;
@property (nonatomic,retain) NSString* m_versionId;
@property (nonatomic)int m_flag;//下在数据时 标记操作 类型 -1 删除，0修改，1添

@property (nonatomic,retain) NSString* m_selectDidaoDetailId;
@property (nonatomic,retain) NSMutableArray* m_itemArray;
@property (nonatomic) bool m_bIsOpen;

@end
