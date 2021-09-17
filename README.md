# TeadsSDK-ios


Teads allows you to integrate a single SDK into your app, and serve premium branded "outstream" video ads from Teads SSP ad server. This sample app includes Teads iOS framework and is showing integration examples.


> **⚠️ Important ⚠️**
> 
> ***Xcode 13 + iOS 15 device***
>
> [#155](https://github.com/teads/TeadsSDK-iOS/issues/155) building your application with **Xcode 13** and running it on **iOS 15 device** will crash when running TeadsSDK, we strongly advise to upgrade to [4.8.8 version](https://github.com/teads/TeadsSDK-iOS/releases/tag/v4.8.8) which fixes this crash
>
> You can still build and publish your app using Xcode 12 with older versions than 4.8.8
>

## Run the sample app

Clone this repository, open it with Xcode, and run project.

## Install the Teads SDK iOS framework

Teads SDK is currently distributed through CocoaPods. It include everything you need to serve "outstream" video ads.

### Cocoapods

```
target 'YourProject' do
    pod 'TeadsSDK'
end
```

In terminal in the directory containing your project's `.xcodeproj` file and the Podfile, run `pod install` command. This will install Teads SDK along with our needed dependencies.

```
$ pod install --repo-update
```

### Swift Package Manager

[SPM](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies. To integrate TeadsSDK into your Xcode project using SPM, specify package repository url :

```
https://github.com/teads/TeadsSDK-iOS
```

Then select latest version available

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate TeadsSDK into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "teads/TeadsSDK-iOS"
```

## Integration Documentation

Integration instructions are available on [Teads SDK Documentation](https://support.teads.tv/support/solutions/articles/36000165909).

## Changelog

See [changelog here](CHANGELOG.md). 
