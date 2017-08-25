////
////  ZDRLMMigrationManager.m
////  CodeGeass
////
////  Created by ec on 2017/2/7.
////  Copyright © 2017年 Code Geass. All rights reserved.
////
//
//#import "ZDRLMMigrationManager.h"
//#import "Realm/Realm.h"
//
//@implementation ZDRLMMigrationManager
//
//SINGLETON_IMPLEMENTATION(Manager)
//
//- (void)migration {
//    // 在 [AppDelegate didFinishLaunchingWithOptions:] 中进行配置
//    
//    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
//    // 设置新的架构版本。这个版本号必须高于之前所用的版本号（如果您之前从未设置过架构版本，那么这个版本号设置为 0）
//    config.schemaVersion = 1;
//    
//    // 设置闭包，这个闭包将会在打开低于上面所设置版本号的 Realm 数据库的时候被自动调用
//    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
//        // 目前我们还未进行数据迁移，因此 oldSchemaVersion == 0
//        if (oldSchemaVersion < 1) {
//            // 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
//        }
//    };
//    
//    // 告诉 Realm 为默认的 Realm 数据库使用这个新的配置对象
//    [RLMRealmConfiguration setDefaultConfiguration:config];
//    
//    // 现在我们已经告诉了 Realm 如何处理架构的变化，打开文件之后将会自动执行迁移
//    [RLMRealm defaultRealm];
//}
//
//@end
