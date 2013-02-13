//
//  AdDetailInfo.h
//  adlatteGlobalCore
//
//  Created by 수아 강 on 12. 8. 20..
//  Copyright (c) 2012년 서울대학교. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MSG_AdDetailInfo  @"AdDetailInfo"

@interface AdDetailInfo : NSObject
@property (nonatomic, assign) bool downloadSucceeded;

- (id)initForList:(NSArray*)_list key:(NSArray*)_key;
- (id)valueForKey:(NSString *)key;
- (void)startFileDownload;

- (NSString*)pathForMovie;
- (bool)hasMovie;
- (NSArray*)advImagesPaths;

@end
