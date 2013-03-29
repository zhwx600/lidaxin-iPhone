//
//  ViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import "AZGenieView.h"
#import "DataBase.h"
#import "IDispatcher.h"
#import "HttpProcessor.h"
#import "xmlparser.h"



@class GongSiViewController;
@class CuXiaoViewController;
@class DiaoChaViewController;
@class XinChanPinViewController;
@class ZhanWeiViewController;
@class NewCuxiaoViewController;
@class NewFairsViewController;

@interface ViewController : UIViewController<AZGenieAnimationDelegate,UIAlertViewDelegate>
{
    int  currenttag;
    
    bool m_bVersionDownFlag,m_bCanZhanDownFlag,m_bCanZhanReleaseDownFlag,m_bProTypeDownFlag,m_bDiaoChaDetailDownFlag,m_bDiaoChaDownFlag,m_bGongSiDownFlag,m_bImageDownFlag,m_bZhanWeiProDownFlag,m_bZhanWeiInfoDownFlag,m_bChangJingInfoDownFlag,m_bDiaoChaItemInfoDownFlag;//是否 解析完 xml数据
    
    bool m_bVersionWriteDataBaseFlag,m_bCanZhanWriteDataBaseFlag,m_bCanZhanReleaseWriteDataBaseFlag,m_bProTypeWriteDataBaseFlag,m_bDiaoChaDetailWriteDataBaseFlag,m_bDiaoChaWriteDataBaseFlag,m_bGongSiWriteDataBaseFlag,m_bImageWriteDataBaseFlag,m_bZhanWeiProWriteDataBaseFlag,m_bZhanWeiInfoWriteDataBaseFlag,m_bChangJingInfoWriteDataBaseFlag,m_bDiaoChaItemInfoWriteDataBaseFlag;
    
    bool m_bCancleDown;//取消下载按钮
    
    bool m_bHaveError;//整个升级过成功中 是否 有 异常 错误。
    
}

@property (retain, nonatomic) IBOutlet UIButton *m_infoButton;
@property (retain, nonatomic) IBOutlet UIImageView *m_tishiImageView;

@property (nonatomic,retain) GongSiViewController* m_gongsiView;
@property (nonatomic,retain) CuXiaoViewController* m_cuxiaoView;
@property (nonatomic,retain) DiaoChaViewController* m_diaochaView;
@property (nonatomic,retain) XinChanPinViewController* m_xinchanpinView;
@property (nonatomic,retain) ZhanWeiViewController* m_zhanweiView;

@property (nonatomic,retain) NewCuxiaoViewController* m_newCuXiaoView;
@property (nonatomic,retain) NewFairsViewController* m_newFairsView;

@property (assign, nonatomic) bool isShow;
@property (nonatomic,retain) UIAlertView* m_shengjiAlertView;
//数据库 表 升级 相关变量

@property (retain)NSString* m_downVersionStr;
@property (retain)NSMutableArray* m_downCanZhanArr;
@property (retain)NSMutableArray* m_downCanZhanReleaseArr;
@property (retain)NSMutableArray* m_downProTypeArr;
@property (retain)NSMutableArray* m_downDiaoChaDetailArr;
@property (retain)NSMutableArray* m_downDiaoChaArr;
@property (retain)NSMutableArray* m_downGongSiArr;
@property (retain)NSMutableArray* m_downImageArr;
@property (retain)NSMutableArray* m_downZhanWeiProArr;
@property (retain)NSMutableArray* m_downZhanWeiInfoArr;
@property (retain)NSMutableArray* m_downChangJingInfoArr;
@property (retain)NSMutableArray* m_downDiaoChaItemInfoArr;

- (IBAction)gongsi:(id)sender;
- (IBAction)zhanwei:(id)sender;
- (IBAction)diaocha:(id)sender;
- (IBAction)cuxiao:(id)sender;
- (IBAction)xinchanpin:(id)sender;
- (IBAction)shengjiButton:(id)sender;

//显示还是 隐藏提示View
-(void) hideOrShowTishiImageView:(NSString*) str;

//--------------------
-(void)Clickup:(NSInteger)tag;
-(NSInteger)getblank:(NSInteger)tag;
-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num;
-(void) initGenieView;
- (UIImage *)screenshotForViewController;
-(CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag;

//---请求数据
//升级请求
-(void) requestCanZhanTable;
-(void) receiveDataByCanZhanTable:(NSData*) data;

//升级请求
-(void) requestCanZhanReleaseTable;
-(void) receiveDataByCanZhanReleaseTable:(NSData*) data;

//升级请求
-(void) requestProTypeTable;
-(void) receiveDataByProTypeTable:(NSData*) data;

//升级请求
-(void) requestDiaoChaDetailTable;
-(void) receiveDataByDiaoChaDetailTable:(NSData*) data;

//升级请求
-(void) requestDiaoChaTable;
-(void) receiveDataByDiaoChaTable:(NSData*) data;

//升级请求
-(void) requestGongSiTable;
-(void) receiveDataByGongSiTable:(NSData*) data;

//升级请求
-(void) requestImageTable;
-(void) receiveDataByImageTable:(NSData*) data;

//升级请求
-(void) requestZhanWeiProTable;
-(void) receiveDataByZhanWeiProTable:(NSData*) data;

//升级请求
-(void) requestZhanWeiInfoTable;
-(void) receiveDataByZhanWeiInfoTable:(NSData*) data;

//升级请求
-(void) requestVersionTable;
-(void) receiveDataByVersionTable:(NSData*) data;

//升级请求
-(void) requestChangJingInfoTable;
-(void) receiveDataByChangJingInfoTable:(NSData*) data;

//升级请求
-(void) requestDiaoChaItemInfoTable;
-(void) receiveDataByDiaoChaItemInfoTable:(NSData*) data;

//开启一个 单独线程 下载图片和 写数据库
-(void) startDownImageAndWriteToDatabase;
-(void) threadDownWriteFun;

-(void) callUpgradeSuccOnMainThread;
-(void) callUpgradeFailureOnMainThread;
-(void) callUpgradeNoNetOnMainThread;

-(void) doCanZhanData;
-(void) doCanZhanReleaseData;
-(void) doProTypeData;
-(void) doDiaoChaDetailData;
-(void) doDiaoChaData;
-(void) doGongSiData;
-(void) doImageData;
-(void) doZhanWeiProData;
-(void) doZhanWeiInfoData;
-(void) doChangJingInfoData;
-(void) doDiaoChaItemInfoData;
-(void) doVersionData;


@end
