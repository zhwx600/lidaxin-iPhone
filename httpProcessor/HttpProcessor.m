//
//  HttpProcessor.m
//  http
//
//  Created by zheng wanxiang on 11-6-20.
//  Copyright 2011 mjxy. All rights reserved.
//

#import "HttpProcessor.h"
#import "DataProcess.h"	

@implementation HttpProcessor

@synthesize m_body,m_mainObject,m_reData,m_mainSel,m_recResult;

-(id) initWithBody:(NSData*) body main:(id)object Sel:(SEL) sel
{
	if (self = [super init]) {
		m_body = [[NSData alloc] initWithData:body];
		m_mainObject = object;
        self.m_mainSel = sel;
		if (nil == cookie) {
			cookie = [[NSMutableString alloc] initWithString:@""];
		}
        
        self.m_recResult = YES;
		
	}
	return self;
}

-(void)httpSubmit
{
	NSAutoreleasePool *tempool = [[NSAutoreleasePool alloc] init];
	
	
	//[NSThread sleepForTimeInterval:3];//睡眠
	@try {
		//初始化http请求数据
		NSURL *url = [NSURL URLWithString:[self getserverUrl]];

		//请求
		NSMutableURLRequest *request = [NSMutableURLRequest	requestWithURL:url 
															   cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData 
														   timeoutInterval:60.0];

		[request setHTTPMethod:@"POST"];
		[request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
		if (0 != [cookie length]) {
			[request addValue:cookie forHTTPHeaderField:@"cookie"];		
		}	
        
		//[request addValue:@"22-Jun-2001/11:30:00-CST" forHTTPHeaderField:@"version"];
		[request setHTTPBody:m_body];
		
		//请求返回
		NSHTTPURLResponse *response;
		
		NSData*responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];

		if (200 == [response statusCode]) 
		{
			//设置cookie
			NSDictionary* dic = [response allHeaderFields];
			NSString* tempCookie = (NSString*)[dic objectForKey:@"Set-Cookie"];
			if (![tempCookie isEqual:cookie]) {
				if (0 < [tempCookie length]) {
					[cookie setString:tempCookie];
				}
			}
            
            if(self.m_recResult){
            
                if (0 < [responseData length]) {
                    
                    if (self.m_reData) {
                        [self.m_reData release];
                    }
                    self.m_reData = [[NSData alloc] initWithData:responseData ]; 
                    
                }
                else {
                    NSLog(@"http请求返回异常！");
                    NSException* e = [NSException exceptionWithName:@"NSException" 
                                                             reason:@"http请求返回异常！" userInfo:nil];
                    @throw e;
                }
            }else{
                if (self.m_reData) {
                    [self.m_reData release];
                }
                self.m_reData = [[NSData alloc] initWithData:[@"OK" dataUsingEncoding:NSUTF8StringEncoding]];
            }
		
		}
		else {
            
            NSLog(@"error = %@",[[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease]);
            
            NSString* errorStr = [NSString stringWithFormat:@"http返回失败，状态吗：%d! 失败",[response statusCode]];
			NSLog(@"http返回失败，状态吗：%d!",[response statusCode]);
			NSException* e = [NSException exceptionWithName:@"NSException" 
													 reason:errorStr userInfo:nil];
			@throw e;
		}

	}
	@catch (NSException * e) {
		self.m_reData = nil;	
	}
	@finally {
		
        [self.m_mainObject performSelectorOnMainThread:self.m_mainSel withObject:self.m_reData waitUntilDone:NO];				
	}

	[tempool release];
	
}

-(void)threadFunStart
{
//	m_timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timeOutFun) userInfo:nil repeats:NO];
	[NSThread detachNewThreadSelector:@selector(httpSubmit) toTarget:self withObject:nil];
	//if (nil != m_thread) {
//		[m_thread release];
//		m_thread = nil;
//	}
//	
//	m_thread = [[NSThread alloc] initWithTarget:self selector:@selector(httpSubmit) object:nil];
//	[m_thread start];
}

-(void) setM_body:(NSData *)data
{
    if (m_body) {
        [m_body release];
        m_body = [[NSData alloc] initWithData:data];
    }
}

-(NSString*) getserverUrl
{
	return serverUrl;
}

-(void) dealloc
{
    [m_reData release];
	[m_body release];
	[super dealloc];
}


@end
