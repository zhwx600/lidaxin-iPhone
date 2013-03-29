//
//  IDispatcher.h
//  http
//
//  Created by zheng wanxiang on 11-6-22.
//  Copyright 2011 mjxy. All rights reserved.
//


@protocol IDispatcher
	
-(void) dispatchData:(NSData*)data;

-(void) exception;

@end
