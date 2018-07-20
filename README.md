# SpitcastSwift

[![Version](https://img.shields.io/cocoapods/v/SpitcastSwift.svg?style=flat)](https://cocoapods.org/pods/SpitcastSwift)
[![License](https://img.shields.io/cocoapods/l/SpitcastSwift.svg?style=flat)](https://cocoapods.org/pods/SpitcastSwift)
[![Platform](https://img.shields.io/cocoapods/p/SpitcastSwift.svg?style=flat)](https://cocoapods.org/pods/SpitcastSwift)

## Usage

All available endpoints are exposed via the `SpitcastAPI` class, with the following usage:

```
SpitcastAPI.allSpots() { (result) in
  // Do something with spot information or handle error
}
```

There is a convenience class called `SpotData` which contains names and `SpotId` values used by Spitcast to identify particular surf spots:

```
SpitcastAPI.spotForecast(id: SpotData.LosAngeles.ManhattanBeach.id) { (result) in
    result.withValue({ (reports) in
      // Handle surf report information
    })
    result.withError({ (error) in
      // Handle error
    })
}
```

## Installation

SpitcastSwift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SpitcastSwift'
```
If being used in an iOS app, you will need to add this snipped to your Info.plist file to comply with App Transport Security:
```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
        <dict>
            <key>spitcast.com</key>
            <dict>
            <key>NSIncludesSubdomains</key>
            <true/>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>
```
Note that `NSExceptionAllowsInsecureHTTPLoads` must be true because Spitcast does not support HTTPS.

## Author

Daniel Legler

All content and surf reporting obtained by use of this library is owned by [Spitcast](http://www.spitcast.com).

## License

SpitcastSwift is available under the MIT license. See the LICENSE file for more info.
