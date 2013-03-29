//
//  NewCuxiaoViewController.h
//  lidaxin-iPhone
//
//  Created by zheng wanxiang on 13-3-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CanZhanTableObj.h"
#import "UIImage-Extensions.h"

@interface NewCuxiaoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* m_typeDataArray;
    //NSMutableArray* m_proDataArray;
    NSMutableArray* m_allProObj;
    
    
}


@property (retain, nonatomic) IBOutlet UILabel *m_viewTitle;
@property (nonatomic,retain)IBOutlet UITableView *expansionTableView;
@property (nonatomic,retain)NSString* m_type;
@property (retain, nonatomic)NSString *m_titleStr;

@property (retain, nonatomic) CanZhanTableObj* m_proObj;

-(void) initData;
- (IBAction)close:(id)sender;

@end
