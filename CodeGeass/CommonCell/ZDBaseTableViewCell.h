//
//  ZDBaseTableViewCell.h
//  CodeGeass
//
//  Created by ec on 2017/11/27.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDTableViewCellAccessoryProtocol.h"

@interface ZDBaseTableViewCell : UITableViewCell <ZDTableViewCellAccessoryProtocol>

@property (nonatomic, assign) BOOL showsSeparator;// default is YES
@property (nonatomic, assign) CGFloat separatorLeading;// default is 15.f

@end
