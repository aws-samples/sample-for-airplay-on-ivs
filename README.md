## Sample for Airplay on Amazon IVS Player iOS SDK

This repository contains a sample app which showcases how to do Apple Airplay with Amazon IVS Player SDK playback. 

This sample uses both the IVS Player SDK and AVPlayer. It switches to AVPlayer when an Airplay route is selected, and reverts to the Amazon IVS Player when Airplay playback is dismissed. Due to the shift between players during Airplay playback, a latency increase is expected when using AVPlayer. IVS can only provide low latency out of the box when the IVS Player SDK is used for playback. Please refer to (https://docs.aws.amazon.com/ivs/latest/LowLatencyUserGuide/what-is.html#what-is-latency).

Discovery of Airplay devices is left to the iOS OS to decide and populate in the AVRoutePickerView. Please ensure valid airplay devices are ready and nearby when running the sample to be able to select them.

## Setup

1. Clone the repository to your local machine.
1. Ensure you are using a supported version of Ruby, as [the version included with macOS is deprecated](https://developer.apple.com/documentation/macos-release-notes/macos-catalina-10_15-release-notes#Scripting-Language-Runtimes). This repository is tested with the version in [`.ruby-version`](./.ruby-version), which can be used automatically with [rbenv](https://github.com/rbenv/rbenv#installation).
1. Install the SDK dependency using CocoaPods. This can be done by running the following commands from the repository folder:
   * `bundle install`
   * `bundle exec pod install --repo-update`
   * For more information about these commands, see [Bundler](https://bundler.io/) and [CocoaPods](https://guides.cocoapods.org/using/getting-started.html).
1. Open sample-for-airplay-on-ivs.xcworkspace.
1. Airplay functionality in this sample requires a physical iOS device and will not work in simulators.
1. If there are sandbox errors reported by Xcode during build:
   - Select Pods from project selector in the workspace side bar
   - Select AmazonIVSPlayer 
   - Select Build Settings Tab
   - Search for "Sandbox"
   - Please ensure all sandbox related build settings are set to "NO" 

## Using the application

- When the sample app is launched, IVS playback will automatically begin using the IVS Player SDK.
- An Airplay button will appear at the bottom of the screen.
- Selecting this button will open the AVRoutePickerView, which will display all discovered Airplay devices by the OS.
- Selecting an Airplay device will shift playback to that device by switching to AVPlayer. 
- If the AVRoutePickerView is dismissed and Airplay is stopped, playback will continue on the IVS Player SDK.
- This sample does not include error handling for network issues or Airplay failures. Users should implement their own error handling following Apple's guidelines.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.