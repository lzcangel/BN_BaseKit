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

@interface BN_SubFilter()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong)id supData;
@property (nonatomic, assign)NSInteger supIndex;

@property(nonatomic, copy) NSArray *(^rowDataArrayBlock)(NSInteger SupIndex, id SupData);

@property(nonatomic, copy) UITableViewCell *(^cellBlock)(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data);
@property(nonatomic, copy) CGFloat (^heightForRowBlock)(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data);

@property(nonatomic, copy) void (^didDeselectRowBlock)(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data);

@end

@implementation BN_SubFilter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:self.bounds];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.bounces = NO;
        [self addSubview:self.tableView];
        
        self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
        self.line.backgroundColor = ColorBtnYellow;
        [self addSubview:self.line];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.tableView.frame = self.bounds;
    self.line.frame = CGRectMake(0, 0, self.frame.size.width, 2);
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void)getMenuDataRowArrayInBlock:(NSArray* (^)(NSInteger SupIndex, id SupData))block
{
    self.rowDataArrayBlock = block;
}
- (void)getCellInBlock:(UITableViewCell* (^)(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data))block
{
    self.cellBlock = block;
}
- (void)heightForRowInBlock:(CGFloat (^)(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data))block
{
    self.heightForRowBlock = block;
}
- (void)didDeselectRowAtIndexPathBlock:(void (^)(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data))block
{
    self.didDeselectRowBlock = block;
}

- (void)setSupData:(id)supData supIndex:(NSInteger)supIndex
{
    _supData = supData;
    _supIndex = supIndex;
    self.dataArray = self.rowDataArrayBlock(supIndex,supData);
    [self reloadData];
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    CGFloat height = self.heightForRowBlock == nil ? 0 :self.heightForRowBlock(self.supIndex,indexPath,self.supData,self.dataArray[indexPath.row]);
    return height?:38;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *tableViewCell = self.cellBlock == nil ? nil:self.cellBlock(self.supIndex,indexPath,self.supData,self.dataArray[indexPath.row]);
    
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
        self.didDeselectRowBlock(self.supIndex,indexPath,self.supData,self.dataArray[indexPath.row]);
    }
}



@end

@interface BN_FilterMenu()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic, strong) NSArray *dataKeyArray;
@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, assign) int showIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UIView *bottomView;

@property(nonatomic, copy) NSArray *(^rowDataArrayBlock)(NSInteger index, NSString *title, NSInteger section);
@property(nonatomic, copy) NSArray *(^sectionDataArrayBlock)(NSInteger index, NSString *title);
@property(nonatomic, copy) UIView *(^bottomViewBlock)(NSInteger index, NSString *title);
@property(nonatomic, copy) BOOL (^haveSubFilterBlock)(NSInteger index, NSString *title);

@property(nonatomic, copy) UITableViewCell *(^cellBlock)(NSInteger index, NSIndexPath *indexPath, id data);
@property(nonatomic, copy) CGFloat (^heightForRowBlock)(NSInteger index, NSIndexPath *indexPath, id data);

@property(nonatomic, copy) UIView *(^sectionBlock)(NSInteger index, NSInteger section, id data);
@property(nonatomic, copy) CGFloat (^heightForSectionBlock)(NSInteger index, NSInteger section, id data);

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
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    self.backView.clipsToBounds = YES;
    [self.backView addSubview:self.tableView];
    
    self.subFilterView = [[BN_SubFilter alloc]init];
    
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

- (void)getMenuDataRowArrayInBlock:(NSArray* (^)(NSInteger index, NSString *title, NSInteger section))block
{
    self.rowDataArrayBlock = block;
}

- (void)getMenuDataSectionArrayInBlock:(NSArray* (^)(NSInteger index, NSString *title))block
{
    self.sectionDataArrayBlock = block;
}

- (void)getCellInBlock:(UITableViewCell* (^)(NSInteger index, NSIndexPath *indexPath, id data))block
{
    self.cellBlock = block;
}

- (void)heightForRowInBlock:(CGFloat (^)(NSInteger index, NSIndexPath *indexPath, id data))block
{
    self.heightForRowBlock = block;
}

- (void)getSectionInBlock:(UIView* (^)(NSInteger index, NSInteger section, id data))block
{
    self.sectionBlock = block;
}

- (void)heightForSectionInBlock:(CGFloat (^)(NSInteger index, NSInteger section, id data))block
{
    self.heightForSectionBlock = block;
}

- (void)didDeselectRowAtIndexPathBlock:(void (^)(NSInteger index, NSIndexPath *indexPath, id data))block
{
    self.didDeselectRowBlock = block;
}

- (void)getMenuBottomViewInBlock:(UIView* (^)(NSInteger index, NSString *title))block
{
    self.bottomViewBlock = block;
}

- (void)haveSubFilterInBlock:(BOOL (^)(NSInteger index, NSString *title))block
{
    self.haveSubFilterBlock = block;
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
        self.dataKeyArray = self.sectionDataArrayBlock(self.showIndex,self.menuArray[self.showIndex]);
        self.dataDic = [[NSMutableDictionary alloc]init];
        [self.dataKeyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            self.dataDic[obj] = [@[] mutableCopy];
        }];
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

- (void)reloadData
{
    self.dataDic = [[NSMutableDictionary alloc]init];
    [self.dataKeyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.dataDic[obj] = [@[] mutableCopy];
    }];
    [self.tableView reloadData];
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
            self.backView.frame = CGRectMake(self.frame.origin.x,
                                              self.frame.origin.y + self.frame.size.height,
                                              self.frame.size.width,
                                              0);
            self.backGroundView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.backView removeFromSuperview];
            [self.backGroundView removeFromSuperview];
        }];
        
    } else {
        [self.backView removeFromSuperview];
        self.backView.frame = CGRectMake(self.frame.origin.x,
                                          self.frame.origin.y + self.frame.size.height,
                                          self.frame.size.width,
                                          0);
        self.backGroundView.frame = CGRectMake(self.frame.origin.x,
                                               self.frame.origin.y + self.frame.size.height,
                                               self.frame.size.width,
                                               self.superview.frame.size.height - self.frame.origin.y - self.frame.size.height);

        [self.superview addSubview:self.backGroundView];
        [self.superview addSubview:self.backView];
        [self.tableView reloadData];
        
        CGFloat maxHeight = self.superview.frame.size.height - self.frame.origin.y - self.frame.size.height - 35;
        
        [self.bottomView removeFromSuperview];
        self.bottomView = self.bottomViewBlock(self.showIndex,self.menuArray[self.showIndex])?:[[UIView alloc]init];
        self.tableView.frame = CGRectMake(0,
                                          0,
                                          self.frame.size.width,
                                          MIN(self.tableView.contentSize.height, maxHeight - self.bottomView.frame.size.height));
        self.bottomView.frame = CGRectMake(0,
                                      self.tableView.frame.size.height,
                                      self.frame.size.width,
                                      self.bottomView.frame.size.height);
        [self.backView addSubview:self.tableView];
        [self.backView addSubview:self.bottomView];
        [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
        
        //判断是否有子项目
        if (self.haveSubFilterBlock != nil && self.haveSubFilterBlock(self.showIndex,self.menuArray[self.showIndex]))
        {
            self.subFilterView.frame = CGRectMake(self.frame.size.width/2.0,
                                                  self.heightForSectionBlock(self.showIndex,0,self.dataKeyArray[0]),
                                                  self.frame.size.width/2.0,
                                                  self.tableView.frame.size.height - self.heightForSectionBlock(self.showIndex,0,self.dataKeyArray[0]));
            self.subFilterView.supIndex = 0;
            NSArray *array = [self getRowArrayInSection:0];
            [self.backView addSubview:self.subFilterView];
            [self.subFilterView setSupData:array.count > 0 ? array[0] : nil supIndex:0];
        }
        else
        {
            [self.subFilterView removeFromSuperview];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.backView.frame = CGRectMake(self.frame.origin.x,
                                              self.frame.origin.y + self.frame.size.height,
                                              self.frame.size.width,
                                              MIN(self.tableView.contentSize.height + self.bottomView.frame.size.height, maxHeight));
            self.backGroundView.alpha = 0.25;
        } completion:^(BOOL finished) {
            ;
        }];
        
    }
    
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataKeyArray.count;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = self.sectionBlock == nil ? nil : self.sectionBlock(self.showIndex,section,self.dataKeyArray[section]);
    return view?:[[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = self.heightForSectionBlock == nil ? 0 :self.heightForSectionBlock(self.showIndex,section,self.dataKeyArray[section]);
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSArray *array = [self getRowArrayInSection:indexPath.section];
    CGFloat height = self.heightForRowBlock == nil ? 0 :self.heightForRowBlock(self.showIndex,indexPath,array[indexPath.row]);
    return height?:38;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [self getRowArrayInSection:section];
    return array.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [self getRowArrayInSection:indexPath.section];
    UITableViewCell *tableViewCell = self.cellBlock == nil ? nil:self.cellBlock(self.showIndex,indexPath,array[indexPath.row]);
    
    if (tableViewCell == nil) {
        static NSString *TableSampleIdentifier = @"BN_FilterMenuTableViewCell";
        tableViewCell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        if (tableViewCell == nil) {
            tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
            tableViewCell.separatorInset = UIEdgeInsetsMake(0, 0, 0, tableViewCell.bounds.size.width);
            tableViewCell.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
        }
        tableViewCell.textLabel.text = [NSString stringWithFormat:@"%@",array[indexPath.row]];
    }
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = [self getRowArrayInSection:indexPath.section];
    if (self.didDeselectRowBlock != nil) {
        self.didDeselectRowBlock(self.showIndex,indexPath,array[indexPath.row]);
    }
    if (self.haveSubFilterBlock != nil && self.showIndex >= 0 && self.haveSubFilterBlock(self.showIndex,self.menuArray[self.showIndex]))
    {
        [self.subFilterView setSupData:array[indexPath.row] supIndex:indexPath.row];
    }
}

- (NSArray *)getRowArrayInSection:(NSInteger)section
{
    NSArray *array = self.dataDic[self.dataKeyArray[section]];
    if (array.count == 0)
    {
        array = self.rowDataArrayBlock(self.showIndex,self.menuArray[self.showIndex],section);
        self.dataDic[self.dataKeyArray[section]] = array;
    }
    return array;
}

@end
