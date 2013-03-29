//
//  HttpProcessor.h
//  http
//
//  Created by zheng wanxiang on 11-6-20.
//  Copyright 2011 mjxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSException.h>
#import "IDispatcher.h"

//static NSString*serverUrl = @"http://mybus.xiamentd.com:8081/XMMyGoWeb/servlet/MyGoServer.HttpPool.HttpHandlerServlet";

static NSString*serverUrl = @"http://ipad.leedarson.com:12345/IPAD/Default.aspx";
static NSMutableString* cookie=nil;

@interface HttpProcessor : NSObject {

	NSData* m_body;
	id m_mainObject;
	NSData* m_reData;
	BOOL m_haveException;

}

@property (nonatomic,retain) NSData* m_body;
@property (nonatomic,retain) NSData* m_reData;
@property (nonatomic,retain) id m_mainObject;
@property (nonatomic)SEL m_mainSel;
@property (nonatomic)bool m_recResult;//标志 是否接收返回

-(id) initWithBody:(NSData*) body main:(id)object Sel:(SEL) sel;

-(void) threadFunStart;

-(void) httpSubmit;


-(NSString*) getserverUrl;

@end
