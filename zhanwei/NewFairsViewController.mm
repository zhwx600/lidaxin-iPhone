//
//  NewFairsViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 13-3-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "NewFairsViewController.h"
#import "xmlCommand.h"
#import "Cell1.h"
#import "Cell2.h"
#import "GGlobal.h"
#import "DataBase.h"

#import "ZhanWeiListViewController.h"
#import "ZhanPinDetailViewController.h"
#import "YuYueViewController.h"
#import "CateTableCell.h"
#import "GGlobal.h"

#import "CanZhanTableObj.h"
#import "ZhanWeiProTableObj.h"
#import "ZhanWeiDetaiViewController.h"
#import "ZhanWeiInfoTableObj.h"
#import "DataBase.h"

#import "YuYueViewController.h"
#import "NewCuxiaoViewController.h"



@implementation NewFairsViewController
@synthesize m_viewTitle;
@synthesize expansionTableView;
@synthesize m_type;
@synthesize m_titleStr;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
if (self) {
    // Custom initialization
}
return self;
}

- (void)didReceiveMemoryWarning
{
// Releases the view if it doesn't have a superview.
[super didReceiveMemoryWarning];

// Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
[super viewDidLoad];
// Do any additional setup after loading the view from its nib.

    self.expansionTableView.sectionFooterHeight = 0;
    self.expansionTableView.sectionHeaderHeight = 0;
    
    self.expansionTableView.backgroundColor = [UIColor clearColor];
    self.expansionTableView.separatorColor = [UIColor clearColor];
    
    self.m_viewTitle.text = self.m_titleStr;

    [self initData];

}

- (void)viewDidUnload
{
[self setM_viewTitle:nil];
[super viewDidUnload];
// Release any retained subviews of the main view.
// e.g. self.myOutlet = nil;
}


-(void) dealloc
{
self.expansionTableView = nil;

[m_type release];
[m_typeDataArray release];
[m_proDataArray release];
[m_titleStr release];
[m_viewTitle release];
[super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
// Return YES for supported orientations
return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) initData
{
    


    if (m_typeDataArray) {
        [m_typeDataArray release];
        m_typeDataArray = nil;
    }
    m_typeDataArray = [[NSMutableArray alloc] initWithArray:[DataBase getAllCanZhanTableObj]];

    m_proDataArray = [[NSMutableArray alloc] initWithObjects:@"Overview",@"Product",@"Appointment", nil];
    
    [self.expansionTableView reloadData];

}

- (IBAction)close:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [m_typeDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CanZhanTableObj* tempro = [m_typeDataArray objectAtIndex:section];
    if (tempro.m_bIsOpen) {
        return m_proDataArray.count+1;
    }
    return 1;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 55;
    }else {
        return 62;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CanZhanTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];
    if (tempro.m_bIsOpen && indexPath.row!=0) {
        static NSString *CellIdentifier = @"Cell2";
        Cell2 *cell = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            CGRect rect = cell.titleLabel.frame;
            rect.origin.x -= 50;
            
            [cell.titleLabel setFrame:rect];
            cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"横条2.png"]] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }
        
        cell.titleLabel.text = (NSString*)[m_proDataArray objectAtIndex:indexPath.row-1];
           
        return cell;
    }else
    {
        static NSString *CellIdentifier = @"Cell1";
        Cell1 *cell = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
            
            cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"横条1.png"]] autorelease];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.m_subTitleLabel.textColor = [UIColor whiteColor];
        }
        
        CanZhanTableObj* temCanZhan = [m_typeDataArray objectAtIndex:indexPath.section];
        cell.m_subTitleLabel.text = temCanZhan.m_zhanhuiDescription;
        cell.titleLabel.text = temCanZhan.m_canzhanName;
        [cell changeArrowWithUp:(tempro.m_bIsOpen?YES:NO)];
        return cell;
    }
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CanZhanTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];
    int intaw = indexPath.row;
    if (indexPath.row == 0) {
        if (tempro.m_bIsOpen) {
            tempro.m_bIsOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO Index:indexPath];
            
        }else
        {
            [self didSelectCellRowFirstDo:YES nextDo:NO Index:indexPath];
        }
        
    }else
    {
        //        NSDictionary *dic = [_dataList objectAtIndex:indexPath.section];
        //        NSArray *list = [dic objectForKey:@"list"];
        //        NSString *item = [list objectAtIndex:indexPath.row-1];
        //        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"sdfasdasdfsadaf" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil] autorelease];
        //        [alert show];
        
           
        if (indexPath.row == 1) {
            CanZhanTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];

            ZhanWeiDetaiViewController* temProView = [[ZhanWeiDetaiViewController alloc] init];
            temProView.m_proObj = tempro;
            [self.navigationController pushViewController:temProView animated:YES];
            [temProView release];
            

        }else if (indexPath.row == 2){
            
            CanZhanTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];
            NewCuxiaoViewController* m_newCuXiaoView = [[NewCuxiaoViewController alloc] init];
            m_newCuXiaoView.m_type = @"展品";
            m_newCuXiaoView.m_titleStr = @"Product";
            m_newCuXiaoView.m_proObj = tempro;
            [self.navigationController pushViewController:m_newCuXiaoView animated:YES];
            [m_newCuXiaoView release];
            
            
        }else if (indexPath.row == 3){
            CanZhanTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];
            if (IS_IPHONE5) {
                YuYueViewController* list = [[YuYueViewController alloc] initWithNibName:@"YuYueViewController5" bundle:nil];
                list.m_zhanweiid = tempro.m_canzhanId;
                [self.navigationController pushViewController:list animated:YES];
                [list release];
            }else{
                YuYueViewController* list = [[YuYueViewController alloc] initWithNibName:@"YuYueViewController" bundle:nil];
                list.m_zhanweiid = tempro.m_canzhanId;
                [self.navigationController pushViewController:list animated:YES];
                [list release];
            }
            
            
        }
        
    
    
    
    
    
}
[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert Index:(NSIndexPath*) sIndex
{
    
    CanZhanTableObj* tempro = [m_typeDataArray objectAtIndex:sIndex.section];
    tempro.m_bIsOpen = firstDoInsert;

    Cell1 *cell = (Cell1 *)[self.expansionTableView cellForRowAtIndexPath:sIndex];
    [cell changeArrowWithUp:firstDoInsert];

    [self.expansionTableView beginUpdates];


    //    int contentCount = [[[_dataList objectAtIndex:section] objectForKey:@"list"] count];

    int contentCount = m_proDataArray.count;

    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    for (NSUInteger i = 1; i < contentCount + 1; i++) {
        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:sIndex.section];
        [rowToInsert addObject:indexPathToInsert];
    }

    if (firstDoInsert)
    {   [self.expansionTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [self.expansionTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }

    [rowToInsert release];

    [self.expansionTableView endUpdates];
    if (nextDoInsert) {
        tempro.m_bIsOpen = YES;
        
        [self didSelectCellRowFirstDo:YES nextDo:NO Index:sIndex];
    }
    if (tempro.m_bIsOpen) [self.expansionTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}



@end

