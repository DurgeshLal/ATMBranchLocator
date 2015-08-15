//
//  BackendUtility.m
//  JCATMLocator
//
//  Created by Durgesh Gupta on 8/14/15.
//  Copyright (c) 2015 Durgesh Gupta. All rights reserved.
//

#import "BackendUtility.h"

@implementation BackendUtility

+ (void)requestWithURL:(NSString *)url andCompletionBlock:(receivedData)compblock
{
    
    NSString *urlString =[NSString stringWithFormat:@"%@",url];
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [request setHTTPMethod:@"GET"];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        // handle response
        NSError *jsonError;
        
        id dict =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingAllowFragments
                                          error:&jsonError];
        
        
        
        if (!jsonError )
        {
            compblock(dict,error);
        }
        else
        {
            compblock(dict,error);
        }
    }] resume];
    
}

@end
