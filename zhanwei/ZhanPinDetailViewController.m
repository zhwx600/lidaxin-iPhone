//
//  ZhanPinDetailViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZhanPinDetailViewController.h"
#import "JSTabButton.h"
#import "JSTabItem.h"
#import "GGlobal.h"
#import "DataBase.h"
#import "ZhanWeiProTableObj.h"
#import "ImageTableObj.h"
#import "CanZhanTableObj.h"
#import "ChanPinZiXunViewController.h"


NSString* paramSeparetedStr = @"$paramSeparate$";

@interface ZhanPinDetailViewController ()

@end

@implementation ZhanPinDetailViewController
@synthesize m_titleLabel;
@synthesize m_imageView;
@synthesize m_tabBar;
@synthesize m_paramScrollView;
@synthesize m_proScrollView;
@synthesize m_zhanweiid,m_allProObj,m_canzhanObj,m_selectProId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    m_tabBar = [[JSScrollableTabBar alloc] initWithFrame:CGRectMake(0, 302, 320, 44) style:JSScrollableTabBarStyleTransparent];
	[m_tabBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
	[m_tabBar setDelegate:self];
	[self.view addSubview:m_tabBar];
	

	
	
//	UIButton *styleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	[styleButton setTitle:@"Change Style" forState:UIControlStateNormal];
//	[styleButton addTarget:self
//					action:@selector(changeStyle:)
//		  forControlEvents:UIControlEventTouchUpInside];
//	[styleButton sizeToFit];
//	CGRect buttonFrame = [styleButton frame];
//	buttonFrame.origin = CGPointMake(150, 150);
//	[styleButton setFrame:buttonFrame];
//	[self.view addSubview:styleButton];
    
    
}

- (void)viewDidUnload
{
    [self setM_titleLabel:nil];
    [self setM_proScrollView:nil];
    [self setM_paramScrollView:nil];
    [self setM_imageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewWillAppear:(BOOL)animated
{
    
    self.m_titleLabel.text = m_canzhanObj.m_canzhanName;
    
    if (m_allProObj) {
        [m_allProObj release];
    }
    m_allProObj = [[NSMutableArray alloc] initWithArray:[DataBase getSomeZhanWeiProTableInfoZWId:m_zhanweiid]];
    
    if (m_allProObj && m_allProObj.count<=0) {
        return;
    }
    
    NSMutableArray* typeArr = [NSMutableArray array];
    //获取 类型shuzu
    for (int i=0; i<m_allProObj.count; i++) {
        ZhanWeiProTableObj* proObj = [m_allProObj objectAtIndex:i];
        
        NSString* imageid = proObj.m_showProImageId;
        ImageTableObj* imageObj = [DataBase getOneImageTableInfoImageid:imageid];
        
        if (typeArr.count>0) {
            
            BOOL haveSame = NO;
            for (int j=0; j<typeArr.count; j++) {
                
                if (0 == [imageObj.m_imageType compare:((ImageTableObj*)[typeArr objectAtIndex:j]).m_imageType]) {
                    haveSame = YES;
                    break;
                }else{
                    haveSame = NO;
                    // [typeArr addObject:imageObj];
                }
            }
            if (!haveSame) {
                [typeArr addObject:imageObj];
            }
        
        }else{
            [typeArr addObject:imageObj];
        } 
    }
    
    
    NSMutableArray* items = [NSMutableArray array];
    //初始化 类型 控件
	for (int i = 0; i < typeArr.count; i++)
	{
        ImageTableObj* imageobj = [typeArr objectAtIndex:i];
        
		JSTabItem *item = [[JSTabItem alloc] initWithTitle:imageobj.m_imageType andColor:[UIColor clearColor] andTextColor:[UIColor blackColor]];
		[items addObject:item];
		[item release];
        
	}
	[m_tabBar setTabItems:items];
    
    //初始化 选中一个 tab
    NSMutableArray* proArr = [NSMutableArray array];
    for (int i=0; i<m_allProObj.count; i++) {
        ZhanWeiProTableObj* proObj = [m_allProObj objectAtIndex:i];
        ImageTableObj* temimageobj = [DataBase getOneImageTableInfoImageid:proObj.m_showProImageId];
        
        if (0 == [temimageobj.m_imageType compare:((ImageTableObj*)[typeArr objectAtIndex:0]).m_imageType]) {
            [proArr addObject:proObj];
        }
    }
    
    for (UIView* view in [self.m_proScrollView subviews]) {
        [view removeFromSuperview];
    }
    int jiange = 0;
    for (int i=0; i<proArr.count; i++) {
        ZhanWeiProTableObj* proObj = [proArr objectAtIndex:i];
        UIButton* tembutton = [[UIButton alloc] initWithFrame:CGRectMake(jiange + 2, 2, 120, 120)];
        tembutton.titleLabel.text = proObj.m_showProId;
        ImageTableObj* imageobj = [DataBase getOneImageTableInfoImageid:proObj.m_showProImageId];

        NSString* path = [DataProcess getImageFilePathByUrl:imageobj.m_imageUrl];
        UIImage* image = [UIImage imageWithContentsOfFile:path];
  
        
        // [tembutton setTitle:[self.m_posNameArr objectAtIndex:i] forState:UIControlStateNormal];
        [tembutton setBackgroundImage:image forState:UIControlStateNormal];
        [tembutton addTarget:self action:@selector(imageButtonSelect:) forControlEvents:UIControlEventTouchUpInside];
        tembutton.tag = i;

        [self.m_proScrollView addSubview:tembutton];
        [tembutton release];
        jiange += 120+2;

        
        //chushihua 参数
        if (i == 0) {
            NSArray* temarr = [imageobj.m_imageDescription componentsSeparatedByString:paramSeparetedStr];

            if (m_selectProId) {
                [m_selectProId release];
            }
            m_selectProId = [[NSString alloc] initWithString:proObj.m_showProId];
            
            [self initParamScrollView:temarr];            
            
            self.m_imageView.image = image;
            
            if (self.m_imageView.image.size.width >= 121 || self.m_imageView.image.size.height >= 206) {
                if (self.m_imageView.image.size.width >= 121) {
                    float scale = self.m_imageView.image.size.width/121.0;
                    [self.m_imageView setFrame:CGRectMake(3, 60, 121, self.m_imageView.image.size.height/scale)];
                }else {
                    float scale = self.m_imageView.image.size.height/206.0;
                    [self.m_imageView setFrame:CGRectMake(3, 60, self.m_imageView.image.size.width/scale, 206)];
                }
                
            }else {
                
                [self.m_imageView setFrame:CGRectMake(3, 60, self.m_imageView.image.size.width, self.m_imageView.image.size.height)];
            }
            [self.m_imageView setCenter:CGPointMake(62, 208)];
            
        }
        
        
        
    }
    [self.m_proScrollView setContentSize:CGSizeMake(jiange, 0)];
    
    
    
}

-(void) initParamScrollView:(NSArray*) arr
{
    for (UIView* view in [self.m_paramScrollView subviews]){
        [view removeFromSuperview];
    }
    
    
    int startVerOff = 10;
    
    int maxwidth = 0;
    
    for (int i=0; i<arr.count; i++) {
        
        NSString* str = [arr objectAtIndex:i];
        UIFont *font =  [UIFont fontWithName:@"Helvetica" size:15.0f];;
        CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 21)];
        if (maxwidth <= size.width) {
            maxwidth = size.width;
        }
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(2, startVerOff, size.width, 21)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentLeft;
        label.font = [UIFont fontWithName:@"Helvetica" size:15.0f];;

        label.text = [arr objectAtIndex:i];
        [self.m_paramScrollView addSubview:label];
        [label release];
        
        startVerOff += 30;
        
        NSLog(@"nitParamScrollView: %@",[arr objectAtIndex:i]);        
    }
    [self.m_paramScrollView setContentSize:CGSizeMake(maxwidth, startVerOff)];
    
}

- (void)scrollableTabBar:(JSScrollableTabBar *)tabBar didSelectTabAtIndex:(NSInteger)index
{
	//[self.m_titleLabel setText:[NSString stringWithFormat:@"Selected tab: %d", index]];
    
    
    JSTabItem* selitem = [tabBar getTabItemsByIndex:index];
    
    NSString* typeName = selitem.title;
 
    for (UIView* view in [m_proScrollView subviews]) {
        [view removeFromSuperview];
    }
    int jiange = 0;
    for (int i=0; i<m_allProObj.count; i++) {
        
        ZhanWeiProTableObj* proobj = [m_allProObj objectAtIndex:i];
        ImageTableObj* imageobj = [DataBase getOneImageTableInfoImageid:proobj.m_showProImageId];
        
        if (0 == [imageobj.m_imageType compare:typeName]) {
            
                        
            UIButton* tembutton = [[UIButton alloc] initWithFrame:CGRectMake(jiange + 2, 2, 120, 120)];
            tembutton.titleLabel.text = proobj.m_showProId;
            ImageTableObj* imageobj = [DataBase getOneImageTableInfoImageid:proobj.m_showProImageId];
            
            NSString* path = [DataProcess getImageFilePathByUrl:imageobj.m_imageUrl];
            UIImage* image = [UIImage imageWithContentsOfFile:path];
            
            
            // [tembutton setTitle:[self.m_posNameArr objectAtIndex:i] forState:UIControlStateNormal];
            [tembutton setBackgroundImage:image forState:UIControlStateNormal];
            [tembutton addTarget:self action:@selector(imageButtonSelect:) forControlEvents:UIControlEventTouchUpInside];
            tembutton.tag = i;
            
            [self.m_proScrollView addSubview:tembutton];
            [tembutton release];
            jiange += 120+2;
            
            
            
            //chushihua 参数
            if (i == 0) {
                NSArray* temarr = [imageobj.m_imageDescription componentsSeparatedByString:paramSeparetedStr];
                if (m_selectProId) {
                    [m_selectProId release];
                }
                m_selectProId = [[NSString alloc] initWithString:proobj.m_showProId];

                [self initParamScrollView:temarr];            
                
                self.m_imageView.image = image;
                
                if (self.m_imageView.image.size.width >= 121 || self.m_imageView.image.size.height >= 206) {
                    if (self.m_imageView.image.size.width >= 121) {
                        float scale = self.m_imageView.image.size.width/121.0;
                        [self.m_imageView setFrame:CGRectMake(3, 60, 121, self.m_imageView.image.size.height/scale)];
                    }else {
                        float scale = self.m_imageView.image.size.height/206.0;
                        [self.m_imageView setFrame:CGRectMake(3, 60, m_imageView.image.size.width/scale, 206)];
                    }
                    
                }else {
                    
                    [self.m_imageView setFrame:CGRectMake(3, 60, self.m_imageView.image.size.width, self.m_imageView.image.size.height)];
                }
                [self.m_imageView setCenter:CGPointMake(62, 208)];
                
            }

            
            
        }
        
                
        
        
    }
    [self.m_proScrollView setContentSize:CGSizeMake(jiange, 0)];
    
    
    
    
    
    
    
    
}

-(void) imageButtonSelect:(id) sender
{
    UIButton* button = sender;
    NSString* proid = button.titleLabel.text;
    
    if (m_selectProId) {
        [m_selectProId release];
    }
    m_selectProId = [[NSString alloc] initWithString:proid];

    
    ZhanWeiProTableObj* proobjj = [DataBase getOneZhanWeiProTableInfoProId:proid];
    
    ImageTableObj* imageObj = [DataBase getOneImageTableInfoImageid:proobjj.m_showProImageId];
    NSLog(@"url = %@, des = %@",imageObj.m_imageUrl,imageObj.m_imageDescription);
    
    NSArray* temarr = [imageObj.m_imageDescription componentsSeparatedByString:paramSeparetedStr];
    
    [self initParamScrollView:temarr];            
    NSString* path = [DataProcess getImageFilePathByUrl:imageObj.m_imageUrl];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    self.m_imageView.image = image;
    
    
    if (self.m_imageView.image.size.width >= 121 || self.m_imageView.image.size.height >= 206) {
        if (self.m_imageView.image.size.width >= 121) {
            float scale = self.m_imageView.image.size.width/121.0;
            [self.m_imageView setFrame:CGRectMake(3, 105, 121, self.m_imageView.image.size.height/scale)];
        }else {
            float scale = self.m_imageView.image.size.height/206.0;
            [self.m_imageView setFrame:CGRectMake(3, 105, self.m_imageView.image.size.width/scale, 206)];
        }
        
    }else {
        
        [self.m_imageView setFrame:CGRectMake(3, 60, self.m_imageView.image.size.width, self.m_imageView.image.size.height)];
    }
    [self.m_imageView setCenter:CGPointMake(62, 208)];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)proZiXunButtonAct:(id)sender 
{
    if (m_selectProId && [m_selectProId length] > 0) {
        
    }else{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Warning message" message:@"Please select a product!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return;
    }

    
    ChanPinZiXunViewController* zixunview = [[ChanPinZiXunViewController alloc] init];
    zixunview.m_chanPinId = m_selectProId;
    [self.navigationController pushViewController:zixunview animated:YES];
    [zixunview release];
    
}
- (void)dealloc {
    [m_titleLabel release];
    [m_proScrollView release];
    [m_paramScrollView release];
    [m_imageView release];
    [super dealloc];
}
@end
