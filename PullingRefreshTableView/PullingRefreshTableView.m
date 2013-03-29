//
//  PullingRefreshTableView.m
//  PullingTableView
//
//  Created by luo danal on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PullingRefreshTableView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+screenshot.h"
#import "DataProcess.h"

#define COVERALPHA 0.6

#define kPROffsetY 60.f
#define kPRMargin 5.f
#define kPRLabelHeight 20.f
#define kPRLabelWidth 100.f
#define kPRArrowWidth 20.f  
#define kPRArrowHeight 40.f

#define kTextColor [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define kPRBGColor [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0]
#define kPRAnimationDuration .18f

@interface LoadingView () 
- (void)updateRefreshDate :(NSDate *)date;
- (void)layouts;
@end

@implementation LoadingView
@synthesize atTop = _atTop;
@synthesize state = _state;
@synthesize loading = _loading;

 //Default is at top
- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top {
    self = [super initWithFrame:frame];
    if (self) {
        self.atTop = top;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = kPRBGColor;
//        self.backgroundColor = [UIColor clearColor];
        UIFont *ft = [UIFont systemFontOfSize:12.f];
        _stateLabel = [[UILabel alloc] init ];
        _stateLabel.font = ft;
        _stateLabel.textColor = kTextColor;
        _stateLabel.textAlignment = UITextAlignmentCenter;
        _stateLabel.backgroundColor = kPRBGColor;
        _stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _stateLabel.text = NSLocalizedString(@"下拉刷新", @"");
        [self addSubview:_stateLabel];

        _dateLabel = [[UILabel alloc] init ];
        _dateLabel.font = ft;
        _dateLabel.textColor = kTextColor;
        _dateLabel.textAlignment = UITextAlignmentCenter;
        _dateLabel.backgroundColor = kPRBGColor;
        _dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _dateLabel.text = NSLocalizedString(@"最后更新:无    ", @"");
        [self addSubview:_dateLabel];
        
        _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20) ];

        _arrow = [CALayer layer];
        _arrow.frame = CGRectMake(0, 0, 20, 20);
        _arrow.contentsGravity = kCAGravityResizeAspect;
      
        _arrow.contents = (id)[UIImage imageWithCGImage:[UIImage imageNamed:@"blueArrow.png"].CGImage scale:1 orientation:UIImageOrientationDown].CGImage;

        [self.layer addSublayer:_arrow];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityView];
        
        [self layouts];
        
    }
    return self;
}

- (void)layouts {
    
    CGSize size = self.frame.size;
    CGRect stateFrame,dateFrame,arrowFrame;

    float x = 0,y,margin;
//    x = 0;
    margin = (kPROffsetY - 2*kPRLabelHeight)/2;
    if (self.isAtTop) {
        y = size.height - margin - kPRLabelHeight;
        dateFrame = CGRectMake(0,y,size.width,kPRLabelHeight);
        
        y = y - kPRLabelHeight;
        stateFrame = CGRectMake(0, y, size.width, kPRLabelHeight);
        
        
        x = kPRMargin;
        y = size.height - margin - kPRArrowHeight;
        arrowFrame = CGRectMake(4*x, y, kPRArrowWidth, kPRArrowHeight);
        
        UIImage *arrow = [UIImage imageNamed:@"blueArrow"];
        _arrow.contents = (id)arrow.CGImage;
        
    } else {    //at bottom
        y = margin;
        stateFrame = CGRectMake(0, y, size.width, kPRLabelHeight );
        
        y = y + kPRLabelHeight;
        dateFrame = CGRectMake(0, y, size.width, kPRLabelHeight);
        
        x = kPRMargin;
        y = margin;
        arrowFrame = CGRectMake(4*x, y, kPRArrowWidth, kPRArrowHeight);
        
        UIImage *arrow = [UIImage imageNamed:@"blueArrowDown"];        
        _arrow.contents = (id)arrow.CGImage;
        _stateLabel.text = NSLocalizedString(@"上拉加载", @"");
    }
    
    _stateLabel.frame = stateFrame;
    _dateLabel.frame = dateFrame;
    _arrowView.frame = arrowFrame;
    _activityView.center = _arrowView.center;
    _arrow.frame = arrowFrame;
    _arrow.transform = CATransform3DIdentity;
}

- (void)setState:(PRState)state {
    [self setState:state animated:YES];
}

- (void)setState:(PRState)state animated:(BOOL)animated{
    float duration = animated ? kPRAnimationDuration : 0.f;
    if (_state != state) {
        _state = state;
        if (_state == kPRStateLoading) {    //Loading
            
            _arrow.hidden = YES;
            _activityView.hidden = NO;
            [_activityView startAnimating];
            
            _loading = YES;
            if (self.isAtTop) {
                _stateLabel.text = NSLocalizedString(@"正在刷新", @"");
            } else {
                _stateLabel.text = NSLocalizedString(@"正在加载", @"");
            }
            
        } else if (_state == kPRStatePulling && !_loading) {    //Scrolling
            
            _arrow.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            [CATransaction begin];
            [CATransaction setAnimationDuration:duration];
            _arrow.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            [CATransaction commit];
            
            if (self.isAtTop) {
                _stateLabel.text = NSLocalizedString(@"释放刷新", @"");
            } else {
                _stateLabel.text = NSLocalizedString(@"释放加载更多", @"");
            }
            
        } else if (_state == kPRStateNormal && !_loading){    //Reset
            
            _arrow.hidden = NO;
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            [CATransaction begin];
            [CATransaction setAnimationDuration:duration];
            _arrow.transform = CATransform3DIdentity;
            [CATransaction commit];
            
            if (self.isAtTop) {
                _stateLabel.text = NSLocalizedString(@"下拉刷新", @"");
            } else {
                _stateLabel.text = NSLocalizedString(@"上拉加载更多", @"");
            }
        } else if (_state == kPRStateHitTheEnd) {
            if (!self.isAtTop) {    //footer
                _arrow.hidden = YES;
                _stateLabel.text = NSLocalizedString(@"没有了哦", @"");
            }
        }
    }
}

- (void)setLoading:(BOOL)loading {
//    if (_loading == YES && loading == NO) {
//        [self updateRefreshDate:[NSDate date]];
//    }
    _loading = loading;
}

- (void)updateRefreshDate :(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [df stringFromDate:date];
    NSString *title = NSLocalizedString(@"今天", nil);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                               fromDate:date toDate:[NSDate date] options:0];
    int year = [components year];
    int month = [components month];
    int day = [components day];
    if (year == 0 && month == 0 && day < 3) {
        if (day == 0) {
            title = NSLocalizedString(@"今天",nil);
        } else if (day == 1) {
            title = NSLocalizedString(@"昨天",nil);
        } else if (day == 2) {
            title = NSLocalizedString(@"前天",nil);
        }
        df.dateFormat = [NSString stringWithFormat:@"%@ HH:mm:ss",title];
        dateString = [df stringFromDate:date];
        
    } 
    _dateLabel.text = [NSString stringWithFormat:@"%@: %@",
                       NSLocalizedString(@"最后更新", @""),
                       dateString];
    [df release];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface PullingRefreshTableView ()
- (void)scrollToNextPage;




@property (nonatomic, strong) FolderCoverView *top, *bottom;
@property (nonatomic) CGPoint oldTopPoint, oldBottomPoint;
@property (nonatomic) CGPoint oldContentOffset;
@property (nonatomic) BOOL closing;
@property (nonatomic) CGFloat offsetY;
@property (nonatomic, copy) FolderOpenBlock openBlock;
@property (nonatomic, copy) FolderCloseBlock closeBlock;
@property (nonatomic, copy) FolderCompletionBlock completionBlock;

@end

@implementation PullingRefreshTableView
@synthesize pullingDelegate = _pullingDelegate;
@synthesize autoScrollToNextPage;
@synthesize reachedTheEnd = _reachedTheEnd;
@synthesize headerOnly = _headerOnly;



@synthesize top=_top, bottom=_bottom;
@synthesize oldTopPoint=_oldTopPoint, oldBottomPoint=_oldBottomPoint;
@synthesize closing=_closing;
@synthesize subClassContentView=_subClassContentView;
@synthesize openBlock=_openBlock, closeBlock=_closeBlock, completionBlock=_completionBlock;
@synthesize offsetY=_offsetY;
@synthesize oldContentOffset=_oldContentOffset;
@synthesize folderDelegate=_folderDelegate;


- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentSize"];
    [_headerView release];
    [_footerView release];
    
    
    [_top release];
    [_bottom release];
    [_subClassContentView release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        
        CGRect rect = CGRectMake(0, 0 - frame.size.height, frame.size.width, frame.size.height);
        _headerView = [[LoadingView alloc] initWithFrame:rect atTop:YES];
        _headerView.atTop = YES;
        [self addSubview:_headerView];
        
        rect = CGRectMake(0, frame.size.height, frame.size.width, frame.size.height);
        _footerView = [[LoadingView alloc] initWithFrame:rect atTop:NO];
        _footerView.atTop = NO;
        [self addSubview:_footerView];
        
        [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame pullingDelegate:(id<PullingRefreshTableViewDelegate>)aPullingDelegate {
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.pullingDelegate = aPullingDelegate;
    }
    return self;
}

- (void)setReachedTheEnd:(BOOL)reachedTheEnd{
    _reachedTheEnd = reachedTheEnd;
    if (_reachedTheEnd){
        _footerView.state = kPRStateHitTheEnd;
    } else {
        _footerView.state = kPRStateNormal;
    }
}

- (void)setHeaderOnly:(BOOL)headerOnly{
    _headerOnly = headerOnly;
    _footerView.hidden = _headerOnly;
}

#pragma mark - Scroll methods

- (void)scrollToNextPage {
    float h = self.frame.size.height;
    float y = self.contentOffset.y + h;
    y = y > self.contentSize.height ? self.contentSize.height : y;
    
//    [UIView animateWithDuration:.4 animations:^{
//        self.contentOffset = CGPointMake(0, y);
//    }];
//    NSIndexPath *ip = [NSIndexPath indexPathForRow:_bottomRow inSection:0];
//    [self scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    
    [UIView animateWithDuration:.7f 
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut 
                     animations:^{
                        self.contentOffset = CGPointMake(0, y);  
                     }
                     completion:^(BOOL bl){
                     }];
}

- (void)tableViewDidScroll:(UIScrollView *)scrollView {

    if (_headerView.state == kPRStateLoading || _footerView.state == kPRStateLoading) {
        return;
    }

    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.frame.size;
    CGSize contentSize = scrollView.contentSize;
 
    float yMargin = offset.y + size.height - contentSize.height;
    if (offset.y < -kPROffsetY) {   //header totally appeard
         _headerView.state = kPRStatePulling;
    } else if (offset.y > -kPROffsetY && offset.y < 0){ //header part appeared
        _headerView.state = kPRStateNormal;
        
    } else if ( yMargin > kPROffsetY){  //footer totally appeared
        if (_footerView.state != kPRStateHitTheEnd) {
            _footerView.state = kPRStatePulling;
        }
    } else if ( yMargin < kPROffsetY && yMargin > 0) {//footer part appeared
        if (_footerView.state != kPRStateHitTheEnd) {
            _footerView.state = kPRStateNormal;
        }
    }
}

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView {
    
//    CGPoint offset = scrollView.contentOffset;
//    CGSize size = scrollView.frame.size;
//    CGSize contentSize = scrollView.contentSize;
    if (_headerView.state == kPRStateLoading || _footerView.state == kPRStateLoading) {
        return;
    }
    if (_headerView.state == kPRStatePulling) {
//    if (offset.y < -kPROffsetY) {
        _isFooterInAction = NO;
        _headerView.state = kPRStateLoading;
        
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(kPROffsetY, 0, 0, 0);
        }];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartRefreshing:)]) {
            [_pullingDelegate pullingTableViewDidStartRefreshing:self];
        }
    } else if (_footerView.state == kPRStatePulling) {
//    } else  if (offset.y + size.height - contentSize.height > kPROffsetY){
        if (self.reachedTheEnd || self.headerOnly) {
            return;
        }
        _isFooterInAction = YES;
        _footerView.state = kPRStateLoading;
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, kPROffsetY, 0);
        }];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartLoading:)]) {
            [_pullingDelegate pullingTableViewDidStartLoading:self];
        }
    }
}

- (void)tableViewDidFinishedLoading {
    [self tableViewDidFinishedLoadingWithMessage:nil];  
}

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg{

    //    if (_headerView.state == kPRStateLoading) {
    if (_headerView.loading) {
        _headerView.loading = NO;
        [_headerView setState:kPRStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewRefreshingFinishedDate)]) {
            date = [_pullingDelegate pullingTableViewRefreshingFinishedDate];
        }
        [_headerView updateRefreshDate:date];
        [UIView animateWithDuration:kPRAnimationDuration*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL bl){
            if (msg != nil && ![msg isEqualToString:@""]) {
                [self flashMessage:msg];
            }
        }];
    }
    //    if (_footerView.state == kPRStateLoading) {
    else if (_footerView.loading) {
        _footerView.loading = NO;
        [_footerView setState:kPRStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(pullingTableViewLoadingFinishedDate)]) {
            date = [_pullingDelegate pullingTableViewRefreshingFinishedDate];
        }
        [_footerView updateRefreshDate:date];
        
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } completion:^(BOOL bl){
            if (msg != nil && ![msg isEqualToString:@""]) {
                [self flashMessage:msg];
            }
        }];
    }
}

- (void)flashMessage:(NSString *)msg{
    //Show message
    __block CGRect rect = CGRectMake(0, self.contentOffset.y - 20, self.bounds.size.width, 20);
    
    if (_msgLabel == nil) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.frame = rect;
        _msgLabel.font = [UIFont systemFontOfSize:14.f];
        _msgLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _msgLabel.backgroundColor = [UIColor orangeColor];
        _msgLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_msgLabel];    
    }
    _msgLabel.text = msg;
    
    rect.origin.y += 20;
    [UIView animateWithDuration:.4f animations:^{
        _msgLabel.frame = rect;
    } completion:^(BOOL finished){
        rect.origin.y -= 20;
        [UIView animateWithDuration:.4f delay:1.2f options:UIViewAnimationOptionCurveLinear animations:^{
            _msgLabel.frame = rect;
        } completion:^(BOOL finished){
            [_msgLabel removeFromSuperview];
            _msgLabel = nil;            
        }];
    }];
}

- (void)launchRefreshing {
    [self setContentOffset:CGPointMake(0,0) animated:NO];
    [UIView animateWithDuration:kPRAnimationDuration animations:^{
        self.contentOffset = CGPointMake(0, -kPROffsetY-1);
    } completion:^(BOOL bl){
        [self tableViewDidEndDragging:self];
    }];
}

#pragma mark - 

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    CGRect frame = _footerView.frame;
    CGSize contentSize = self.contentSize;
    frame.origin.y = contentSize.height < self.frame.size.height ? self.frame.size.height : contentSize.height;
    _footerView.frame = frame;
    if (self.autoScrollToNextPage && _isFooterInAction) {
        [self scrollToNextPage];
        _isFooterInAction = NO;
    } else if (_isFooterInAction) {
        CGPoint offset = self.contentOffset;
        offset.y += 44.f;
        self.contentOffset = offset;
    }

    
}








- (void)openFolderAtIndexPath:(NSIndexPath *)indexPath
              WithContentView:(UIView *)subClassContentView
                    openBlock:(FolderOpenBlock)openBlock 
                   closeBlock:(FolderCloseBlock)closeBlock
              completionBlock:(FolderCompletionBlock)completionBlock
{
    // 
    self.subClassContentView = subClassContentView;
    self.openBlock = openBlock;
    self.completionBlock = completionBlock;
    self.closing = NO;
    
    // 位置和高度参数
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    CGFloat deltaY = self.contentOffset.y;
    CGFloat positionX;
    
    // 小三角的位置x坐标
    if ([self.folderDelegate respondsToSelector:@selector(tableView:xForRowAtIndexPath:)]) {
        positionX = [self.folderDelegate tableView:self xForRowAtIndexPath:indexPath];
    } else {
        positionX = 40;
    }
    
    NSLog(@"y = %f, height = %f",cell.frame.origin.y,cell.frame.size.height);
    
    CGPoint position = CGPointMake(positionX, cell.frame.origin.y+cell.frame.size.height - 1);
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    if (position.y - deltaY > height) {
        self.offsetY = position.y - height - deltaY;
    } else {
        self.offsetY = 0.0f;
    }
    
    // 重置contentoffset  这里要动画吗？
    self.oldContentOffset = self.contentOffset;
    self.contentOffset = CGPointMake(0, self.offsetY + deltaY);
    

    deltaY = self.contentOffset.y;
    
    UIImage *screenshot = [self screenshotWithOffset:-deltaY];
    
    // 配置上下遮罩
    CGRect upperRect = CGRectMake(0, deltaY, width, position.y - deltaY);
    CGRect lowerRect = CGRectMake(0, position.y, width, height + deltaY - position.y);
    
    self.top = [self buttonForRect:upperRect
                            screen:screenshot
                          position:position
                               top:YES
                       transparent:NO];
    self.bottom = [self buttonForRect:lowerRect
                               screen:screenshot
                             position:position
                                  top:NO
                          transparent:NO];
    
    NSLog(@" top frame = %@, bottom frame = %@",self.top,self.bottom);
    
    // 绑定关闭动作
    [self.top addTarget:self action:@selector(performClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom addTarget:self action:@selector(performClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.top.cover addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)] autorelease]];
    [self.bottom.cover addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)] autorelease]];
    
    [self addSubview:subClassContentView];
    [self addSubview:self.top];
    [self addSubview:self.bottom];
    
    CGRect viewFrame = subClassContentView.frame;
    if (position.y - deltaY + viewFrame.size.height > height) {
        viewFrame.origin.y = height + deltaY - viewFrame.size.height;
    } else {
        viewFrame.origin.y = position.y;
    }
    subClassContentView.frame = viewFrame;
    
    // 配置打开动画
    CGFloat contentHeight = subClassContentView.frame.size.height;
    CFTimeInterval duration = 0.4f;
    CGPoint toTopPoint;
    CABasicAnimation *moveTop = [CABasicAnimation animationWithKeyPath:@"position"];
    moveTop.duration = duration;
    moveTop.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    self.oldTopPoint = self.top.layer.position;
    CGFloat newTopY;
    if (self.top.frame.origin.y + self.top.frame.size.height > subClassContentView.frame.origin.y) {
        newTopY = self.oldTopPoint.y + subClassContentView.frame.origin.y - (self.top.frame.origin.y + self.top.frame.size.height);
    } else {
        newTopY = self.oldTopPoint.y;
    }
    toTopPoint = (CGPoint){ self.oldTopPoint.x, newTopY};
    moveTop.fromValue = [NSValue valueWithCGPoint:self.oldTopPoint];
    moveTop.toValue = [NSValue valueWithCGPoint:toTopPoint];
    
    
    CGPoint toBottomPoint;
    CABasicAnimation *moveBottom = [CABasicAnimation animationWithKeyPath:@"position"];
    moveBottom.duration = duration;
    moveBottom.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    self.oldBottomPoint = self.bottom.layer.position;
    CGFloat newBottomY;
    if (subClassContentView.frame.origin.y + subClassContentView.frame.size.height > height + deltaY ) {
        newBottomY = self.oldBottomPoint.y + (subClassContentView.frame.origin.y + contentHeight) - deltaY - height;
    } else {
        newBottomY = self.oldBottomPoint.y + contentHeight;
    }
    toBottomPoint = (CGPoint){ self.oldBottomPoint.x, newBottomY};
    moveBottom.fromValue = [NSValue valueWithCGPoint:self.oldBottomPoint];
    moveBottom.toValue = [NSValue valueWithCGPoint:toBottomPoint];
    
    // 打开动画
    [self.top.layer addAnimation:moveTop forKey:@"t1"];
    [self.bottom.layer addAnimation:moveBottom forKey:@"t2"];
    
    // 透明变半透明
    [UIView animateWithDuration:duration animations:^{
        self.top.cover.alpha = COVERALPHA;
        self.bottom.cover.alpha = COVERALPHA;
    }];
    
    if (openBlock) openBlock(self.subClassContentView, duration, [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]);
    
    [self.top.layer setPosition:toTopPoint];
    [self.bottom.layer setPosition:toBottomPoint];
    
}

-(void)tapGestureAction:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged || 
        gesture.state == UIGestureRecognizerStateEnded) {
        if (gesture.numberOfTapsRequired > 0) {
            [self performClose:gesture];
        }
    }
}

- (void)performClose:(id)sender {
    if (self.closing) {
        return;
    }else {
        self.closing = YES;
    }
    
    // 配置关闭动画
    CFTimeInterval duration = 0.4f;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *moveTop = [CABasicAnimation animationWithKeyPath:@"position"];
    [moveTop setValue:@"close" forKey:@"animationType"];
    [moveTop setDelegate:self];
    [moveTop setTimingFunction:timingFunction];
    moveTop.fromValue = [NSValue valueWithCGPoint:[[self.top.layer presentationLayer] position]];
    moveTop.toValue = [NSValue valueWithCGPoint:self.oldTopPoint];
    moveTop.duration = duration;
    
    
    CABasicAnimation *moveBottom = [CABasicAnimation animationWithKeyPath:@"position"];
    [moveBottom setValue:@"close" forKey:@"animationType"];
    [moveBottom setDelegate:self];
    [moveBottom setTimingFunction:timingFunction];
    moveBottom.fromValue = [NSValue valueWithCGPoint:[[self.bottom.layer presentationLayer] position]];
    moveBottom.toValue = [NSValue valueWithCGPoint:self.oldBottomPoint];
    moveBottom.duration = duration;
    
    // 关闭动画 
    [self.top.layer addAnimation:moveTop forKey:@"b1"];
    [self.bottom.layer addAnimation:moveBottom forKey:@"b2"];
    
    // 半透明变透明
    [UIView animateWithDuration:duration animations:^{
        
        self.contentOffset = self.oldContentOffset;
        self.top.cover.alpha = 0;
        self.bottom.cover.alpha = 0;
        
    }];
    
    if (self.closeBlock) self.closeBlock(self.subClassContentView, duration, timingFunction);
    
    [self.top.layer setPosition:self.oldTopPoint];
    [self.bottom.layer setPosition:self.oldBottomPoint];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if ([[anim valueForKey:@"animationType"] isEqualToString:@"close"]) {        
        [self.top removeFromSuperview];
        [self.bottom removeFromSuperview];
        [self.subClassContentView removeFromSuperview];
        
        self.top = nil;
        self.bottom = nil;
        self.subClassContentView = nil;
        
        if (self.completionBlock) self.completionBlock();
        //        sharedInstance = nil;
    }
    
}

- (FolderCoverView *)buttonForRect:(CGRect)aRect
                            screen:(UIImage *)screen
                          position:(CGPoint)position
                               top:(BOOL)isTop
                       transparent:(BOOL)isTransparent {
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat width = aRect.size.width;
    CGFloat height = aRect.size.height;
    CGPoint origin = aRect.origin;
    CGFloat deltaY = self.contentOffset.y;
    
    CGRect scaledRect = CGRectMake(origin.x*scale, origin.y*scale - deltaY*scale, width*scale, height*scale);
    CGImageRef ref1 = CGImageCreateWithImageInRect([screen CGImage], scaledRect);
    
    
    
    
    FolderCoverView *button;
    if (isTop) {
        button = [[[FolderCoverView alloc] initWithFrame:aRect offset:self.rowHeight] autorelease];
        
        UIImageView *notch = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tip.png"]] autorelease];
        notch.center = CGPointMake(position.x, height - 2);
        [button addSubview:notch];
        notch.alpha = 0.3;
        
        UIImage* image = [UIImage imageWithCGImage:ref1];
        
        NSData* data = UIImagePNGRepresentation(image);
        NSString* path = [[DataProcess getImageFilePath] stringByAppendingPathComponent:@"daaaa.png"];
        
        [DataProcess writeData:data FileNameAndPath:path];
        
        
    } else {
        button = [[[FolderCoverView alloc] initWithFrame:aRect offset:0] autorelease];
        
        UIImage* image = [UIImage imageWithCGImage:ref1];
        
        NSData* data = UIImagePNGRepresentation(image);
        NSString* path = [[DataProcess getImageFilePath] stringByAppendingPathComponent:@"bbbbb.png"];
        
        [DataProcess writeData:data FileNameAndPath:path];
        
    }
    
    [button setIsTopView:isTop];
    
    button.position = position;
    button.layer.contentsScale = scale;
    button.layer.contents = isTransparent ? nil : (id)(ref1);
    button.layer.contentsGravity = kCAGravityCenter;
    CGImageRelease(ref1);
    
    return button;
}





@end
