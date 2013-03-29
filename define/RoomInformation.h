//
//  RoomInformation.h
//  LiDaXin-iPad
//
//  Created by apple on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "xmlCommand.h"

@interface RoomInformation : NSObject

@property (nonatomic,retain)NSMutableArray* m_bulbInforArr;


-(void) initArrWithData:(S_Data*) data;

@end
