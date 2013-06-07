//
//  ZhanWeiViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZhanWeiViewController.h"
#import "ZhanWeiListViewController.h"
#import "ZhanPinDetailViewController.h"
#import "YuYueViewController.h"
#import "CateTableCell.h"
#import "GGlobal.h"

#import "CanZhanTableObj.h"
#import "ZhanWeiProTableObj.h"
#import "ZhanWeiListViewController.h"
#import "ZhanWeiInfoTableObj.h"
#import "DataBase.h"

#import "HttpProcessor.h"
#import "xmlparser.h"


@interface ZhanWeiViewController ()

@end

@implementation ZhanWeiViewController
@synthesize m_titleLabel;

@synthesize m_tableView,m_page,m_refreshing,m_tableArray;

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
    
    CGRect bounds = CGRectMake(0, 44, 320, 460-44);
    m_tableView = [[UIFolderTableView alloc] initWithFrame:bounds];
     m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.folderDelegate = self;
    [self.view insertSubview:m_tableView atIndex:2];
    
    m_tableView.rowHeight = 60.0f;
    //m_tableArray = [[NSMutableArray alloc] init];

    
    //m_tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
    
   // m_tableView.separatorColor = [UIColor redColor];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc
{
    
    [m_tableArray release];
    [m_tableView release];
    [m_titleLabel release];
    [super dealloc];
}

-(void) firstFresh
{
    
    if ([GGlobal getGlobalInstance].m_zhanweiViewFresh) {
        [m_tableView launchRefreshing];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
  //  [self performSelector:@selector(firstFresh) withObject:nil afterDelay:0.01f];
    
    if(m_tableArray){
        [m_tableArray release];
        
    }
    m_tableArray = [[NSMutableArray alloc] initWithArray:[DataBase getAllCanZhanTableObj]];
    [m_tableView reloadData];
    
    
}

- (IBAction)colseButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
 
#pragma mark - Your actions

- (void)loadData{
    //    self.m_page++;
    //    if (self.m_refreshing) {
    //        self.m_page = 1;
    //        self.m_refreshing = NO;
    //        [self.m_tableDataArr removeAllObjects];
    //    }
    //    for (int i = 0; i < 10; i++) {
    //        [self.m_tableDataArr addObject:@"ROW"];
    //    }
    //    if (self.m_page >= 3) {
    //        [self.m_tableView tableViewDidFinishedLoadingWithMessage:@"All loaded!"];
    //        self.m_tableView.reachedTheEnd  = YES;
    //    } else {        
    //        [self.m_tableView tableViewDidFinishedLoading];
    //        self.m_tableView.reachedTheEnd  = NO;
    //        [self.m_tableView reloadData];
    //    }
    
    NSString* str = @"<?xml version='1.0' encoding='utf-8' ?>\
    <command>\
    <commandid>ihshow</commandid>\
    <requestshow>\
	<showid>1=0</showid>\
    </requestshow>\
    </command>";
    
   // NSArray* temArr = [DataBase getAllImageTableObj];
    //str = [MyXMLParser EncodeToStr:temArr Type:@"image2"];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDataForZhanWeiInfo:)];
    [http threadFunStart];
    
    [http release];
    
    NSLog(@"------------------------");

    
    
}

-(void) receiveDataForZhanWeiInfo:(NSData*) data
{
    
    [m_tableView tableViewDidFinishedLoading];
    [m_tableView reloadData];
    if (data) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"receiveDataForZhanWeiInfo := %@",str);
        [str release];
        
    }else{
        NSLog(@"receiveDataForZhanWeiInfo 接收到 数据 异常");
        
    }

}

-(void)subCateBtnAction:(UIButton *)btn
{
    
    NSLog(@"row = %d",[btn superview].tag);
    return;
    
}

-(void) clickDetailButton:(id)sender
{
    UIButton* button = (UIButton*)sender;
    UITableViewCell* cell = (UITableViewCell*)[button superview];
    
    NSIndexPath* index = [m_tableView indexPathForCell:cell];
    NSLog(@"index = %@, tag = %d",index,button.tag);
    
    if (2 == button.tag) {
        ZhanWeiListViewController* list = [[ZhanWeiListViewController alloc] init];
        [self.navigationController pushViewController:list animated:YES];
        [list release];
        
    }else if (3 == button.tag){
        ZhanPinDetailViewController* list = [[ZhanPinDetailViewController alloc] init];
        [self.navigationController pushViewController:list animated:YES];
        [list release];
    }else{
        YuYueViewController* list = [[YuYueViewController alloc] init];
        [self.navigationController pushViewController:list animated:YES];
        [list release];
        
        if (IS_IPHONE5) {
            YuYueViewController* list = [[YuYueViewController alloc] initWithNibName:@"YuYueViewController5" bundle:nil];
            [self.navigationController pushViewController:list animated:YES];
            [list release];
        }else{
            YuYueViewController* list = [[YuYueViewController alloc] initWithNibName:@"YuYueViewController" bundle:nil];
            [self.navigationController pushViewController:list animated:YES];
            [list release];
        }

        
    }
    
    
    
}

-(IBAction)zhanWeiButton:(id)sender
{
    [GGlobal getGlobalInstance].m_zhanweiViewFresh = NO;
    ZhanWeiListViewController* list = [[ZhanWeiListViewController alloc] init];
    [GGlobal getGlobalInstance].m_zhanweiListViewFresh = NO;
    CanZhanTableObj* zhanwei = [m_tableArray objectAtIndex:((UIButton*)sender).tag];

    list.m_zhanweiId = zhanwei.m_canzhanId;
    
    [self.navigationController pushViewController:list animated:YES];
    [list release];
}
-(IBAction)zhanPinButton:(id)sender
{
    [GGlobal getGlobalInstance].m_zhanweiViewFresh = NO;
    ZhanPinDetailViewController* list = [[ZhanPinDetailViewController alloc] init];
    CanZhanTableObj* zhanwei = [m_tableArray objectAtIndex:((UIButton*)sender).tag];
    list.m_canzhanObj = zhanwei;
    list.m_zhanweiid = zhanwei.m_canzhanId;
    [self.navigationController pushViewController:list animated:YES];
    [list release];
}
-(IBAction)YuYueButton:(id)sender
{
    [GGlobal getGlobalInstance].m_zhanweiViewFresh = NO;
    
    
    if (IS_IPHONE5) {
        YuYueViewController* list = [[YuYueViewController alloc] initWithNibName:@"YuYueViewController5" bundle:nil];
        CanZhanTableObj* zhanwei = [m_tableArray objectAtIndex:((UIButton*)sender).tag];
        
        list.m_zhanweiid = zhanwei.m_canzhanId;
        [self.navigationController pushViewController:list animated:YES];
        [list release];
    }else{
        YuYueViewController* list = [[YuYueViewController alloc] initWithNibName:@"YuYueViewController" bundle:nil];
        CanZhanTableObj* zhanwei = [m_tableArray objectAtIndex:((UIButton*)sender).tag];
        
        list.m_zhanweiid = zhanwei.m_canzhanId;
        [self.navigationController pushViewController:list animated:YES];
        [list release];
    }
    
}



#pragma mark - TableView*


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return m_tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString* cellid=@"cellzhanwei";
//	
//	UITableViewCell* cell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
//	
//	if (cell==nil) {
//		cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid]autorelease];
//       // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//        UILabel* button1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 25)];
//        button1.text = @"香港展";
//        button1.font = [UIFont fontWithName:@"System" size:25];
//        button1.textAlignment = UITextAlignmentCenter;
//        button1.backgroundColor = [UIColor clearColor];
//        button1.tag = 1;
//        [cell addSubview:button1];
//        [button1 release];
//        
//        UIButton* button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 106, 15)];
//        [button2 setBackgroundImage:[UIImage imageNamed:@"tabButtonSelect.png"] forState:UIControlStateNormal];
//        button2.tag = 2;
//        [button2 addTarget:self action:@selector(clickDetailButton:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:button2];
//        [button2 release];
//        
//        UIButton* button3 = [[UIButton alloc] initWithFrame:CGRectMake(107, 50, 106, 15)];
//        [button3 setBackgroundImage:[UIImage imageNamed:@"tabButtonSelect.png"] forState:UIControlStateNormal];
//        button3.tag = 3;
//        [button3 addTarget:self action:@selector(clickDetailButton:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:button3];
//        [button3 release];
//        
//        UIButton* button4 = [[UIButton alloc] initWithFrame:CGRectMake(213, 50, 106, 15)];
//        [button4 setBackgroundImage:[UIImage imageNamed:@"tabButtonSelect.png"] forState:UIControlStateNormal];
//        button4.tag = 4;
//        [button4 addTarget:self action:@selector(clickDetailButton:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:button4];
//        [button4 release];
//    }
//    
//    UILabel* label = [cell viewWithTag:1];
//    label.text = @"香港站";
    
    
    
    
    static NSString *CellIdentifier = @"cate_cell";
    
    CateTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[CateTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                     reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    //    
    //    NSDictionary *cate = [self.cates objectAtIndex:indexPath.row];
    //    cell.logo.image = [UIImage imageNamed:[[cate objectForKey:@"imageName"] stringByAppendingString:@".png"]];
    //    cell.title.text = [cate objectForKey:@"name"];
    //    
    //    NSMutableArray *subTitles = [[NSMutableArray alloc] init];
    //    NSArray *subClass = [cate objectForKey:@"subClass"];
    //    for (int i=0; i < MIN(4,  subClass.count); i++) {
    //        [subTitles addObject:[[subClass objectAtIndex:i] objectForKey:@"name"]];
    //    }
    
    CanZhanTableObj* zhanwei = [m_tableArray objectAtIndex:indexPath.row];
    cell.title.text = zhanwei.m_canzhanName;
    
	return cell;
    
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (0 == indexPath.row) {
//        
//        DiaoChaoCommitViewController* commit = [[DiaoChaoCommitViewController alloc] init];
//        [self.navigationController pushViewController:commit animated:YES];
//        [commit release];
//        
//    }else {
//        DiaoChaoCommitViewController* commit = [[DiaoChaoCommitViewController alloc] init];
//        [self.navigationController pushViewController:commit animated:YES];
//        [commit release];
//        
//    }
    
    
    
    UIView* temVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,32)];
    UIButton* button1 = [[UIButton alloc] initWithFrame:CGRectMake(13, 1, 80, 30)];
    [temVIew addSubview:button1];
    [button1 addTarget:self action:@selector(zhanWeiButton:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed:@"liekaibutton.png"] forState:UIControlStateNormal];
    [button1 setExclusiveTouch:YES];
    button1.titleLabel.font = [UIFont fontWithName:@"System" size:12];
    [button1 setTitle:@"Booth" forState:UIControlStateNormal];
    temVIew.tag = indexPath.row;
    [button1 release];
    
    button1 = [[UIButton alloc] initWithFrame:CGRectMake(112, 1, 80, 30)];
    [temVIew addSubview:button1];
    [button1 addTarget:self action:@selector(zhanPinButton:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed:@"liekaibutton.png"] forState:UIControlStateNormal];
    [button1 setExclusiveTouch:YES];
    button1.titleLabel.font = [UIFont fontWithName:@"System" size:12];
    [button1 setTitle:@"Exhibits" forState:UIControlStateNormal];
    temVIew.tag = indexPath.row;
    [button1 release];
    
    button1 = [[UIButton alloc] initWithFrame:CGRectMake(210, 1, 100, 30)];
    [temVIew addSubview:button1];
    [button1 addTarget:self action:@selector(YuYueButton:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed:@"liekaibutton.png"] forState:UIControlStateNormal];
    [button1 setExclusiveTouch:YES];
    button1.titleLabel.font = [UIFont fontWithName:@"System" size:12];
    [button1 setTitle:@"Reservation" forState:UIControlStateNormal];
    temVIew.tag = indexPath.row;
    [button1 release];
    
    temVIew.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
    
    
    m_tableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
    [folderTableView openFolderAtIndexPath:indexPath WithContentView:temVIew 
                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                     // opening actions
                                 } 
                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                    // closing actions
                                } 
                           completionBlock:^{
                               // completed actions
                               m_tableView.scrollEnabled = YES;
                           }];
    
    [temVIew release];

    
    
}


-(CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


@end
