CGFConnectReports
=================
A small helper to download sales reports from iTunes Connect

Usage
=================
Add all files to your project, go to your projects build settings in Xcode and add `-lz` to **Other linker flags**

## Download daily reports for a specific date
```objc
CGFConnectReports *reports = [CGFConnectReports instance];
    
[reports downloadReportsOfType:@"Sales" 
                      username:@"YOUR_APPLE_ID" 
                      password:@"APPLE_ID_PASSWORD" 
                      vendorId:@"YOUR_VENDOR_ID" 
                      dateType:@"Daily" 
                       subtype:@"Summary" 
                      fromDate:@"20130307" 
                    onComplete:^(id response, NSError *error) {
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    } else {
        NSLog(@"%@", response);
    }

}];
```

## Parameters
__reportType__    
Sales or Newsstand

__dateType__    
Daily, Weekly, Monthly or Yearly

__reportSubtype__    
Summary, Detailed or Opt-In (**Note:** Detailed is only available for Newsstand reports)

__date__ (optional, if no date parameter is provided, iTC will return the latest report available)    
YYYYMMDD (Daily or Weekly)
YYYYMM (Monthly)
YYYY (Yearly)
