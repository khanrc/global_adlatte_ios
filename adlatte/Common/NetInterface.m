//
//  NetInterface.m
//  hotcons
//
//  Created by 김태한 on 12. 7. 14..
//  Copyright (c) 2012년. All rights reserved.
//

#import "NetInterface.h"

#define BASEURL_  @"http://cms.adlatteglobal.com:7070"


@implementation NetInterface

+ (void) signupNumber:(NSString*)pNum name:(NSString*)userName
           onComplete:(completeHandler) handler
              onError:( void(^)(NSError*)) errHandler
{
    NSMutableString *address = [[NSMutableString alloc] initWithString:BASEURL_];
    [address appendString:@"/user/createUser.json"];
    [address appendFormat:@"?id=%@&name=%@",
     [pNum stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"+82-"],
     [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [address appendFormat:@"&mobile=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"U_myNumberNotHyphen"]];
    [address appendFormat:@"&deviceId=%@",[NSUD objectForKey:@"U_uuid"]];
    [address appendString:@"&osName=iOS"];
    [address appendFormat:@"&osVersion=%@",[[UIDevice currentDevice] systemVersion]];
    [address appendString:@"&password=rlaxogks"];

    NSURL *url = [NSURL URLWithString:address];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"pb> %@",address);
    if( nil != USERCONTEXT.operation && ![USERCONTEXT.operation isFinished] )
        [USERCONTEXT.operation cancel];

    USERCONTEXT.operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        // 가입에서 얻은 쿠키를 저장해 !
        NSArray *all = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:url];
//        for (NSHTTPCookie *cookie in all)
//            NSLog(@"Name: %@ : Value: %@", cookie.name, cookie.value);
        NSData *cookieData = [NSKeyedArchiver archivedDataWithRootObject:all];
        [[NSUserDefaults standardUserDefaults] setObject:cookieData forKey:@"MySavedCookies"];

        NSDictionary *userDic = [JSON objectForKey:@"createUserResponse"];
        handler( userDic[@"user"] );
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if( nil != errHandler )
            errHandler( error );
    }];
    
    [USERCONTEXT.operation start];
}

+ (void) postMyPicture:(UIImage*)img
            onComplete:(completeHandler) handler
               onError:( void(^)(NSError*)) errHandler
{
    UIImage *newImg = [UserContext imageWithImage:img scaledToSize:CGSizeMake(320, img.size.height * (320.0/img.size.width))];
    NSData *jpgData = UIImageJPEGRepresentation(newImg, 0.8);

    NSMutableString *address = [[NSMutableString alloc] initWithString:BASEURL_];
    [address appendString:@"/file/uploadFile.json?service=hotcon&ext=jpg"];
    [address appendFormat:@"&size=%d",jpgData.length];
//    NSURL *url = [NSURL URLWithString:address];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASEURL_]];


    [httpClient postPath:address parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];
}

+ (void) updateMyName:(NSString*)name msg:(NSString*)newMsg photoId:(NSString*)newPhotoId
           onComplete:(completeHandler) handler
              onError:( void(^)(NSError*)) errHandler
{
    NSMutableString *address = [[NSMutableString alloc] initWithString:BASEURL_];
    [address appendString:@"/user/updateUser.json"];
    [address appendFormat:@"?name=%@", [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [address appendFormat:@"&message=%@", [newMsg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [address appendFormat:@"&photoId=%@", newPhotoId];

    NSURL *url = [NSURL URLWithString:address];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"pb> %@",address);
    if( nil != USERCONTEXT.operation && ![USERCONTEXT.operation isFinished] )
        [USERCONTEXT.operation cancel];
    
    USERCONTEXT.operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        handler( [JSON objectForKey:@"updateUserResponse"]);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if( nil != errHandler )
            errHandler( error );
    }];
    
    [USERCONTEXT.operation start];
}

+ (void) createRelationName:(NSString*)name mobile:(NSString*)num
                      order:(NSUInteger)displayOrder
                 onComplete:(completeHandler) handler
                    onError:( void(^)(NSError*)) errHandler
{
    NSMutableString *address = [[NSMutableString alloc] initWithString:BASEURL_];
    [address appendString:@"/user/createRelation.json"];
    [address appendFormat:@"?partyId=%@", [[NSUD objectForKey:@"U_myNumber"] stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"+82-"]];
    [address appendFormat:@"&partyName=%@", [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [address appendFormat:@"&partyMobile=%@", num];
    [address appendFormat:@"&displayOrder=%d", displayOrder];
    [address appendString:@"&share=1"];

    NSURL *url = [NSURL URLWithString:address];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"pb> %@",address);
    if( nil != USERCONTEXT.operation && ![USERCONTEXT.operation isFinished] )
        [USERCONTEXT.operation cancel];
    
    USERCONTEXT.operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        handler( [JSON objectForKey:@"createRelationResponse"]);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if( nil != errHandler )
            errHandler( error );
    }];
    
    [USERCONTEXT.operation start];
}

+ (void) deleteRelationId:(NSString*)partyId
               onComplete:(completeHandler) handler
                  onError:( void(^)(NSError*)) errHandler
{
    NSMutableString *address = [[NSMutableString alloc] initWithString:BASEURL_];
    [address appendString:@"/user/deleteRelation.json"];
    [address appendFormat:@"?partyId=%@", [partyId stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"+82-"]];

    NSURL *url = [NSURL URLWithString:address];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"pb> %@",address);
    if( nil != USERCONTEXT.operation && ![USERCONTEXT.operation isFinished] )
        [USERCONTEXT.operation cancel];
    
    USERCONTEXT.operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        handler( [JSON objectForKey:@"deleteRelationResponse"]);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if( nil != errHandler )
            errHandler( error );
    }];
    
    [USERCONTEXT.operation start];
}

+ (void) getRelationListOnComplete:(void(^)(NSArray* ars)) handler
                           onError:( void(^)(NSError*)) errHandler
{
    NSMutableString *address = [[NSMutableString alloc] initWithString:BASEURL_];
    [address appendString:@"/user/getRelationList.json"];

    NSURL *url = [NSURL URLWithString:address];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"pb> %@",address);
    if( nil != USERCONTEXT.operation && ![USERCONTEXT.operation isFinished] )
        [USERCONTEXT.operation cancel];
    
    USERCONTEXT.operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        NSDictionary *result = [JSON objectForKey:@"getRelationListResponse"];
        handler( result[@"relations"] );
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if( nil != errHandler )
            errHandler( error );
    }];
    
    [USERCONTEXT.operation start];
}

+ (void) getEventListOnComplete:(completeHandler) handler
                        onError:( void(^)(NSError*)) errHandler
{
    NSMutableString *address = [[NSMutableString alloc] initWithString:BASEURL_];
    [address appendString:@"/event/getEventList.json"];

    NSURL *url = [NSURL URLWithString:address];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"pb> %@",address);
    if( nil != USERCONTEXT.operation && ![USERCONTEXT.operation isFinished] )
        [USERCONTEXT.operation cancel];
    
    USERCONTEXT.operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                             {
                                 handler( [JSON objectForKey:@"getEventListResponse"] );
                             } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                 if( nil != errHandler )
                                     errHandler( error );
                             }];

    [USERCONTEXT.operation start];
}

@end
