#ifndef _XMLCOMMANDDEFINE_H
#define _XMLCOMMANDDEFINE_H

#import <CoreFoundation/CoreFoundation.h>

#include <vector>
#include <string>
#include <map>
#include <sys/time.h>
using namespace std;


#define PARAM_SPARETESTR @"$paramSeparate$"
#define PARAM_KONGGE @"&nbsp"

struct S_Data
{
    string commandName;
    map<string, string> params;
    void clean()
    {
        commandName = "";
        params.clear();
    };
};


#define XMLSTR @"<?xml version=\"1.0\" encoding=\"utf-8\" ?> \
<command>\
<name>1001</name>\
<params>\
\
<param>\
<key>hallid</key>\
<value>1,1,1,1,1,</value>\
</param>\
\
<param>\
<key>roomid</key>\
<value>1,2,3,4,5,</value>\
</param>\
\
<param>\
<key>roomname</key>\
<value>房间1,房间2,房间3,房间4,房间5,</value>\
</param>\
\
<param>\
<key>imageurl</key>\
<value>url1,url2,url3,url4,url5,</value>\
</param>\
\
<param>\
<key>posx</key>\
<value>12,33,54,75,96,</value>\
</param>\
\
<param>\
<key>posy</key>\
<value>12,43,74,115,146,</value>\
</param>\
\
<param>\
<key>radius</key>\
<value>20,28,30,89,46</value>\
</param>\
\
</params>\
</command>"


//
//unsigned int GetTickCount()
//{
//	struct timeval tv;
//	if(gettimeofday(&tv,NULL)!=0)
//	{
//        return 0;
//	}
//	return (tv.tv_sec * 1000) + (tv.tv_usec / 1000);
//}


#endif