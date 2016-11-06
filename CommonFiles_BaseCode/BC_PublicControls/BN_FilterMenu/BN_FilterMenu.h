//
//  BN_FilterMenu.h
//  LrdSuperMenu
//
//  Created by newman on 16/10/29.
//  Copyright © 2016年 键盘上的舞者. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_FilterMenu : UIView

@property (nonatomic, assign) NSInteger fontSize;

@property (nonatomic, strong) NSArray<NSString*>* menuArray;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIView *bottomView;

- (void)getMenuDataArrayBlock:(NSArray* (^)(NSInteger index, NSString *title))block;
- (void)getCellInBlock:(UITableViewCell* (^)(NSInteger index, NSIndexPath *indexPath, id data))block;
- (void)heightForRowInBlock:(CGFloat (^)(NSInteger index, NSIndexPath *indexPath, id data))block;
- (void)didDeselectRowAtIndexPathBlock:(void (^)(NSInteger index, NSIndexPath *indexPath, id data))block;

- (void)closeMenu;

@end
