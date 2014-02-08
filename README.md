Select State.gov Data SDK for iOS
==========

The Select State.gov Data (SSD) SDK provides a software library that makes it easy for iOS developers to integrate data from the Select State.gov Data API. The SSD API is a REST-based API for accessing the content and metadata posted on [www.state.gov](http://www.state.gov/ "State.gov"). Currently, the API exposes the following data sets:

* Appointment schedule for the Secretary of State
* State Department country fact sheets
* Travel information for the Secretary of State
* Trafficking in Person Reports
* State.gov Metadata

The full SSD API documentation can be found at [http://www.state.gov/api/v1/docs/](http://www.state.gov/api/v1/docs/ "State.gov API Documentation")

##Integration

###Requirements
* Xcode 5+* iOS 6+ target deployment* Supports armv7, armv7s, and arm64 devices
###Project Setup
The easiest way to integrate the SDK into an iOS app is to include the SDK as a sub-project. 
1. Start by cloning the GitHub repository on your local drive:			$ git clone https://github.com/AcuityInfoMgt/DOSDataAPI.git2. Next, open your Xcode project that you’d like to include the SDK in. Select File -> “Add Files to [Project Name]”.3. Select the DOSDataAPI.xcodeproj file to add the SDK as a subproject within your application.4. Next, edit the Build Phases settings of your parent project. Select your project in the Project Navigator, then click the “Build Phases” tab.
5. Edit the Target Dependencies and add the DOSDataAPI library as a dependency.
6. Edit the Link Binary with Libraries setting and add libDOSDataAPI.a:7. Update the header search paths of the parent project. Go to “Build Settings” of the project and look for “User Header Search Paths”. Then set the target setting to “$(BUILT_PRODUCTS_DIR)” and select “Recursive”.That’s it! You can now begin using the SDK methods as described below. 
###Usage
The SDK includes six data manager classes that correspond to State.gov’s current API functions:* **DOSSecretaryTravelDataManager**: Query the Secretary’s trip list and retrieve trip details. This class also provides summary level trip statistics.* **DOSSecretaryAppointmentManager**: Query the official appointment list for the Secretary of State and other officials within the Department.* **DOSTIPReportManager**: Query and retrieve information about State’s Trafficking in Persons reports.* **DOSCountryFactSheetManager**: Retrieve country fact sheet data.* **DOSBureauManager**: Retrieve State’s official list of Department Bureaus.* **DOSTermManager**: Retrieve a list of terms used throughout the API datasets.Each manager class can be used to query a specific dataset using a set of options that are specified by the State.gov API. For example, to obtain a list of recent trips taken by the Secretary of State, you would use the DOSSecretaryTravelDataManager class as shown below:```objective-c	NSMutableDictionary *options = [[NSMutableDictionary alloc] init]; 	[options setObject:@"id,title,date_start,date_end" forKey:DOSQueryArgFields];        DOSSecretaryTravelDataManager *dataMan = [[DOSSecretaryTravelDataManager alloc] init];	[dataMan getSecretaryTravelWithOptions:options success:^(NSArray *response) {         				self.tripItems = response;        self.totalItemsInQueryResults = dataMan.recordCountReturned;    } failure:^(NSError *error) {        NSLog(@"API Query failed: %@",error);        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Unable to connect to www.state.gov" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];        [alert show];    }];```
All of the manager classes follow the pattern shown above to retrieve data. The DOSDataAPITests.m file contains a full test suite, which provides examples for how to utilize each of the data manager classes and how to process the data that is returned.In addition, an example app that demonstrates how to fully integrate the SDK into an iPhone app is available here: [https://github.com/AcuityInfoMgt/DOSDataAPIExampleApp](https://github.com/AcuityInfoMgt/DOSDataAPIExampleApp "DOS SDK Example App") 
##License
The Select State.gov Data SDK is provided under the MIT license. See the LICENSE file for more info.
##Acknowledgments
The SSD SDK uses code from the following libraries:* [AFNetworking](http://afnetworking.com/ "AFNetworking")


