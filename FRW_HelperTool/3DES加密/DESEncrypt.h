//
//  DESEncrypt.h
//  FaRongWangWithRongYun
//
//  Created by panda誌 on 17/1/4.
//  Copyright © 2017年 RongXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESEncrypt : NSObject
/*
** 3DES+Base64加密
 */
// 加密方法 (gkey: 加密key, gIv:和后端统一的常量)
+ (NSString*)encrypt:(NSString*)plainText gkey:(NSString *)gkey gIv:(NSString *)gIv;
// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText gkey:(NSString *)gkey gIv:(NSString *)gIv;

@end
