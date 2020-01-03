//
//  HBRSAHandler.h
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 15/10/19.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    KeyTypePublic = 0,
    KeyTypePrivate
}KeyType;

@interface HBRSAHandler : NSObject

- (BOOL)importKeyWithType:(KeyType)type andPath:(NSString*)path;
- (BOOL)importKeyWithType:(KeyType)type andkeyString:(NSString *)keyString;

//验证签名 Sha1 + RSA
- (BOOL)verifyString:(NSString *)string withSign:(NSString *)signString;

- (NSString *)signString:(NSString *)string;


//加密方法
- (NSString *) encryptWithPublicKey:(NSString*)content;
//解密方法
- (NSString *) decryptWithPrivatecKey:(NSString*)content;

@end
