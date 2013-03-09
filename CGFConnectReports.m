//
//  CGFConnectReports.m
//  iTC Report Downloader
//
//  Created by Björn Kaiser on 08.03.13.
//  Copyright (c) 2013 Björn Kaiser. All rights reserved.
//

#import "CGFConnectReports.h"

@implementation CGFConnectReports

static CGFConnectReports *_sharedInstance = nil;

+ (CGFConnectReports*) instance
{
    
    if (_sharedInstance == nil) {
        _sharedInstance = [[CGFConnectReports alloc] init];
    }
    
    return _sharedInstance;
}

- (void) downloadReportsOfType:(NSString*)reportType
                      username:(NSString*)username
                      password:(NSString*)password
                      vendorId:(NSString*)vendorId
                      dateType:(NSString*)dateType
                       subtype:(NSString*)reportSubtype
                      fromDate:(NSString*)date
                    onComplete:(void(^)(id response, NSError *error))completionHandler
{
    
    
    NSString *escapedUsername = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)username, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    NSString *escapedPassword = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)password, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    NSString *reportDownloadBodyString = [NSString stringWithFormat:@"USERNAME=%@&PASSWORD=%@&VNDNUMBER=%@&TYPEOFREPORT=%@&DATETYPE=%@&REPORTTYPE=%@&REPORTDATE=%@",
                                          escapedUsername, escapedPassword, vendorId, reportType, dateType, reportSubtype, date];
    NSData *reportDownloadBodyData = [reportDownloadBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *reportingUrl = [NSURL URLWithString:@"https://reportingitc.apple.com/autoingestion.tft"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:reportingUrl];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"java/1.6.0_26" forHTTPHeaderField:@"User-Agent"];
    [request setHTTPBody:reportDownloadBodyData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *httpResponse, NSData *responseData, NSError *error) {
        
        NSHTTPURLResponse *http = (NSHTTPURLResponse*)httpResponse;
        NSDictionary *responseHeaders = [http allHeaderFields];
        
        NSString *report = nil;
        if ([responseHeaders objectForKey:@"ERRORMSG"] != nil) {
            NSError *itcError = [[NSError alloc] initWithDomain:@"CGFConnectReportsErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:[responseHeaders objectForKey:@"ERRORMSG"] forKey:NSLocalizedDescriptionKey]];
            error = itcError;
        } else {
            if (responseData && !error) {
                report = [[NSString alloc] initWithData:[responseData gunzippedData] encoding:NSUTF8StringEncoding];
            }
        }
        
        if (completionHandler != nil) {
            completionHandler(report, error);
        }
        
    }];
    
}

@end
