//
//  NetInterface.h
//
//  Created by 김태한 on 12. 7. 14..
//  Copyright (c) 2012년 AppDisco All rights reserved.
//

/*
 */

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^completeHandler)(NSDictionary *dics);

@interface NetInterface : NSObject


+ (void) signupEmail:(NSString*)email password:(NSString*)password
            nickname:(NSString*)nick
              gender:(BOOL)isMale
            birthday:(NSString*)bday
          onComplete:(completeHandler) handler
             onError:( void(^)(NSError*)) errHandler;

+ (void) loginEmail:(NSString*)email password:(NSString*)password
         onComplete:(completeHandler) handler
            onError:( void(^)(NSError*)) errHandler;



@end
