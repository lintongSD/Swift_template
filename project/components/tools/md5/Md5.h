//
//  Md5.h
//  RSADemo
//
//  Created by Ebiz on 15/12/1.
//  Copyright (c) 2015年 Ebiz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Md5 : NSObject


+(NSMutableDictionary *)getSignString:(NSMutableDictionary *)requestObject;
+(NSString *)getWebMd5Data:(NSMutableDictionary *)dic customerID:(NSString *) customerID token:(NSString *) token;
+(NSString*)URLEncode:(NSString *)str;
+(BOOL)getObject:(NSDictionary *)object;

+(NSString *)getEnCryptRSAString:(NSString *)str;  //rsa加密方法
+(NSString *)getDeCryptRSAString:(NSString *)str;  //rsa解密方法



/**
 *获取字符串类型当前时间,参数为:日期格式，例如：yyyy-MM-dd or yyyy-MM-dd HH:mm:ss
 *@parem format 日期格式，例如：yyyy-MM-dd HH:mm:ss
 *@return 当前时间的字符串类型
 */
+(NSString *)getCurrentDateStringWithFormat:(NSString *)format;

/**
 *创建16位MD5加密
 *@param  需要加密的字符串
 *@return MD5 16位加密字符串
 */
+(NSString *)createMD5With16:(NSString *)str;

+(NSString *)getCurrentVersion;
+(NSArray*)orderNSArray:(NSArray*)arr;

@end
