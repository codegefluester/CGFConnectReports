//
//  CGFConnectReports.h
//  iTC Report Downloader
//
//  Created by Björn Kaiser on 08.03.13.
//  Copyright (c) 2013 Björn Kaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+GZIP.h"

@interface CGFConnectReports : NSObject {

}

+ (CGFConnectReports*) instance;
- (void) downloadReportsOfType:(NSString*)reportType
                      username:(NSString*)username
                      password:(NSString*)password
                      vendorId:(NSString*)vendorId
                      dateType:(NSString*)dateType
                       subtype:(NSString*)reportSubtype
                      fromDate:(NSString*)date
                    onComplete:(void(^)(id response, NSError *error))completionHandler;

@end
