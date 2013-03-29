//
//  HallInformation.h
//  LiDaXin-iPad
//
//  Created by apple on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "xmlCommand.h"

@interface HallInformation : NSObject

@property (nonatomic,retain)NSMutableArray* m_roomInforArr;


-(void) initArrWithData:(S_Data*) data;

@end
