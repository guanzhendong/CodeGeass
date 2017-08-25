//
//  ZDRLMMigrationManager.h
//  CodeGeass
//
//  Created by ec on 2017/2/7.
//  Copyright © 2017年 Code Geass. All rights reserved.
//

/*
 * realm 数据库迁移管理类 ，感觉realm对于数据迁移很不友好，随便在模型里面添加一个属性如果没有相应的迁移代码就会直接崩溃。
 */

#import <Foundation/Foundation.h>

@interface ZDRLMMigrationManager : NSObject

SINGLETON_INTERFACE(Manager)

- (void)migration;

@end
