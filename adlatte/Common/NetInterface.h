//
//  NetInterface.h
//
//  Created by 김태한 on 12. 7. 14..
//  Copyright (c) 2012년 All rights reserved.
//

/*
 */

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^completeHandler)(NSDictionary *dics);

@interface NetInterface : NSObject


+ (void) signupNumber:(NSString*)pNum name:(NSString*)userName
           onComplete:(completeHandler) handler
              onError:( void(^)(NSError*)) errHandler;

+ (void) postMyPicture:(UIImage*)img
            onComplete:(completeHandler) handler
               onError:( void(^)(NSError*)) errHandler;

+ (void) updateMyName:(NSString*)name msg:(NSString*)newMsg photoId:(NSString*)newPhotoId
           onComplete:(completeHandler) handler
              onError:( void(^)(NSError*)) errHandler;

+ (void) getRelationListOnComplete:(void(^)(NSArray* ars)) handler
                           onError:( void(^)(NSError*)) errHandler;


+ (void) createRelationName:(NSString*)name mobile:(NSString*)num
                      order:(NSUInteger)displayOrder
                 onComplete:(completeHandler) handler
                    onError:( void(^)(NSError*)) errHandler;

+ (void) deleteRelationId:(NSString*)partyId
               onComplete:(completeHandler) handler
                  onError:( void(^)(NSError*)) errHandler;

@end
