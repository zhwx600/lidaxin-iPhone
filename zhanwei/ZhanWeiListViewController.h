//
//  ZhanWeiListViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 12-11-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"

@interface ZhanWeiListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (retain, nonatomic) UITableView *m_tableView;
@property (nonatomic) BOOL m_refreshing;
@property (assign,nonatomic) NSInteger m_page;
@property (nonatomic,retain) NSMutableArray* m_tableArray;

@property (nonatomic,retain) NSString* m_zhanweiId;

- (IBAction)close:(id)sender;
@end
