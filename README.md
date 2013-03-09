CGFConnectReports
=================
A small helper to download sales reports from iTunes Connect

Setup
=================
Add all files to your project, go to your projects build settings in Xcode and add `-lz` to **Other linker flags**

Usage
=================
Some examples to make the start a bit easier.

**Download daily reports for a specific date**
``objc
CGFConnectReports *reports = [CGFConnectReports instance];
    
    [reports downloadReportsOfType:@"Sales" username:@"YOUR_APPLE_ID" password:@"APPLE_ID_PASSWORD" vendorId:@"YOUR_VENDOR_ID" dateType:@"Daily" subtype:@"Summary" fromDate:@"20130307" onComplete:^(id response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"%@", response);
        }
    }];
``