//
//  BN_FilterMenu.m
//  LrdSuperMenu
//
//  Created by newman on 16/10/29.
//  Copyright © 2016年 键盘上的舞者. All rights reserved.
//

#import "BN_FilterMenu.h"

#define BN_FilterSeparatorColor [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1]
#define kSeparatorColor [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1]

//- (void)getCellInBlock:(void (^)(NSInteger index, NSIndexPath *indexPath))block;
//- (void)getSectionInBlock:(void (^)(NSInteger index, NSInteger section))block;
//- (void)heightForHeaderInSectionBlock:(void (^)(NSInteger index, NSInteger section))block;
//- (void)heightForRowInBlock:(void (^)(NSInteger index, NSIndexPath *indexPath))block;

@interface BN_FilterMenu()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) int showIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backGroundView;

@property(nonatomic, copy) NSArray *(^menuDataArrayBlock)(NSInteger index, NSString *title);
@property(nonatomic, copy) UITableViewCell *(^cellBlock)(NSInteger index, NSIndexPath *indexPath, id data);
@property(nonatomic, copy) CGFloat (^heightForRowBlock)(NSInteger index, NSIndexPath *indexPath, id data);
@property(nonatomic, copy) void (^didDeselectRowBlock)(NSInteger index, NSIndexPath *indexPath, id data);

@end

@implementation BN_FilterMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildControls];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildControls];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self buildControls];
    }
    return self;
}

- (void)buildControls
{
    self.fontSize = 14;
    self.textColor = [UIColor blackColor];
    self.selectedTextColor = [UIColor orangeColor];
    self.tempArray = [@[] mutableCopy];
    self.showIndex = -1;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0) style:UITableViewStylePlain];
    self.tableView.tableHeaderView = [[UIView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0,0,0,0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.bounces = NO;
    self.clipsToBounds = YES;
    self.menuArray = @[@"please set menuArray"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
    [self addGestureRecognizer:tap];
    
    _backGroundView = [[UIView alloc] init];
    _backGroundView.frame = CGRectMake(0, 0, 0, 0);
    _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0];
    self.backGroundView.alpha = 0;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTapped:)];
    [_backGroundView addGestureRecognizer:backTap];
    
    UITapGestureRecognizer *menuTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
    [self addGestureRecognizer:menuTapped];
}

- (void)getMenuDataArrayBlock:(NSArray* (^)(NSInteger index, NSString *title))block {
    self.menuDataArrayBlock = block;
}

- (void)getCellInBlock:(UITableViewCell* (^)(NSInteger index, NSIndexPath *indexPath, id data))block {
    self.cellBlock = block;
}

- (void)heightForRowInBlock:(CGFloat (^)(NSInteger index, NSIndexPath *indexPath, id data))block {
    self.heightForRowBlock = block;
}

- (void)didDeselectRowAtIndexPathBlock:(void (^)(NSInteger index, NSIndexPath *indexPath, id data))block {
    self.didDeselectRowBlock = block;
}

- (void)closeMenu {
    self.showIndex = -1;
    [self.tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        CAShapeLayer *shapeLayer = dic[@"sharpLayer"];
        [self animateIndicator:shapeLayer reverse:0];
    }];
    [self animateTableView];
}

- (void)backTapped:(UITapGestureRecognizer *)gesture {
    self.showIndex = -1;
    [self.tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        CAShapeLayer *shapeLayer = dic[@"sharpLayer"];
        [self animateIndicator:shapeLayer reverse:0];
    }];
    [self animateTableView];
}

- (void)menuTapped:(UITapGestureRecognizer *)gesture {
    
    CGPoint touchPoint = [gesture locationInView:self];
    NSInteger touchIndex = touchPoint.x / (self.frame.size.width / self.menuArray.count);
    
    NSLog(@"点击了 %ld",touchIndex);
    if (self.showIndex == touchIndex) {
        touchIndex = -1;
        self.showIndex = -1;
    } else {
        self.showIndex = (int)touchIndex;
        self.dataArray = self.menuDataArrayBlock == nil ?@[@"no data"] :self.menuDataArrayBlock(self.showIndex,self.menuArray[self.showIndex])?:@[@"no data"];
    }
    
    NSLog(@"%f",self.tableView.contentSize.height);
    
    [self.tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        CAShapeLayer *shapeLayer = dic[@"sharpLayer"];
        [self animateIndicator:shapeLayer reverse:idx == self.showIndex];
    }];
    [self animateTableView];
}

- (void)setMenuArray:(NSArray<NSString *> *)menuArray
{
    _menuArray = menuArray;
    [self.tempArray removeAllObjects];
    
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [obj removeFromSuperlayer];
        });
        
    }];
    
    [self.menuArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint positionForTitle = CGPointMake((idx + 0.5) * self.frame.size.width / self.menuArray.count , self.frame.size.height / 2);
        CATextLayer *textLayer = [self createTitleLayerWithString:obj position:positionForTitle color:self.textColor];
        [self.layer addSublayer:textLayer];
        
        CGPoint positionForSharp = CGPointMake((((idx + 1.0) * self.frame.size.width) / self.menuArray.count) - 10 , self.frame.size.height / 2);
        CAShapeLayer *sharpLayer = [self createIndicatorWithPosition:positionForSharp color: self.textColor];
        [self.layer addSublayer:sharpLayer];
        
        if (idx != self.menuArray.count - 1) {
            CGPoint positionForSeparator = CGPointMake(((idx + 1.0) * self.frame.size.width) / self.menuArray.count , self.frame.size.height / 2);
            CAShapeLayer *separatorLayer = [self createSeparatorWithPosition:positionForSeparator color:BN_FilterSeparatorColor];
            [self.layer addSublayer:separatorLayer];
        }
        
        NSDictionary *dic = @{@"titleLayer":textLayer,@"sharpLayer":sharpLayer};
        [self.tempArray addObject:dic];
    }];
    
    CAShapeLayer *lineLayer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.frame.size.width,0)];
    [path closePath];
    lineLayer.path = path.CGPath;
    lineLayer.lineWidth = 0.5;
    lineLayer.strokeColor = kSeparatorColor.CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    CGPathRef bound = CGPathCreateCopyByStrokingPath(lineLayer.path, nil, lineLayer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, lineLayer.miterLimit);
    lineLayer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    lineLayer.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height);
    [self.layer addSublayer:lineLayer];
}

#pragma mark - 绘图
//标题
- (CATextLayer *)createTitleLayerWithString:(NSString *)string position:(CGPoint)position color:(UIColor *)color {
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / self.menuArray.count) - 25) ? size.width : self.frame.size.width / self.menuArray.count - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = _fontSize;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.truncationMode = kCATruncationEnd;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = position;
    
    return layer;
}

//指示器
- (CAShapeLayer *)createIndicatorWithPosition:(CGPoint)position color:(UIColor *)color {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = color.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position = position;
    
    return layer;
}
//分隔线
- (CAShapeLayer *)createSeparatorWithPosition:(CGPoint)position color:(UIColor *)color {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,0)];
    [path addLineToPoint:CGPointMake(160, 20)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position = position;
    return layer;
}

//计算String的宽度
- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:_fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return CGSizeMake(ceilf(size.width)+2, size.height);
}

#pragma mark - 动画
- (void)animateIndicator:(CAShapeLayer *)indicator reverse:(BOOL)reverse {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = reverse ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim forKey:anim.keyPath];
        [indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    if (reverse) {
        indicator.fillColor = self.selectedTextColor.CGColor;
    }else {
        indicator.fillColor = self.textColor.CGColor;
    }
}

- (void)animateTableView {
    if (self.showIndex == -1) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.frame = CGRectMake(self.frame.origin.x,
                                              self.frame.origin.y + self.frame.size.height,
                                              self.frame.size.width,
                                              0);
            self.backGroundView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.tableView removeFromSuperview];
            [self.backGroundView removeFromSuperview];
        }];
        
    } else {
        [self.tableView removeFromSuperview];
        self.tableView.frame = CGRectMake(self.frame.origin.x,
                                          self.frame.origin.y + self.frame.size.height,
                                          self.frame.size.width,
                                          0);
        self.backGroundView.frame = CGRectMake(self.frame.origin.x,
                                               self.frame.origin.y + self.frame.size.height,
                                               self.frame.size.width,
                                               self.superview.frame.size.height - self.frame.origin.y - self.frame.size.height);

        [self.superview addSubview:self.backGroundView];
        [self.superview addSubview:self.tableView];
        [self.tableView reloadData];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGFloat maxHeight = self.superview.frame.size.height - self.frame.origin.y - self.frame.size.height - 35;
            
            self.tableView.frame = CGRectMake(self.frame.origin.x,
                                              self.frame.origin.y + self.frame.size.height,
                                              self.frame.size.width,
                                              MIN(self.tableView.contentSize.height, maxHeight));
            self.backGroundView.alpha = 0.25;
        } completion:^(BOOL finished) {
            ;
        }];
        
    }
    
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.bottomView?:[[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.bottomView != nil) {
        return self.bottomView.frame.size.height;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CGFloat height = self.heightForRowBlock == nil ? 0 :self.heightForRowBlock(self.showIndex,indexPath,self.dataArray[indexPath.row]);
    return height?:38;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *tableViewCell = self.cellBlock == nil ? nil:self.cellBlock(self.showIndex,indexPath,self.dataArray[indexPath.row]);
    
    if (tableViewCell == nil) {
        static NSString *TableSampleIdentifier = @"BN_FilterMenuTableViewCell";
        tableViewCell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        if (tableViewCell == nil) {
            tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
        }
        tableViewCell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
    }
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didDeselectRowBlock != nil) {
        self.didDeselectRowBlock(self.showIndex,indexPath,self.dataArray[indexPath.row]);
    }
}

@end
