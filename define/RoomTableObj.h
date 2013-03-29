//
//  RoomTableObj.h
//  LiDaXin-iPad
//
//  Created by apple on 12-9-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomTableObj : NSObject

@property (nonatomic,retain) NSString* m_roomId;
@property (nonatomic,retain) NSString* m_roomName;
@property (nonatomic,retain) NSString* m_hallId;
@property (nonatomic,retain) NSMutableArray* m_imageTableObjArr;

@end
