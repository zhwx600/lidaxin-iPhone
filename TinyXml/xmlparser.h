//
//  xmlparser.h
//  TinyXml
//
//  Created by user on 11-7-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#pragma once
#include "xmlCommand.h"

class xmlparser
{
public:
    
    static void Encode(S_Data *sData,string &xml);
    static bool Decode(const char *xml,S_Data *sData);
    
};



@interface MyXMLParser : NSObject {

}

+(NSString*) EncodeToStr:(NSObject*) obj Type:(NSString*) type;

+(NSObject*) DecodeToObj:(NSString*) str;

@end
