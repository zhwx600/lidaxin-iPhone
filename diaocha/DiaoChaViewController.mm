//
//  DiaoChaViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DiaoChaViewController.h"
#import "DiaoChaoCommitViewController.h"
#import "GGlobal.h"
#import "DataBase.h"
#import "DiaoChaTableObj.h"
#import "DiaoChanDetailTableObj.h"
#include "ZhwxDefine.h"


@interface DiaoChaViewController ()

@end

@implementation DiaoChaViewController
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
    
    CGRect bounds = DEV_HAVE_NAV_VIEW_FRAME;
    m_tableView = [[UITableView alloc] initWithFrame:bounds];
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    m_tableView.backgroundColor = [UIColor clearColor];
    m_tableView.separatorColor = [UIColor clearColor];
    [self.view insertSubview:m_tableView atIndex:2];

    if(m_tableArray){
        [m_tableArray release];
        
    }
    m_tableArray = [[NSMutableArray alloc] initWithArray:[DataBase getAllDiaoChaTableObj]];
    [m_tableView reloadData];
//    [m_tableArray addObject:@"调查1"];
//    [m_tableArray addObject:@"调查2"];

    
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

-(void) dealloc
{
    
    [m_tableArray release];
    [m_tableView release];
    [m_titleLabel release];
    [super dealloc];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}



#pragma mark - TableView*

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return m_tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString* cellid=@"celldiaocha";
	
	UITableViewCell* cell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
	
	if (cell==nil) {
		cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid]autorelease];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"横条2.png"]] autorelease];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        UIImageView* temright = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右箭头.png"]];
        CGRect frame = temright.frame;
        frame.origin = CGPointMake(285, 15);
        frame.size = CGSizeMake(20, 25);
        [temright setFrame:frame];
        [cell addSubview:temright];
        [temright release];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    DiaoChaTableObj* obj = [m_tableArray objectAtIndex:indexPath.row];
    
    

    cell.textLabel.text = obj.m_diaochaName;
    
	
	return cell;

    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DiaoChaoCommitViewController* commit = [[DiaoChaoCommitViewController alloc] init];


    DiaoChaTableObj* obj = [m_tableArray objectAtIndex:indexPath.row];
    commit.m_diaochaId = obj.m_diaochaId;
    commit.m_diaochaObj = obj;
    [self.navigationController pushViewController:commit animated:YES];
    [commit release];
        
       
}

- (IBAction)colseButton:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
