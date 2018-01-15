//
//  ZDTableViewCellAccessoryProtocol.h
//  CodeGeass
//
//  Created by ec on 2018/1/10.
//  Copyright © 2018年 Code Geass. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZDTableViewCellAccessoryProtocol <NSObject>

@optional
@property (nonatomic, assign) BOOL showsIndicator;///< right show '>'
@property (nonatomic, assign) BOOL showsCheckmark;///< right show '✅'

@end
