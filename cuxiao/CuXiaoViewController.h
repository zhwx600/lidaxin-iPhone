//
//  CuXiaoViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSScrollableTabBar.h"

@interface CuXiaoViewController : UIViewController<JSScrollableTabBarDelegate>



@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *m_imageView;

@property (nonatomic,retain) JSScrollableTabBar* m_tabBar;
@property (retain, nonatomic) IBOutlet UIScrollView *m_paramScrollView;

@property (retain, nonatomic) IBOutlet UIScrollView *m_proScrollView;
@property (nonatomic,retain)NSMutableArray* m_allProObj;

@property (nonatomic,retain)NSString* m_type;
@property (nonatomic,retain)NSString* m_selectProId;


- (IBAction)close:(id)sender;
-(void) imageButtonSelect:(id) sender;
-(void) initParamScrollView:(NSArray*) arr;
- (IBAction)zixunButtonAct:(id)sender;
@end