# PeterParker
Beautiful wrapper around ugly Mac/BSD low-level network API. Written in Swift 3.

# Requirements
- Xcode 8.3
- Swift 3.0.1
- CocoaPods 1.1.0
- iOS 9.0+ (should work on iOS version lower than iOS 9, but not tested for a while)

# Setup

## CocoaPods

* Check CocoaPods version by `pod --version` (it should be the same as listed in requirements).
* Add the framework to `Podfile`

```
    pod 'PeterParker', :git => 'https://github.com/shergin/PeterParker.git', :branch => 'master'
```

* run `pod install`


# Build with Xcode Beta

Currently the framework is configured in a way that relies on the Xcode.app path (e.g. `/Applications/Xcode.app`). Thus, when building the framework under the Xcode version other then current release, the steps mentioned below have to be performed.

## Standalone build

 * Change path to Xcode via [`xcode-select`](https://macops.ca/developer-binaries-on-os-x-xcode-select-and-xcrun):

```
    sudo xcode-select -s /Applications/Xcode-beta.app/Contents/Developer
```

* Double check the path has been changed:

```
    xcode-select -p
```

* Edit the path to Xcode in respective `.modulemap`'s: 
 * `/Sources/Modules/iphoneos/module.modulemap`
 * `/Sources/Modules/iphonesimulator/module.modulemap`

## CocoaPods

* Import the framework as a [Development Pod](https://medium.com/@euginedubinin/development-pods-de631774751e):

```
    pod 'PeterParker', :path => '~/Path/To/PeterParker'
```

* Change path to Xcode via [`xcode-select`](https://macops.ca/developer-binaries-on-os-x-xcode-select-and-xcrun):

```
    sudo xcode-select -s /Applications/Xcode-beta.app/Contents/Developer
```

* Double check the path has been changed:

```
    xcode-select -p
```
* Edit the path to Xcode in respective `.modulemap`s: `/Sources/Modules/iphoneos/module.modulemap` and `/Sources/Modules/iphonesimulator/module.modulemap` files.
* Run `pod install` on the project.
* Build and Run the app agains the physical device.

