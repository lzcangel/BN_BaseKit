//
//  BN_FilterMenu.h
//  LrdSuperMenu
//
//  Created by newman on 16/10/29.
//  Copyright © 2016年 键盘上的舞者. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BN_SubFilter : UIView

- (void)getMenuDataRowArrayInBlock:(NSArray* (^)(NSInteger SupIndex, id SupData))block;
- (void)getCellInBlock:(UITableViewCell* (^)(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data))block;
- (void)heightForRowInBlock:(CGFloat (^)(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data))block;
- (void)didDeselectRowAtIndexPathBlock:(void (^)(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data))block;

//刷新列表
- (void)reloadData;

- (void)setSupData:(id)supData supIndex:(NSInteger)supIndex;

@end


@interface BN_FilterMenu : UIView

@property (nonatomic, assign) NSInteger fontSize;

@property (nonatomic, strong) NSArray<NSString*>* menuArray;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@property (nonatomic, strong) BN_SubFilter *subFilterView;

//放入section和row的数组
- (void)getMenuDataRowArrayInBlock:(NSArray* (^)(NSInteger index, NSString *title, NSInteger section))block;
- (void)getMenuDataSectionArrayInBlock:(NSArray* (^)(NSInteger index, NSString *title))block;
- (void)getMenuBottomViewInBlock:(UIView* (^)(NSInteger index, NSString *title))block;

//设置是否有子选项 默认为空
- (void)haveSubFilterInBlock:(BOOL (^)(NSInteger index, NSString *title))block;

//设置cell 默认为高度38的原声cell
- (void)getCellInBlock:(UITableViewCell* (^)(NSInteger index, NSIndexPath *indexPath, id data))block;
- (void)heightForRowInBlock:(CGFloat (^)(NSInteger index, NSIndexPath *indexPath, id data))block;

//设置section 默认为空
- (void)getSectionInBlock:(UIView* (^)(NSInteger index, NSInteger section, id data))block;
- (void)heightForSectionInBlock:(CGFloat (^)(NSInteger index, NSInteger section, id data))block;

//设置点击回调
- (void)didDeselectRowAtIndexPathBlock:(void (^)(NSInteger index, NSIndexPath *indexPath, id data))block;

//关闭列表
- (void)closeMenu;
//刷新列表
- (void)reloadData;

@end

