//
//  UserContext.h
//  common module
//
//  Created by taehan kim on 13. 1. 1..
//  Copyright 2013 AdLatte All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <Accounts/Accounts.h>
//#import <Social/Social.h>
#import "WaitView.h"
#import "AFNetworking.h"
#import "NetInterface.h"

@interface UserContext: NSObject 
{
	WaitView	*waitV, *voteV;
    UIView      *titleView;
    NSTimer *_t;
}

@property (nonatomic, strong)   NSString    *my050Num;
@property (nonatomic, strong)   NSString    *myName;
@property (nonatomic, strong)   NSString    *myNumber;
//@property (nonatomic, strong)   NSString    *myIdentity;
//@property (nonatomic, strong)   NSString    *myLocale;

@property (nonatomic, strong)   AFJSONRequestOperation  *operation;

+ (UserContext *)sharedUserContext;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize) size;

- (id) initWithDefault;

- (void) startWaitView: (NSInteger) yDeltaPos;
- (void) stopWaitView;

@end
