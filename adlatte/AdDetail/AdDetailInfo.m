//
//  AdDetailInfo.m
//  adlatteGlobalCore
//
//  Created by 수아 강 on 12. 8. 20..
//  Copyright (c) 2012년 서울대학교. All rights reserved.
//

#import "AdDetailInfo.h"
//#import "PhotoManager.h"
//#import "SSZipArchive.h"

@interface AdDetailInfo()
@property (nonatomic, strong) NSArray* keys;
@property (nonatomic, strong) NSArray* list;
@property (nonatomic, strong) NSString* folderPath;
@property (nonatomic, strong) NSMutableArray* advImages;

@end

@implementation AdDetailInfo
@synthesize list, keys, advImages, downloadSucceeded, folderPath;

- (id)initForList:(NSArray*)_list key:(NSArray*)_key
{
    self = [super init];
    if (self)
    {
        list = _list;
        keys = _key;
    }
    return self;
}

- (id)valueForKey:(NSString *)key
{
    int idx = [keys indexOfObject:key];
    return (idx >=0 && idx < list.count)?[list objectAtIndex:idx]:NULL;
}

- (NSString*)pathForMovie
{
    return [self.folderPath stringByAppendingPathComponent:@"movie.mp4"];
}

- (bool)hasMovie
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self pathForMovie]];
}

- (NSArray*)advImagesPaths
{
    if (!advImages)
    {
        advImages = [[NSMutableArray alloc]init];
        NSString* path = [self.folderPath stringByAppendingPathComponent:@"images.jpg"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            [advImages addObject:path];
        }
        else
        {
            for(int i = 0;i < 100; i++)
            {
                NSString* path = [self.folderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"images%d.jpg",i]];
                if ([[NSFileManager defaultManager] fileExistsAtPath:path])
                {
                    [advImages addObject:path];
                }
                else
                    break;
            }
        }

    }
    return advImages;
}


- (void)startFileDownload
{
    NSString* advFileUrl = [self valueForKey:@"advUrl"];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString*documentsDirectory = [paths objectAtIndex:0];
    __block NSString* path = [documentsDirectory stringByAppendingPathComponent:[advFileUrl lastPathComponent]];
    self.folderPath = [path stringByDeletingPathExtension];

    if ([[NSFileManager defaultManager] fileExistsAtPath:self.folderPath] == true)
    {
        self.downloadSucceeded = true;
        [[NSNotificationCenter defaultCenter] postNotificationName:MSG_AdDetailInfo object:self];
        return;
    }

//    __block float current = 0;

    // TODO: Do download, and post about result
    // TESTING ~~~~~~
//    [SSZipArchive unzipFileAtPath:path toDestination:_self.folderPath];
    self.downloadSucceeded = true;
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    [[NSNotificationCenter defaultCenter] postNotificationName:MSG_AdDetailInfo object:self];

    // TODO: If error,
    //_self.downloadSucceeded = false;
    //[[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    // and .. ? [[NSNotificationCenter defaultCenter] postNotificationName:MSG_AdDetailInfo object:self];
}

@end
