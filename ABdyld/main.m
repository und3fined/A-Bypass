#include <stdlib.h>
#include <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <dlfcn.h>

#import "RogueHook.h"
#import "RGELog.h"

@interface CTCarrierHook : NSObject <RogueHook>
@end

@implementation CTCarrierHook
+ (NSString *)targetClass {
    // dlopen("/Library/MobileSubstrate/DynamicLibraries/bfdecrypt.dylib", RTLD_NOW);
    return @"CTCarrier";
}

-(NSString *)mobileNetworkCode {
	return @"06";
}
-(NSString *)mobileCountryCode {
  return @"450";
}
@end

@interface AMSLBouncerHook : NSObject <RogueHook>
@end

@implementation AMSLBouncerHook
+ (NSString *)targetClass {
    return @"AMSLBouncer";
}

-(NSData *)decrypt:(NSData *)arg1 key:(NSData *)arg2 padding:(unsigned int *)arg3 {
  return [@"ㅇㅇㄷ" dataUsingEncoding:4];
}
@end

@interface AMSLFairPlayInspectorHook : NSObject <RogueHook>
@end

@implementation AMSLFairPlayInspectorHook
+ (NSString *)targetClass {
    return @"AMSLFairPlayInspector";
}

+(id)unarchive:(id)arg1 {
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  NSData *object_nsdata = [@"ㅎㅇ" dataUsingEncoding:NSUTF8StringEncoding];
  [dict setObject:object_nsdata forKey:@"kConfirm"];
  [dict setObject:object_nsdata forKey:@"kConfirmValidation"];
  return dict;
}
+(id)hmacWithSierraEchoCharlieRomeoEchoTango:(id)arg1 andData:(id)arg2 {
  NSData *object_nsdata = [@"ㅎㅇ" dataUsingEncoding:NSUTF8StringEncoding];
  return object_nsdata;
}
-(id)fairPlayWithResponseAck:(id)arg1 {
  return nil;
}
@end

@interface BSAppIronHook : NSObject <RogueHook>
@end

@implementation BSAppIronHook
+ (NSString *)targetClass {
    return @"BSAppIron";
}
-(int)IiiIiIiiI {
  return 9013;
}
@end

@interface mVaccineHook : NSObject <RogueHook>
@end

@implementation mVaccineHook
+ (NSString *)targetClass {
    return @"mVaccine";
}
-(BOOL)isJailBreak {
	return false;
}
-(BOOL)mvc {
	return false;
}
-(BOOL)checkUrl {
	return false;
}
-(BOOL)checkFSTabFileSize {
	return false;
}
@end

@interface KSFileUtilHook : NSObject <RogueHook>
@end 

@implementation KSFileUtilHook
+ (NSString *)targetClass {
    return @"KSFileUtil";
}
+(int)checkJailBreak {
  return 1;
}
@end

@interface AppJailBrokenCheckerHook : NSObject <RogueHook>
@end

@implementation AppJailBrokenCheckerHook
+ (NSString *)targetClass {
    return @"AppJailBrokenChecker";
}
+(unsigned char)isAppJailbroken {
  return 0;
}
@end

@interface SFAntiPiracyHook : NSObject <RogueHook>
@end

@implementation SFAntiPiracyHook
+ (NSString *)targetClass {
    return @"SFAntiPiracy";
}
+(BOOL)isTheDeviceJailbroken {
  return false;
}
+(BOOL)isTheApplicationCracked {
  return false;
}
+(BOOL)isTheApplicationTamperedWith {
  return false;
}
+(void)lllI {

}
@end

@interface NSFileManagerHook : NSObject  <RogueHook>
@end

@implementation NSFileManagerHook
+(NSString *)targetClass {
  return @"NSFileManager";
}
-(BOOL)fileExistsAtPath:(NSString *)path {
  if([path hasPrefix:@"/Applications/"]) return false;
  return [self.original fileExistsAtPath:path];
}
@end

@interface UIApplicationHook : NSObject  <RogueHook>
@end

@implementation UIApplicationHook
+(NSString *)targetClass {
  return @"UIApplication";
}
-(BOOL)canOpenURL:(NSURL *)path {
  for (NSString* key in @[@"cydia", @"sileo"]) {
    if([path.absoluteString hasPrefix:key]) return false;
  }
  return [self.original canOpenURL:path];
}
@end

@interface StockNewsdmManager
+(char *)defRandomString;
@end

@interface StockNewsdmManagerHook : NSObject  <RogueHook>
@end
@implementation StockNewsdmManagerHook
+(NSString *)targetClass {
  return @"StockNewsdmManager";
}
+(char *)defRandomString {
  return "00000000";
}
@end

// @interface UpdateMIssuesManagerHook : NSObject  <RogueHook>
// @end
// @implementation UpdateMIssuesManagerHook
// +(NSString *)targetClass {
//   return @"UpdateMIssuesManager";
// }
// -(unsigned int)viewDidUnload:(struct mach_header *)arg2 {
//   [self.original didReceiveMemoryWarning];
//   [RGELog log:@"%s", [(Class)objc_getClass("StockNewsdmManager") defRandomString]];
//   return 0;
// }
// @end

// @interface IntroViewControllerHook : NSObject <RogueHook>
// @end

// @implementation IntroViewControllerHook
// + (NSString *)targetClass {
//     return @"IntroViewController";
// }
// @end

// @interface PureAppLibHook : NSObject <RogueHook>
// @end

// @implementation PureAppLibHook
// + (NSString *)targetClass {
//     return @"PureAppLib";
// }
// -(id)firstRequest:(id)arg2 :(id)arg3 {
//   [RGELog log:@"%@, %@", arg2, arg3];
//   return [self.original firstRequest:@"https://kr.repo.co.kr/pure.do" :arg3];
// }
// @end
