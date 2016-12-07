# PeterParker
Beautiful wrapper around ugly Mac/BSD low-level network API. Written in Swift 3.

# Requirements
- Xcode 8.1
- Swift 3.0.1

# Build with Xcode Beta

 In order to be able to build the framework with Xcode which is not located under `/Applications/Xcode.app` folder, you have to change the path to Xcode in respective `.modulemap` (`/Sources/Modules/iphoneos/module.modulemap` and `/Sources/Modules/iphonesimulator/module.modulemap`) files.
