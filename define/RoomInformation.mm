//
//  RoomInformation.m
//  LiDaXin-iPad
//
//  Created by apple on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoomInformation.h"
#import "BulbDetailParam.h"

@implementation RoomInformation
@synthesize m_bulbInforArr;

-(id) init
{
    if (self = [super init]) {
        self.m_bulbInforArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}


-(void) initArrWithData:(S_Data *)data
{
    string hallidList = data->params["hallid"];
    string roomidList = data->params["roomid"];
    string roomnameList = data->params["roomname"];
    string imageurlList = data->params["imageurl"];
    string posxList = data->params["posx"];
    string posyList = data->params["posy"];
    string radiusList = data->params["radius"];
    
    
    
    NSStringEncoding enc = NSUTF8StringEncoding;
    int index = 0;
    string sTemp;
    while (1) {
        
        index = hallidList.find(",");
        if (-1 == index) {
            break;
        }
        BulbDetailParam* temBulb = [[BulbDetailParam alloc] init];
        
        sTemp = hallidList.substr(0,index);
        hallidList = hallidList.substr(index+1,hallidList.length());
        temBulb.m_param1 = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        
        //-------
        index = roomidList.find(",");
        sTemp = roomidList.substr(0,index);
        roomidList = roomidList.substr(index+1,roomidList.length());
        temBulb.m_param2 = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        //-------
        index = roomnameList.find(",");
        sTemp = roomnameList.substr(0,index);
        roomnameList = roomnameList.substr(index+1,roomnameList.length());
        temBulb.m_param3 = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        //-------
        index = imageurlList.find(",");
        sTemp = imageurlList.substr(0,index);
        imageurlList = imageurlList.substr(index+1,imageurlList.length());
        temBulb.m_param4 = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        //-------
        index = posxList.find(",");
        sTemp = posxList.substr(0,index);
        posxList = posxList.substr(index+1,posxList.length());
        temBulb.m_param5 = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        //-------
        index = posyList.find(",");
        sTemp = posyList.substr(0,index);
        posyList = posyList.substr(index+1,posyList.length());
        temBulb.m_param6 = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        //-------
        index = radiusList.find(",");
        sTemp = radiusList.substr(0,index);
        radiusList = radiusList.substr(index+1,radiusList.length());
        temBulb.m_param7 = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        
        [self.m_bulbInforArr addObject:temBulb];
        
        NSLog(@"roomname = %@, radius = %@",temBulb.m_param5,temBulb.m_param4);
        
        [temBulb release];
        
        
    }
    
    
}


-(void) dealloc
{
    
    [m_bulbInforArr release];
    
    [super dealloc]; 
}

@end
