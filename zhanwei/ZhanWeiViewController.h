//
//  ZhanWeiViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"


@interface ZhanWeiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIFolderTableViewDelegate>

@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (retain, nonatomic) UIFolderTableView *m_tableView;
@property (nonatomic) BOOL m_refreshing;
@property (assign,nonatomic) NSInteger m_page;
@property (nonatomic,retain) NSMutableArray* m_tableArray;

- (IBAction)colseButton:(id)sender;

-(void) clickDetailButton:(id) sender;


-(IBAction)zhanWeiButton:(id)sender;
-(IBAction)zhanPinButton:(id)sender;
-(IBAction)YuYueButton:(id)sender;

-(void) receiveDataForZhanWeiInfo:(NSData*) data;

@end
