//
//  ViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "myimgeview.h"
#import "GongSiViewController.h"
#import "CuXiaoViewController.h"
#import "DiaoChaViewController.h"
#import "XinChanPinViewController.h"
#import "ZhanWeiViewController.h"
#import "NewCuxiaoViewController.h"
#import "NewFairsViewController.h"

#import "GGlobal.h"

#import "CanZhanTableObj.h"
#import "CanZhanReleaseTableObj.h"
#import "ProTypeTableObj.h"
#import "DiaoChanDetailTableObj.h"
#import "DiaoChaTableObj.h"
#import "GongSiImageTableObj.h"
#import "ImageTableObj.h"
#import "ZhanWeiProTableObj.h"
#import "ZhanWeiInfoTableObj.h"
#import "GongSiImageTableObj.h"

#define RADIUS 100.0
#define PHOTONUM 5
#define PHOTOSTRING @"hallMenu_"
#define TAGSTART 1000
#define TIME 1.5
#define SCALENUMBER 1.25
int array [PHOTONUM][PHOTONUM] ={
	{0,1,2,3,4},
	{4,0,1,2,3},
	{3,4,0,1,2},
	{2,3,4,0,1},
	{1,2,3,4,0}
};
CATransform3D rotationTransform1[PHOTONUM];

@interface ViewController ()

@end

@implementation ViewController
@synthesize m_infoButton;
@synthesize m_tishiImageView;
@synthesize m_cuxiaoView,m_gongsiView,m_diaochaView,m_zhanweiView,m_xinchanpinView;
@synthesize m_newCuXiaoView,m_newFairsView;

//---
@synthesize m_downImageArr,m_downGongSiArr,m_downCanZhanArr,m_downDiaoChaArr,m_downProTypeArr,m_downVersionStr,m_shengjiAlertView,m_downZhanWeiProArr,m_downZhanWeiInfoArr,m_downDiaoChaDetailArr,m_downCanZhanReleaseArr,m_downChangJingInfoArr,m_downDiaoChaItemInfoArr;
@synthesize isShow;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setHidden:YES];
    
    //NSArray *textArray = [NSArray arrayWithObjects:@"新产品",@"促销",@"公司简介",@"调查管理",@"展位快讯",nil];
//    NSArray *textArray = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",nil];
//    
//	float centery = self.view.center.y-70;
//	float centerx = self.view.center.x+5;
//    
//	for (int i = 0;i<PHOTONUM;i++ ) 
//	{
//		float tmpy =  centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
//		float tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
//		myimgeview *addview1 =	[[myimgeview alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d",PHOTOSTRING,i+1]] text:[textArray objectAtIndex:i]];
//        addview1.frame = CGRectMake(0.0, 0.0,120,120);
//		[addview1 setdege:self];
//		addview1.tag = TAGSTART + i;
//		addview1.center = CGPointMake(tmpx,tmpy);
//		rotationTransform1[i] = CATransform3DIdentity;	
//		
//		//float Scalenumber =atan2f(sin(2.0*M_PI *i/PHOTONUM));
//		float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
//		if (Scalenumber<0.6) 
//		{
//			Scalenumber = 0.6;
//		}
//		CATransform3D rotationTransform = CATransform3DIdentity;
//		rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);		
//		addview1.layer.transform=rotationTransform;		
//		[self.view addSubview:addview1];
//		
//	}
//	currenttag = TAGSTART;
    
}

- (void)viewDidUnload
{
    [self setM_infoButton:nil];
    [self setM_tishiImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!m_shengjiAlertView) {
        m_shengjiAlertView = [[UIAlertView alloc] initWithTitle:@"Upgrade tips" message:@"Being updated product information, please do not exit the program.\r\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        UIActivityIndicatorView* actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        CGRect rect = [actView frame];
        rect.origin = CGPointMake(130, 108);
        actView.frame = rect;
        [m_shengjiAlertView addSubview:actView];
        
        [actView startAnimating];
        
        
        
        [actView release];
    }
    
    
    [self requestVersionTable];
    
    // [self performSelector:@selector(initGenieView) withObject:nil afterDelay:0.05];
}

- (BOOL)shouldAutorotate 
{
    return  NO;
}

- (NSUInteger)supportedInterfaceOrientations 
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)Clickup:(NSInteger)tag
{
    //  kIsAdShow;
	NSLog(@"点击TAG%d:",tag);
    //	int = currenttag - tag;
	if(currenttag == tag)
	{
        
        switch (currenttag-TAGSTART) {
            case 0:
            {
                [self gongsi:nil];
            }
                break;
            case 1:
                
            {
                [self cuxiao:nil];
            }
                
                break;
            case 2:
            {
                [self xinchanpin:nil];
                
            }
                
                break;
            case 3:
            {
                [self diaocha:nil];
            }
                
                break;
            case 4:
            {
                [self zhanwei:nil];
            }
                
                break;
                
            default:
                break;
        }
        return ;

	}
	int t = [self getblank:tag];
	//NSLog(@"%d",t);
	int i = 0;
	for (i = 0;i<PHOTONUM;i++ ) 
	{
		
		UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];
		[imgview.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
		[imgview.layer addAnimation:[self setscale:TAGSTART+i clicktag:tag] forKey:@"transform"];
		
		int j = array[tag - TAGSTART][i];
		float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.6) 
		{
			Scalenumber = 0.6;
		}
		CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
		//imgview.layer.transform=dtmp;
		
        //	imgview.layer.needsDisplayOnBoundsChange = YES;
	}
	currenttag = tag;
    //	[self performSelector:@selector(setcurrenttag) withObject:nil afterDelay:TIME];
}


-(void)setcurrenttag
{
	int i = 0;
	for (i = 0;i<PHOTONUM;i++ ) 
	{
		
		UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];		
		int j = array[currenttag - TAGSTART][i];
		float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.6) 
		{
			Scalenumber = 0.6;
		}
		CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
		imgview.layer.transform=dtmp;
		
		//	imgview.layer.needsDisplayOnBoundsChange = YES;
	}
}


-(CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag
{
	
	
	int i = array[clicktag - TAGSTART][tag - TAGSTART];
	int i1 = array[currenttag - TAGSTART][tag - TAGSTART];
	float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
	float Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
	if (Scalenumber<0.6) 
	{
		Scalenumber = 0.6;
	}
	CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.duration = TIME;
	animation.repeatCount =1;
	
	
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
	animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
	animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
	animation.autoreverses = NO;	
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	//imgview.layer.transform=dtmp;
	
	return animation;
}


-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num
{
	// CALayer
	UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];	
	CGMutablePathRef path = CGPathCreateMutable();
	NSLog(@"原点%f原点%f",imgview.layer.position.x,imgview.layer.position.y);
	CGPathMoveToPoint(path, NULL,imgview.layer.position.x,imgview.layer.position.y);
	
	int p =  [self getblank:tag];
	NSLog(@"旋转%d",p);
	float f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
	float h = f + 2.0*M_PI *num/PHOTONUM;
	float centery = self.view.center.y-70;
	float centerx = self.view.center.x+5;
	float tmpy =  centery + RADIUS*cos(h);
	float tmpx =	centerx - RADIUS*sin(h);
	imgview.center = CGPointMake(tmpx,tmpy);
	
	CGPathAddArc(path,nil,self.view.center.x+5, self.view.center.y-70,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);	
	animation.path = path;
	CGPathRelease(path);
	animation.duration = TIME;
	animation.repeatCount = 1;
 	animation.calculationMode = @"paced"; 	
	return animation;
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (m_shengjiAlertView == alertView) {
//        if (buttonIndex) {
//            
//            m_bCancleDown = true;
//            NSLog(@"cancle");
//        }
//    }else{
//        
//        
//    }
    
    
}


-(NSInteger)getblank:(NSInteger)tag
{
	if (currenttag>tag) 
	{
		return currenttag - tag;
	}
	else 
	{
		return PHOTONUM  - tag + currenttag;
	}
    
}

-(void)Scale
{
	[UIView beginAnimations:nil context:self];
	[UIView setAnimationRepeatCount:3];
    [UIView setAnimationDuration:1];	
	
	/*
	 + (void)setAnimationWillStartSelector:(SEL)selector;                // default = NULL. -animationWillStart:(NSString *)animationID context:(void *)context
	 + (void)setAnimationDidStopSelector:(SEL)selector;                  // default = NULL. -animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
	 + (void)setAnimationDuration:(NSTimeInterval)duration;              // default = 0.2
	 + (void)setAnimationDelay:(NSTimeInterval)delay;                    // default = 0.0
	 + (void)setAnimationStartDate:(NSDate *)startDate;                  // default = now ([NSDate date])
	 + (void)setAnimationCurve:(UIViewAnimationCurve)curve;              // default = UIViewAnimationCurveEaseInOut
	 + (void)setAnimationRepeatCount:(float)repeatCount;                 // default = 0.0.  May be fractional
	 + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;
	 */
	
	CATransform3D rotationTransform = CATransform3DIdentity;
    
    rotationTransform = CATransform3DRotate(rotationTransform,3.14, 1.0, 0.0, 0.0);	
	//rotationTransform = CATransform3DScale (rotationTransform, 0.1,0.1, 2);
    //self.view.transform=CGAffineTransformMakeScale(2,2);
	
	self.view.layer.transform=rotationTransform;
    [UIView setAnimationDelegate:self];	
    [UIView commitAnimations];
}


- (IBAction)gongsi:(id)sender {
    
    if (!m_gongsiView) {
        m_gongsiView = [[GongSiViewController alloc] init];
    }
    NSString* path = nil;
    @try {
//        GongSiImageTableObj* gongsiobj = [[DataBase getAllGongSiTableObj] objectAtIndex:0];
//        
//        ImageTableObj* imageobj = [DataBase getOneImageTableInfoImageid:gongsiobj.m_companyImageId];
//        
//        
//        path = [DataProcess getImageFilePathByUrl:imageobj.m_imageUrl];

    }
    @catch (NSException *exception) {

        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Warning message" message:@"The company did not find the information, please upgrade!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    m_gongsiView.m_path = path;
    
    [self.navigationController pushViewController:m_gongsiView animated:YES];
    
    
    
}

- (IBAction)zhanwei:(id)sender {
//    if (!self.m_zhanweiView) {
//        self.m_zhanweiView = [[ZhanWeiViewController alloc] init];
//    }
//    [GGlobal getGlobalInstance].m_zhanweiViewFresh = YES;
//    [self.navigationController pushViewController:self.m_zhanweiView animated:YES];
    
    if (m_newFairsView) {
        [m_newFairsView release];
        m_newFairsView = nil;
        
    }
    m_newFairsView = [[NewFairsViewController alloc] init];

    [self.navigationController pushViewController:m_newFairsView animated:YES];
    
}

- (IBAction)diaocha:(id)sender {
    if (!m_diaochaView) {
        m_diaochaView = [[DiaoChaViewController alloc] init];
    }
    [GGlobal getGlobalInstance].m_diaochanViewFresh = YES;
    [self.navigationController pushViewController:m_diaochaView animated:YES];
}

- (IBAction)cuxiao:(id)sender {
    
    if (m_newCuXiaoView) {
        [m_newCuXiaoView release];
        m_newCuXiaoView = nil;
        
    }
    m_newCuXiaoView = [[NewCuxiaoViewController alloc] init];
    m_newCuXiaoView.m_titleStr = @"Hot Product";
    m_newCuXiaoView.m_type = @"促销";
    [self.navigationController pushViewController:m_newCuXiaoView animated:YES];
    
//    if (!self.m_cuxiaoView) {
//        self.m_cuxiaoView = [[CuXiaoViewController alloc] init];
//    }
//    self.m_cuxiaoView.m_type = @"促销";
//    [self.navigationController pushViewController:self.m_cuxiaoView animated:YES];
}

- (IBAction)xinchanpin:(id)sender {
    
    if (m_newCuXiaoView) {
        [m_newCuXiaoView release];
        m_newCuXiaoView = nil;
        
    }
    m_newCuXiaoView = [[NewCuxiaoViewController alloc] init];
    m_newCuXiaoView.m_type = @"新品";
    m_newCuXiaoView.m_titleStr = @"New Product";
    [self.navigationController pushViewController:m_newCuXiaoView animated:YES];
    
//    if (!self.m_cuxiaoView) {
//        self.m_cuxiaoView = [[CuXiaoViewController alloc] init];
//    }
//    self.m_cuxiaoView.m_type = @"新品";
//    [self.navigationController pushViewController:self.m_cuxiaoView animated:YES];
}

- (IBAction)shengjiButton:(id)sender 
{
    bool haveNet = [DataProcess IsConnectedToNetwork];
    
    if (!haveNet) {
        NSLog(@"没有网络！！");
        [self performSelectorOnMainThread:@selector(callUpgradeNoNetOnMainThread) withObject:nil waitUntilDone:NO];
        return;
    }
    
    
    
    [self.m_shengjiAlertView show];
    m_bCancleDown = false;
    m_bHaveError = NO;
    
    [self requestCanZhanTable];
    [self requestCanZhanReleaseTable];
    [self requestProTypeTable];
    [self requestDiaoChaDetailTable];
    [self requestDiaoChaTable];
    [self requestGongSiTable];
    [self requestImageTable];
    [self requestZhanWeiProTable];
    [self requestZhanWeiInfoTable]; 
    [self requestChangJingInfoTable];
    [self requestDiaoChaItemInfoTable];
    
    [self startDownImageAndWriteToDatabase];
    
    
    //[self requestVersionTable];
    
    [self.m_tishiImageView setHidden:YES];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

-(void) dealloc
{
    [m_tishiImageView release];
    [m_infoButton release];
    [m_gongsiView release];
    [m_cuxiaoView release];
    [m_diaochaView release];
    [m_zhanweiView release];
    [m_xinchanpinView release];
    [m_newFairsView release];
    [m_downChangJingInfoArr release];
    
    [super dealloc];
}

//显示还是 隐藏提示View
-(void) hideOrShowTishiImageView:(NSString*) str
{
    if (0 == [str compare:[DataBase getAllVersionTableObj]]) {
        [self.m_tishiImageView setHidden:YES];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }else {
        [self.m_tishiImageView setHidden:NO];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    }
}



#pragma mark -请求数据
//升级请求
-(void) requestCanZhanTable
{
    m_bCanZhanDownFlag = NO;
    NSArray* temArr = [DataBase getAllCanZhanTableObj];
     NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"ihshow"];
    
    NSLog(@"requestCanZhanTable str = %@",str);
    
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByCanZhanTable:)];
    [http threadFunStart];
    
    [http release];
    
}
-(void) receiveDataByCanZhanTable:(NSData*) data
{
    if (m_downCanZhanArr) {
        [m_downCanZhanArr release];
        m_downCanZhanArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downCanZhanArr := %@",str);
        m_downCanZhanArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downCanZhanArr) {
            NSLog(@"接收到 数据：m_downCanZhanArr 解析 成功"); 
            
        }else{
            NSLog(@"接收到 数据：m_downCanZhanArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByCanZhanTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bCanZhanDownFlag = YES;

}

//升级请求
-(void) requestCanZhanReleaseTable
{
    m_bCanZhanReleaseDownFlag = NO;
    NSArray* temArr = [DataBase getAllCanZhanReleaseTableObj];
    NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"ihproduct"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByCanZhanReleaseTable:)];
    [http threadFunStart];
    
    [http release];
}
-(void) receiveDataByCanZhanReleaseTable:(NSData*) data
{
    if (m_downCanZhanReleaseArr) {
        [m_downCanZhanReleaseArr release];
        m_downCanZhanReleaseArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downCanZhanReleaseArr := %@",str);
        m_downCanZhanReleaseArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downCanZhanReleaseArr) {
            NSLog(@"接收到 数据：m_downCanZhanReleaseArr 解析 成功"); 
            
        }else{
            NSLog(@"接收到 数据：m_downCanZhanReleaseArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByCanZhanReleaseTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bCanZhanReleaseDownFlag = YES;
}

//升级请求
-(void) requestProTypeTable
{
    m_bProTypeDownFlag = NO;
    NSArray* temArr = [DataBase getAllProTypeTableObj];
    NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"ihprotype"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByProTypeTable:)];
    [http threadFunStart];
    
    [http release];
}
-(void) receiveDataByProTypeTable:(NSData*) data
{
    if (m_downProTypeArr) {
        [m_downProTypeArr release];
        m_downProTypeArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downProTypeArr := %@",str);
        m_downProTypeArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downProTypeArr) {
            NSLog(@"接收到 数据：m_downProTypeArr 解析 成功"); 
            
        }else{
            NSLog(@"接收到 数据：m_downProTypeArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByProTypeTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bProTypeDownFlag = YES;
}

//升级请求
-(void) requestDiaoChaDetailTable
{
    m_bDiaoChaDetailDownFlag = NO;
    NSArray* temArr = [DataBase getAllDiaoChaDetailTableObj];
    NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"ihlookitem"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByDiaoChaDetailTable:)];
    [http threadFunStart];
    
    [http release];
}
-(void) receiveDataByDiaoChaDetailTable:(NSData*) data
{
    if (m_downDiaoChaDetailArr) {
        [m_downDiaoChaDetailArr release];
        m_downDiaoChaDetailArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downDiaoChaDetailArr := %@",str);
        m_downDiaoChaDetailArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downDiaoChaDetailArr) {
            NSLog(@"接收到 数据：m_downDiaoChaDetailArr 解析 成功"); 
            
        }else{
            NSLog(@"接收到 数据：m_downDiaoChaDetailArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByDiaoChaDetailTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bDiaoChaDetailDownFlag = YES;
}

//升级请求
-(void) requestDiaoChaTable
{
    m_bDiaoChaDownFlag = NO;
    NSArray* temArr = [DataBase getAllDiaoChaTableObj];
    NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"ihlook"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByDiaoChaTable:)];
    [http threadFunStart];
    
    [http release];
}
-(void) receiveDataByDiaoChaTable:(NSData*) data
{
    if (m_downDiaoChaArr) {
        [m_downDiaoChaArr release];
        m_downDiaoChaArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downDiaoChaArr := %@",str);
        m_downDiaoChaArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downDiaoChaArr) {
            NSLog(@"接收到 数据：m_downDiaoChaArr 解析 成功"); 
            
        }else{
            NSLog(@"接收到 数据：m_downDiaoChaArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByDiaoChaTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bDiaoChaDownFlag = YES;
}

//升级请求
-(void) requestGongSiTable
{
    m_bGongSiDownFlag = NO;
    NSArray* temArr = [DataBase getAllGongSiTableObj];
    NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"ihcompany"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByGongSiTable:)];
    [http threadFunStart];
    
    [http release];
}
-(void) receiveDataByGongSiTable:(NSData*) data
{
    if (m_downGongSiArr) {
        [m_downGongSiArr release];
        m_downGongSiArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downGongSiArr := %@",str);
        m_downGongSiArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downGongSiArr) {
            NSLog(@"接收到 数据：m_downGongSiArr 解析 成功"); 
            
        }else{
            NSLog(@"接收到 数据：m_downGongSiArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByGongSiTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bGongSiDownFlag = YES;
}

//升级请求
-(void) requestImageTable
{
    m_bImageDownFlag = NO;
    NSArray* temArr = [DataBase getAllImageTableObj];
    NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"ihimage"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByImageTable:)];
    [http threadFunStart];
    
    [http release];
}
-(void) receiveDataByImageTable:(NSData*) data
{
    if (m_downImageArr) {
        [m_downImageArr release];
        m_downImageArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downImageArr := %@",str);
        m_downImageArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downGongSiArr) {
            NSLog(@"接收到 数据：m_downImageArr 解析 成功"); 
            
        }else{
            NSLog(@"接收到 数据：m_downImageArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByImageTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bImageDownFlag = YES;
}

//升级请求
-(void) requestZhanWeiProTable
{
    m_bZhanWeiProDownFlag = NO;
    NSArray* temArr = [DataBase getAllZhanWeiProTableObj];
    NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"isshowproduct"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByZhanWeiProTable:)];
    [http threadFunStart];
    
    [http release];
}
-(void) receiveDataByZhanWeiProTable:(NSData*) data
{
    if (m_downZhanWeiProArr) {
        [m_downZhanWeiProArr release];
        m_downZhanWeiProArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downZhanWeiProArr := %@",str);
        m_downZhanWeiProArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downZhanWeiProArr) {
            NSLog(@"接收到 数据：m_downZhanWeiProArr 解析 成功"); 
            
        }else{
            NSLog(@"接收到 数据：m_downZhanWeiProArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByZhanWeiProTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bZhanWeiProDownFlag = YES;
}

//升级请求
-(void) requestDiaoChaItemInfoTable
{
    m_bDiaoChaItemInfoDownFlag = NO;
    NSArray* temArr = [DataBase getAllDiaochaItemInfoTableObj];
    NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"ihlookcaption"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByDiaoChaItemInfoTable:)];
    [http threadFunStart];
    
    [http release];

}
-(void) receiveDataByDiaoChaItemInfoTable:(NSData*) data
{
    if (m_downDiaoChaItemInfoArr) {
        [m_downDiaoChaItemInfoArr release];
        m_downDiaoChaItemInfoArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downDiaoChaItemInfoArr := %@",str);
        m_downDiaoChaItemInfoArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downDiaoChaItemInfoArr) {
            NSLog(@"接收到 数据：m_downDiaoChaItemInfoArr 解析 成功");
            
        }else{
            NSLog(@"接收到 数据：m_downDiaoChaItemInfoArr 解析 失败！！");
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByDiaoChaItemInfoTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bDiaoChaItemInfoDownFlag = YES;
}

//升级请求
-(void) requestChangJingInfoTable
{
    m_bChangJingInfoDownFlag = NO;
    NSArray* temArr = [DataBase getAllChangJingInfoTableObj];
    NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"ihcjlist"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByChangJingInfoTable:)];
    [http threadFunStart];
    
    [http release];
}

-(void) receiveDataByChangJingInfoTable:(NSData*) data
{
    if (m_downChangJingInfoArr) {
        [m_downChangJingInfoArr release];
        m_downChangJingInfoArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downChangJingInfoArr := %@",str);
        m_downChangJingInfoArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downChangJingInfoArr) {
            NSLog(@"接收到 数据：m_downChangJingInfoArr 解析 成功"); 
            
        }else{
            NSLog(@"接收到 数据：m_downChangJingInfoArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByZhanWeiInfoTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bChangJingInfoDownFlag = YES;
}


//升级请求
-(void) requestZhanWeiInfoTable
{
    m_bZhanWeiInfoDownFlag = NO;
    NSArray* temArr = [DataBase getAllZhanWeiInfoTableObj];
    NSString* str = [MyXMLParser EncodeToStr:temArr Type:@"ihshowitem"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByZhanWeiInfoTable:)];
    [http threadFunStart];
    
    [http release];
}


-(void) receiveDataByZhanWeiInfoTable:(NSData*) data
{
    if (m_downZhanWeiInfoArr) {
        [m_downZhanWeiInfoArr release];
        m_downZhanWeiInfoArr = nil;
    }
    
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"m_downZhanWeiInfoArr := %@",str);
        m_downZhanWeiInfoArr = [[NSMutableArray alloc] initWithArray:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downZhanWeiInfoArr) {
            NSLog(@"接收到 数据：m_downZhanWeiInfoArr 解析 成功"); 
            
        }else{
            NSLog(@"接收到 数据：m_downZhanWeiInfoArr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByZhanWeiInfoTable 接收到 数据 异常");
        m_bHaveError = YES;
        
    }
    m_bZhanWeiInfoDownFlag = YES;
}

//升级请求
-(void) requestVersionTable
{
    m_bVersionDownFlag = NO;
    NSString* str = nil;
    
    NSString* temArr = [DataBase getAllVersionTableObj];
    str = [MyXMLParser EncodeToStr:temArr Type:@"version3"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSRange range = [str rangeOfString:@"null"];
    
    if (range.length > 0) {
        str = @"<?xml version='1.0' encoding='utf-8' ?>\
        <command>\
        <commandid>version3</commandid>\
        <requestver>\
        <version>0</version>\
        </requestver>\
        </command>";
    }
    
    NSLog(@"version3 = %@",str);
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataByVersionTable:)];
    [http threadFunStart];
    
    [http release];

}
-(void) receiveDataByVersionTable:(NSData*) data
{
    if (m_downVersionStr) {
        [m_downVersionStr release];
        m_downVersionStr = nil;
    }
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        m_downVersionStr = [[NSString alloc] initWithString:[MyXMLParser DecodeToObj:str]];
        [str release];
        if (m_downVersionStr) {
            
            NSLog(@"接收到 数据：m_downVersionStr 解析 成功"); 
            NSLog(@"version str = %@",m_downVersionStr);
        }else{
            NSLog(@"接收到 数据：m_downVersionStr 解析 失败！！"); 
            m_bHaveError = YES;
        }
        
    }else{
        NSLog(@"receiveDataByVersionTable 接收到 数据 异常");
        m_bHaveError = YES;
    }
    m_bVersionDownFlag = YES;
    
    [self performSelectorOnMainThread:@selector(hideOrShowTishiImageView:) withObject:m_downVersionStr waitUntilDone:NO];

}


//开启一个 单独线程 下载图片和 写数据库
-(void) startDownImageAndWriteToDatabase
{
    if (!m_bCancleDown) {
        //初始化 写数据库 都未 no
        m_bVersionWriteDataBaseFlag = NO;
        m_bCanZhanWriteDataBaseFlag = NO;
        m_bCanZhanReleaseWriteDataBaseFlag = NO;
        m_bProTypeWriteDataBaseFlag = NO;
        m_bDiaoChaDetailWriteDataBaseFlag = NO;
        m_bDiaoChaWriteDataBaseFlag = NO;
        m_bGongSiWriteDataBaseFlag = NO;
        m_bImageWriteDataBaseFlag = NO;
        m_bZhanWeiProWriteDataBaseFlag = NO;
        m_bZhanWeiInfoWriteDataBaseFlag = NO;
        m_bChangJingInfoWriteDataBaseFlag = NO;
        m_bDiaoChaItemInfoWriteDataBaseFlag = NO;
        
        [NSThread detachNewThreadSelector:@selector(threadDownWriteFun) toTarget:self withObject:nil];
    }

}
-(void) threadDownWriteFun
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    bool haveNet = YES;
    while (!m_bCancleDown) {
        
        haveNet = [DataProcess IsConnectedToNetwork];
        if (!haveNet) {
            m_bHaveError = true;
            break;
        }
        if (m_bCanZhanDownFlag) {
            [self doCanZhanData];
        }else if(m_bCanZhanReleaseDownFlag) {
            [self doCanZhanReleaseData];
            
        }else if(m_bProTypeDownFlag) {
            [self doProTypeData];
        }else if(m_bDiaoChaDetailDownFlag) {
            [self doDiaoChaDetailData];
            
        }else if(m_bDiaoChaDownFlag) {
            [self doDiaoChaData];

        }else if(m_bGongSiDownFlag) {
            [self doGongSiData];
            
        }else if(m_bImageDownFlag) {
            [self doImageData];
            
        }else if(m_bZhanWeiProDownFlag) {
            [self doZhanWeiProData];
            
        }else if(m_bZhanWeiInfoDownFlag) {
            
            [self doZhanWeiInfoData];
        }else if(m_bChangJingInfoDownFlag) {
            
            [self doChangJingInfoData];
        }else if(m_bDiaoChaItemInfoDownFlag) {
            
            [self doDiaoChaItemInfoData];
        }
        
        
        if (m_bCanZhanWriteDataBaseFlag && m_bCanZhanReleaseWriteDataBaseFlag && m_bProTypeWriteDataBaseFlag && m_bDiaoChaDetailWriteDataBaseFlag && m_bDiaoChaWriteDataBaseFlag && m_bGongSiWriteDataBaseFlag && m_bImageWriteDataBaseFlag && m_bZhanWeiProWriteDataBaseFlag && m_bZhanWeiInfoWriteDataBaseFlag && m_bChangJingInfoWriteDataBaseFlag && m_bDiaoChaItemInfoWriteDataBaseFlag) {
            
            if (m_bHaveError) {
                NSLog(@"写入数据库 或 下载 图片 文件，出现异常。版本升级未成功！！");
            }else{
                
                NSLog(@"down version str = %@",m_downVersionStr);
                bool suc = [DataBase addVersionTableObj:m_downVersionStr];
                if (suc) {
                    m_bHaveError = NO;
                    NSLog(@"写入数据库 或 下载 图片 文件  版本升级成功！！");
                }else{
                    m_bHaveError = YES;
                    NSLog(@"写bool suc = [DataBase addVersionTableObj:m_downVersionStr]; 未成功！！");
                }
            }
            
            if(!m_bHaveError)
                [self performSelectorOnMainThread:@selector(callUpgradeSuccOnMainThread) withObject:nil waitUntilDone:NO];
            else
                [self performSelectorOnMainThread:@selector(callUpgradeFailureOnMainThread) withObject:nil waitUntilDone:NO];
            break;
            
        }
        
    }
    
    if (!haveNet) {
        
        [self performSelectorOnMainThread:@selector(callUpgradeNoNetOnMainThread) withObject:nil waitUntilDone:NO];
    }
    
    
    [pool release];
}

-(void) doCanZhanData
{
    if ( m_downCanZhanArr && m_downCanZhanArr.count>0) {
        
        for (int i=0; i<m_downCanZhanArr.count && !m_bCancleDown; i++) {
            
            CanZhanTableObj* posobj = [m_downCanZhanArr objectAtIndex:i];
            switch (posobj.m_flag) {
                case 1:
                {
                    
                    bool suc = [DataBase addCanZhanTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase addCanZhanTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    
                    continue;
                }
                    break;
                case 0:
                {
                    bool suc = [DataBase alterCanZhanTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase alterCanZhanTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;                        
                }
                    
                    break;
                case -1:
                {
                    BOOL suc = [DataBase deleteCanZhanTableObj: posobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = [DataBase deleteCanZhanTableObj:posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bCanZhanDownFlag = NO;
    m_bCanZhanWriteDataBaseFlag = YES; 
}
-(void) doCanZhanReleaseData
{
    if ( m_downCanZhanReleaseArr && m_downCanZhanReleaseArr.count>0) {
        
        for (int i=0; i<m_downCanZhanReleaseArr.count && !m_bCancleDown; i++) {
            
            CanZhanReleaseTableObj* posobj = [m_downCanZhanReleaseArr objectAtIndex:i];
            switch (posobj.m_flag) {
                case 1:
                {
                    
                    bool suc = [DataBase addCanZhanReleaseTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase addCanZhanReleaseTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    
                    continue;
                }
                    break;
                case 0:
                {
                    bool suc = [DataBase alterCanZhanReleaseTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase alterCanZhanReleaseTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;                        
                }
                    
                    break;
                case -1:
                {
                    BOOL suc = [DataBase deleteCanZhanReleaseTableObj: posobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = [DataBase deleteCanZhanReleaseTableObj:posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bCanZhanReleaseDownFlag = NO;
    m_bCanZhanReleaseWriteDataBaseFlag = YES; 
}
-(void) doProTypeData
{
    if ( m_downProTypeArr && m_downProTypeArr.count>0) {
        
        for (int i=0; i<m_downProTypeArr.count && !m_bCancleDown; i++) {
            
            ProTypeTableObj* posobj = [m_downProTypeArr objectAtIndex:i];
            switch (posobj.m_flag) {
                case 1:
                {
                    
                    bool suc = [DataBase addProTypeTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase addProTypeTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    
                    continue;
                }
                    break;
                case 0:
                {
                    bool suc = [DataBase alterProTypeTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase alterProTypeTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;                        
                }
                    
                    break;
                case -1:
                {
                    BOOL suc = [DataBase deleteProTypeTableObj: posobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = [DataBase deleteProTypeTableObj:posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bProTypeDownFlag = NO;
    m_bProTypeWriteDataBaseFlag = YES; 
}
-(void) doDiaoChaDetailData
{
    if ( m_downDiaoChaDetailArr && m_downDiaoChaDetailArr.count>0) {
        
        for (int i=0; i<m_downDiaoChaDetailArr.count && !m_bCancleDown; i++) {
            
            DiaoChanDetailTableObj* posobj = [m_downDiaoChaDetailArr objectAtIndex:i];
            switch (posobj.m_flag) {
                case 1:
                {
                    
                    bool suc = [DataBase addDiaoChaDetailTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase addDiaoChaDetailTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    
                    continue;
                }
                    break;
                case 0:
                {
                    bool suc = [DataBase alterDiaoChaDetailTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase alterDiaoChaDetailTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;                        
                }
                    
                    break;
                case -1:
                {
                    BOOL suc = [DataBase deleteDiaoChaDetailTableObj: posobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = [DataBase deleteDiaoChaDetailTableObj:posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bDiaoChaDetailDownFlag = NO;
    m_bDiaoChaDetailWriteDataBaseFlag = YES; 
}
-(void) doDiaoChaData
{
    if ( m_downDiaoChaArr && m_downDiaoChaArr.count>0) {
        
        for (int i=0; i<m_downDiaoChaArr.count && !m_bCancleDown; i++) {
            
            DiaoChaTableObj* posobj = [m_downDiaoChaArr objectAtIndex:i];
            switch (posobj.m_flag) {
                case 1:
                {
                    
                    bool suc = [DataBase addDiaoChaTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase addDiaoChaTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    
                    continue;
                }
                    break;
                case 0:
                {
                    bool suc = [DataBase alterDiaoChaTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase alterDiaoChaTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;                        
                }
                    
                    break;
                case -1:
                {
                    BOOL suc = [DataBase deleteDiaoChaTableObj: posobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = [DataBase deleteDiaoChaTableObj:posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bDiaoChaDownFlag = NO;
    m_bDiaoChaWriteDataBaseFlag = YES; 
}
-(void) doGongSiData
{
    if ( m_downGongSiArr && m_downGongSiArr.count>0) {
        
        for (int i=0; i<m_downGongSiArr.count && !m_bCancleDown; i++) {
            
            GongSiImageTableObj* posobj = [m_downGongSiArr objectAtIndex:i];
            switch (posobj.m_flag) {
                case 1:
                {
                    
                    bool suc = [DataBase addGongSiTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase addGongSiTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    
                    continue;
                }
                    break;
                case 0:
                {
                    bool suc = [DataBase alterGongSiTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase alterGongSiTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;                        
                }
                    
                    break;
                case -1:
                {
                    BOOL suc = [DataBase deleteGongSiTableObj: posobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = [DataBase deleteGongSiTableObj:posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bGongSiDownFlag = NO;
    m_bGongSiWriteDataBaseFlag = YES; 
}
-(void) doImageData
{
    
    if ( m_downImageArr && m_downImageArr.count>0) {
        
        for (int i=0; i<m_downImageArr.count && !m_bCancleDown; i++) {
            
            ImageTableObj* imageobj = [m_downImageArr objectAtIndex:i];
            switch (imageobj.m_flag) {
                case 1:
                {
                    BOOL suc = [DataProcess downAndWriteImgeforUrl:imageobj.m_imageUrl];
                    if (suc) {
                        suc = [DataBase addImageTableObj:imageobj];
                        if (!suc) {
                            NSLog(@"suc = [DataBase addImageTableObj:imageobj]; 失败!!");
                            m_bHaveError = true;
                        }
                        
                    }else{
                        NSLog(@"suc = [DataProcess downAndWriteImgeforUrl:imageobj.m_imageUrl]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    break;
                case 0:
                {
                    BOOL suc = [DataProcess downAndWriteImgeforUrl:imageobj.m_imageUrl];
                    if (suc) {
                        suc = [DataBase alterImageTableObj: imageobj];
                        if (!suc) {
                            NSLog(@"suc = case 0:alterImageTableObj: imageobj; 失败!!");
                            m_bHaveError = true;
                        }
                        
                    }else{
                        NSLog(@"suc = case 0:[DataProcess downAndWriteImgeforUrl:imageobj.m_imageUrl]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                case -1:
                {
                    ImageTableObj* temImageObj = [DataBase getOneImageTableInfoImageid:imageobj.m_imageId];
                    NSString* filename = [DataProcess getImageFileNameByUrl:temImageObj.m_imageUrl];
                    BOOL suc = [DataProcess removeFileByName:filename];
                    suc = [DataBase deleteImageTableObj:imageobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = aProcess removeFileByName:f [DataBase deleteImageTableObj:imageobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bImageDownFlag = NO;
    m_bImageWriteDataBaseFlag = YES; 
}
-(void) doZhanWeiProData
{
    if ( m_downZhanWeiProArr && m_downZhanWeiProArr.count>0) {
        
        for (int i=0; i<m_downZhanWeiProArr.count && !m_bCancleDown; i++) {
            
            ZhanWeiProTableObj* posobj = [m_downZhanWeiProArr objectAtIndex:i];
            switch (posobj.m_flag) {
                case 1:
                {
                    
                    bool suc = [DataBase addZhanWeiProTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase addZhanWeiProTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    
                    continue;
                }
                    break;
                case 0:
                {
                    bool suc = [DataBase alterZhanWeiProTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase alterZhanWeiProTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;                        
                }
                    
                    break;
                case -1:
                {
                    BOOL suc = [DataBase deleteZhanWeiProTableObj: posobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = [DataBase deleteZhanWeiProTableObj:posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bZhanWeiProDownFlag = NO;
    m_bZhanWeiProWriteDataBaseFlag = YES; 
}
-(void) doZhanWeiInfoData
{
    if ( m_downZhanWeiInfoArr && m_downZhanWeiInfoArr.count>0) {
        
        for (int i=0; i<m_downZhanWeiInfoArr.count && !m_bCancleDown; i++) {
            
            ZhanWeiInfoTableObj* posobj = [m_downZhanWeiInfoArr objectAtIndex:i];
            switch (posobj.m_flag) {
                case 1:
                {
                    
                    bool suc = [DataBase addZhanWeiInfoTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase addZhanWeiInfoTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    
                    continue;
                }
                    break;
                case 0:
                {
                    bool suc = [DataBase alterZhanWeiInfoTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase alterZhanWeiInfoTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;                        
                }
                    
                    break;
                case -1:
                {
                    BOOL suc = [DataBase deleteZhanWeiInfoTableObj: posobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = [DataBase deleteZhanWeiInfoTableObj:posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bZhanWeiInfoDownFlag = NO;
    m_bZhanWeiInfoWriteDataBaseFlag = YES; 
}

-(void) doDiaoChaItemInfoData
{
    if ( m_downDiaoChaItemInfoArr && m_downDiaoChaItemInfoArr.count>0) {
        
        for (int i=0; i<m_downDiaoChaItemInfoArr.count && !m_bCancleDown; i++) {
            
            DiaoChaItemTableObj* posobj = [m_downDiaoChaItemInfoArr objectAtIndex:i];
            switch (posobj.m_flag) {
                case 1:
                {
                    
                    bool suc = [DataBase addDiaochaItemInfoTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = DataBase addDiaochaItemInfoTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    
                    continue;
                }
                    break;
                case 0:
                {
                    bool suc = [DataBase alterDiaochaItemInfoTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase alterDiaochaItemInfoTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                case -1:
                {
                    BOOL suc = [DataBase deleteDiaochaItemInfoTableObj: posobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = [DataBase deleteDiaochaItemInfoTableObj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bDiaoChaItemInfoDownFlag = NO;
    m_bDiaoChaItemInfoWriteDataBaseFlag = YES;
}

-(void) doChangJingInfoData
{
    if ( m_downChangJingInfoArr && m_downChangJingInfoArr.count>0) {
        
        for (int i=0; i<m_downChangJingInfoArr.count && !m_bCancleDown; i++) {
            
            ChangJinTableObj* posobj = [m_downChangJingInfoArr objectAtIndex:i];
            switch (posobj.m_flag) {
                case 1:
                {
                    
                    bool suc = [DataBase addChangJingInfoTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = DataBase addChangJingInfoTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    
                    continue;
                }
                    break;
                case 0:
                {
                    bool suc = [DataBase alterChangJingInfoTableObj: posobj];
                    if (!suc) {
                        NSLog(@"bool suc = [DataBase alterChangJingInfoTableObj: posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;                        
                }
                    
                    break;
                case -1:
                {
                    BOOL suc = [DataBase deleteChangJingInfoTableObj: posobj];
                    if (!suc) {
                        NSLog(@"BOOL suc = [DataBase deleteChangJingInfoTableObj:posobj]; 失败!!");
                        m_bHaveError = true;
                    }
                    continue;
                }
                    
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    
    m_bChangJingInfoDownFlag = NO;
    m_bChangJingInfoWriteDataBaseFlag = YES; 
}


-(void) doVersionData
{
    
}

-(void) callUpgradeSuccOnMainThread
{
    [m_shengjiAlertView dismissWithClickedButtonIndex:2 animated:YES];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade tips" message:@"Upgrade the product information successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
    //    [DataProcess copyDatabaseSqliteFileToDownImage];
}
-(void) callUpgradeFailureOnMainThread
{
    [m_shengjiAlertView dismissWithClickedButtonIndex:2 animated:YES];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade tips" message:@"Upgrade fails, try the upgrade again to ensure that the latest product information." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}
-(void) callUpgradeNoNetOnMainThread
{
    [m_shengjiAlertView dismissWithClickedButtonIndex:2 animated:YES];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade tips" message:@"Network connection fails, make sure the network is functioning properly." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

@end
