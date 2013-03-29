//
//  HallInformation.m
//  LiDaXin-iPad
//
//  Created by apple on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HallInformation.h"
#import "RoomLocation.h"

@implementation HallInformation

@synthesize m_roomInforArr;

-(id) init
{
    if (self = [super init]) {
        self.m_roomInforArr = [[NSMutableArray alloc] init];
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
        RoomLocation* temRoom = [[RoomLocation alloc] init];
        
        sTemp = hallidList.substr(0,index);
        hallidList = hallidList.substr(index+1,hallidList.length());
        temRoom.m_hallId = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        
        //-------
        index = roomidList.find(",");
        sTemp = roomidList.substr(0,index);
        roomidList = roomidList.substr(index+1,roomidList.length());
        temRoom.m_roomId = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        //-------
        index = roomnameList.find(",");
        sTemp = roomnameList.substr(0,index);
        roomnameList = roomnameList.substr(index+1,roomnameList.length());
        temRoom.m_roomName = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        //-------
        index = imageurlList.find(",");
        sTemp = imageurlList.substr(0,index);
        imageurlList = imageurlList.substr(index+1,imageurlList.length());
        temRoom.m_imageUrl = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        //-------
        index = posxList.find(",");
        sTemp = posxList.substr(0,index);
        posxList = posxList.substr(index+1,posxList.length());
        temRoom.m_posX = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        //-------
        index = posyList.find(",");
        sTemp = posyList.substr(0,index);
        posyList = posyList.substr(index+1,posyList.length());
        temRoom.m_posY = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        //-------
        index = radiusList.find(",");
        sTemp = radiusList.substr(0,index);
        radiusList = radiusList.substr(index+1,radiusList.length());
        temRoom.m_posRadius = [[NSString alloc] initWithCString:sTemp.c_str() encoding:enc];
        
        [self.m_roomInforArr addObject:temRoom];
        
        NSLog(@"roomname = %@, radius = %@",temRoom.m_roomName,temRoom.m_posRadius);
        
        [temRoom release];
        
        
    }
    
 
}


-(void) dealloc
{

    [m_roomInforArr release];
    
    [super dealloc]; 
}



@end
