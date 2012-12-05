# iOS Location Test

--

## Introduction

This is an iOS application, created in response to a question on Stack Overflow, [How to check my current location against locations in a remote file - iOS app](http://stackoverflow.com/questions/13667062). This is, by no means, a complete implementation, but rather is a barebones demonstration of some of the basic interfaces. Furthermore, this is a demonstration of the iOS client-side code, but does not address the server-side code to provide a JSON web-service to keep track of the collection of locations illustrated in the JSON response, described later in this document

Anyway, this iOS app demonstrates:

- The use of CoreLocation.framework and its [`CLLocationManager`](https://developer.apple.com/library/ios/#documentation/CoreLocation/Reference/CLLocationManager_Class/CLLocationManager/CLLocationManager.html) to determine the location of a device. See [Location Awareness Programming Guide](http://developer.apple.com/library/ios/#documentation/userexperience/conceptual/LocationAwarenessPG/Introduction/Introduction.html) for more information on location services.

- The use of [`NSJSONSerialization`](http://developer.apple.com/library/ios/#documentation/Foundation/Reference/NSJSONSerialization_Class/Reference/Reference.html) to parse a JSON file retrieved from a server.

The format of the JSON file on the server is presumed to be in the following format:

    [
      {
        "name" : "Battery Park",
        "latitude" : 40.702,
        "longitude" : -74.015
      },
      {
        "name" : "Grand Central Station",
        "latitude" : 40.753,
        "longitude" : -73.977
      }
    ]

Please note that you need to put this JSON file on your server (or write a web service that delivers similarly formatted JSON output) and update the `kLocationsUrlString` constant to point to that URL. (If you compile this app, it will generate a warning, bringing the appropriate line of code to your attention.)

This was developed using Xcode 4.5.2 for devices running iOS 6.

--

If you have any questions, do not hesitate to contact me at:

Rob Ryan
robert.ryan@mindspring.com

5 December 2012

