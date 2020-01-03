//
//  Md5.m
//  RSADemo
//
//  Created by Ebiz on 15/12/1.
//  Copyright (c) 2015年 Ebiz. All rights reserved.
//

#import "Md5.h"
#import <CommonCrypto/CommonDigest.h>
#import "HBRSAHandler.h"


@implementation Md5

//rsa加签方法
+(NSMutableDictionary *)getSignString:(NSMutableDictionary *)requestObject{
    NSDate * datenow = [NSDate date];
    NSString *dateString = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    NSString *platType = @"ios";
    NSString *curVersion = [self getCurrentVersion];

    [requestObject setObject:platType forKey:@"platType"];
    [requestObject setObject:curVersion forKey:@"version"];
    [requestObject setObject:@"1" forKey:@"systemType"];
    NSString * uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
    [requestObject setObject:uuid forKey:@"uuid"];
    
    
    NSArray *keyArray = requestObject.allKeys;
    keyArray = [self orderNSArray:keyArray];
    NSString *dataStr = [NSString string];
    for (int i = 0 ; i < keyArray.count ; i++) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",keyArray[i],[requestObject objectForKey:[NSString stringWithFormat:@"%@",keyArray[i]]]];
        if (i == 0) {
            dataStr = str;
        }else{
            dataStr = [NSString stringWithFormat:@"%@&%@",dataStr,str];
        }
    }
    dataStr = [NSString stringWithFormat:@"%@&timestamp=%@",dataStr,dateString];
    
    HBRSAHandler* handler = [self creatRSA];
    NSString *signedStr = [handler signString:dataStr];
    
    [requestObject setObject:dateString forKey:@"timestamp"];
    [requestObject setObject:signedStr forKey:@"sign"];
    
     return requestObject;
}
+(NSString *)getWebMd5Data:(NSMutableDictionary *)dic customerID:(NSString *) customerID token:(NSString *) token
{
    NSDate *datenow = [NSDate date];
    NSString *dateString = [self URLEncode:[NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]]];
    NSString *platType = [self URLEncode:@"ios"];
    NSString *curVersion = [self URLEncode:[self getCurrentVersion]];
    
    [dic setObject:platType forKey:@"platType"];
    [dic setObject:curVersion forKey:@"curVersion"];
    [dic setObject:@"app" forKey:@"type"];
    [dic setObject:token forKey:@"token"];
    
    NSArray *keyArray = dic.allKeys;
    keyArray = [self orderNSArray:keyArray];
    NSString *dataStr = [NSString new];
    
    for (int i = 0 ; i < keyArray.count ; i++) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",keyArray[i],[self URLEncode:[dic objectForKey:[NSString stringWithFormat:@"%@",keyArray[i]]]]];
        
//        NSString *str = [NSString stringWithFormat:@"%@=%@",keyArray[i],[dic objectForKey:[NSString stringWithFormat:@"%@",keyArray[i]]]];
        if (i == 0) {
            dataStr = str;
        }else{
            dataStr = [NSString stringWithFormat:@"%@&%@",dataStr,str];
        }
    }
    dataStr = [NSString stringWithFormat:@"%@&timestamp=%@",dataStr,dateString];
    
//    HBRSAHandler* handler = [self creatRSA];
//    NSString *keySign = [handler signString:dataStr];
//    keySign = [self URLEncode:keySign];
//    NSString *resultStr = [NSString stringWithFormat:@"%@&sign=%@",dataStr,keySign];
    NSString *resultStr = [NSString stringWithFormat:@"%@",dataStr];
    return resultStr;
}

+(NSString*)URLEncode:(NSString *)str
{
     NSString * encodingString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodingString;
}

+(HBRSAHandler *)creatRSA{
    HBRSAHandler* handler = [HBRSAHandler new];
    NSString *publicKeyFilePath = [[NSBundle mainBundle] pathForResource:@"public_key.pem" ofType:nil];
    
    NSString *privateKeyFilePath = [[NSBundle mainBundle] pathForResource:@"private_key.pem" ofType:nil];
    [handler importKeyWithType:KeyTypePublic andPath:publicKeyFilePath];
    [handler importKeyWithType:KeyTypePrivate andPath:privateKeyFilePath];
    
    return handler;
}

+(BOOL)getObject:(NSDictionary *)object{
    HBRSAHandler *handler = [self creatRSA];

    NSString *sign = [object objectForKey:@"sign"];
    NSString *dateString = [object objectForKey:@"dateTime"];
    NSString *responseObject = [object objectForKey:@"responseObject"];
    NSString *password = @"CONFIG-APP";
    NSString *curSign = [NSString stringWithFormat:@"%@%@%@",dateString,password,responseObject];
    BOOL isCheck = [handler verifyString:curSign withSign:sign];
    if(isCheck){
        return YES;
    }else{
        return NO;
    }
}


//rsa加密方法
+(NSString *)getEnCryptRSAString:(NSString *)str {
    HBRSAHandler* handler = [self creatRSA];
    NSString *keySign = [handler encryptWithPublicKey:str];
    keySign = [self URLEncode:keySign];
    NSLog(@"keySign:%@",keySign);
    return keySign;
}


+(NSString *)getDeCryptRSAString:(NSString *)str {
    
    HBRSAHandler* handler = [self creatRSA];
    NSString *keySign = [handler decryptWithPrivatecKey:str];
    NSLog(@"keySign:%@",keySign);
    return keySign;
}


#pragma mark -获取字符串类型当前时间
/**
 *获取字符串类型当前时间
 *参数为: 日期格式，例如：yyyy-MM-dd or yyyy-MM-dd HH:mm:ss
 *@parem 日期格式，例如：yyyy-MM-dd or yyyy-MM-dd HH:mm:ss
 *@return 当前时间的字符串类型
 */
+(NSString *)getCurrentDateStringWithFormat:(NSString *)format
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:format];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    return currentDate;
    
    return currentDate;
}

#pragma mark -创建16位MD5加密
/**
 *创建16位MD5加密
 *@param  需要加密的字符串
 *@return MD5 16位加密字符串
 */
+(NSString *)createMD5With16:(NSString *)str
{
    const char *cStr = [str UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ] lowercaseString];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}

+(NSString *)getCurrentVersion {
    id versionStr =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *str = [NSString stringWithFormat:@"%@",versionStr];
    NSArray *arr = [str componentsSeparatedByString:@"."];
    int versionNum = [arr[0] intValue]*10000 + [arr[1] intValue]*100 +[arr[2] intValue];
    NSString *version = [NSString stringWithFormat:@"%d",versionNum];
    return version;
}



+(NSArray*)orderNSArray:(NSArray*)arr {
    NSArray *m=[arr sortedArrayUsingComparator:^(id obj1,id obj2){
        
        if (NSOrderedDescending==[obj1 compare:obj2])
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if (NSOrderedAscending==[obj1 compare:obj2])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame; }
        ];
    return m;
}



@end
