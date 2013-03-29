//
//  ZhanWeiListViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZhanWeiListViewController.h"
#import "ZhanWeiDetaiViewController.h"
#import "GGlobal.h"

#import "ZhanWeiInfoTableObj.h"
#import "DataBase.h"

@interface ZhanWeiListViewController ()

@end

@implementation ZhanWeiListViewController
@synthesize m_titleLabel;
@synthesize m_tableView,m_page,m_refreshing,m_tableArray,m_zhanweiId;

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
    self.m_tableView = [[UITableView alloc] initWithFrame:bounds];
    self.m_tableView.dataSource = self;
    self.m_tableView.delegate = self;
    [self.view insertSubview:self.m_tableView atIndex:2];
    
   

    
}

- (void)viewDidUnload
{
    [self setM_titleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [m_tableArray release];
    [m_tableView release];
    [m_titleLabel release];
    [super dealloc];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(self.m_tableArray){
        [self.m_tableArray release];
        
    }
    self.m_tableArray = [[NSMutableArray alloc] initWithArray:[DataBase getOneZhanWeiInfoByZhanweiId:self.m_zhanweiId]];
    [self.m_tableView reloadData];
    
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
    
    
    
    
    [self.m_tableView tableViewDidFinishedLoading];
    [self.m_tableView reloadData];
    
    
}

-(void) clickDetailButton:(id)sender
{
    UIButton* button = (UIButton*)sender;
    UITableViewCell* cell = (UITableViewCell*)[button superview];
    
    NSIndexPath* index = [self.m_tableView indexPathForCell:cell];
    NSLog(@"index = %@, tag = %d",index,button.tag);
}

#pragma mark - TableView*



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.m_tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellid=@"cellzhanwei";
	
	UITableViewCell* cell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if (cell==nil) {
		cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid]autorelease];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        }
    ZhanWeiInfoTableObj* zhanwei = [self.m_tableArray objectAtIndex:indexPath.row];
    cell.textLabel.text = zhanwei.m_showInfoId;

 
	return cell;
    
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [GGlobal getGlobalInstance].m_zhanweiListViewFresh = NO;
//    ZhanWeiDetaiViewController* zhanwei = [[ZhanWeiDetaiViewController alloc] init];
//    
//    zhanwei.m_zhanweiInfo = [self.m_tableArray objectAtIndex:indexPath.row];
//    
//    [self.navigationController pushViewController:zhanwei animated:YES];
//    [zhanwei release];
//    
    
    
}

@end
