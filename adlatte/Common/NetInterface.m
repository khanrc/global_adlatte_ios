//
//  NetInterface.m
//  hotcons
//
//  Created by 김태한 on 12. 7. 14..
//  Copyright (c) 2012년 AppDisco. All rights reserved.
//

#import "NetInterface.h"

#define BASEURL_  @"http://dev.adlatteglobal.com/api"


@implementation NetInterface

+ (void) signupEmail:(NSString*)email password:(NSString*)password
            nickname:(NSString*)nick
              gender:(BOOL)isMale
            birthday:(NSString*)bday
           onComplete:(completeHandler) handler
              onError:( void(^)(NSError*)) errHandler
{
    NSURL *url = [NSURL URLWithString:BASEURL_];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];

    if( nil != USERCONTEXT.operation && ![USERCONTEXT.operation isFinished] )
        [USERCONTEXT.operation cancel];
    if( nil == password || nil == email ) return;

    NSDictionary *param = @{@"email":email,
                            @"password":password,
                            @"nickname":nick,
                            @"sex":((isMale)?@"male":@"female"),
                            @"birthday":bday,
                            @"country":[[NSLocale currentLocale] objectForKey: NSLocaleCountryCode]};

    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"user/registerUser" parameters:param];

    NSLog(@"signup params;\n%@\n%@",param, request.URL.absoluteString);

    USERCONTEXT.operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        // 가입에서 얻은 쿠키를 저장해 !
        NSArray *all = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:url];
#ifdef DEBUG
        for (NSHTTPCookie *cookie in all)
            NSLog(@"cookie Name: %@ : Value: %@", cookie.name, cookie.value);
#endif
        NSData *cookieData = [NSKeyedArchiver archivedDataWithRootObject:all];
        [[NSUserDefaults standardUserDefaults] setObject:cookieData forKey:@"MySavedCookies"];

        NSLog(@"registerUser;\n%@", JSON);
        handler( JSON );
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",response.debugDescription);
        if( nil != errHandler )
            errHandler( error );
    }];

    [USERCONTEXT.operation start];
}

+ (void) loginEmail:(NSString*)email password:(NSString*)password
          onComplete:(completeHandler) handler
             onError:( void(^)(NSError*)) errHandler
{
    NSURL *url = [NSURL URLWithString:BASEURL_];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    if( nil != USERCONTEXT.operation && ![USERCONTEXT.operation isFinished] )
        [USERCONTEXT.operation cancel];
    if( nil == password || nil == email ) return;
    
    NSDictionary *param = @{@"userid":email,
                            @"pass":password};

    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"user/login" parameters:param];

    USERCONTEXT.operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        NSLog(@"login;\n%@", JSON);
        handler( JSON );
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if( nil != errHandler )
            errHandler( error );
    }];

    [USERCONTEXT.operation start];
}





@end
