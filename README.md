# MobileNode for iOS

This repository contains the [CocoaPod](http://cocoapods.org/) which powers the MobileNode (Check out the [companion node.js repo](https://github.com/kwhinnery/mobilenode) here).  This framework creates a JavaScript execution context in a native app for iOS (and could potentially also for for OS X, though that hasn't been tested at all).

## Apologies

Until things settle down, I won't be writing a lot of documentation. I do pinky swear, however, to provide useful API docs and guides ASAHP.

## Usage (Short Version)

MobileNode requires that your native iOS project be using Cocoapods.  To create a Cocoapods enabled iOS app project with Xcode, [check out their documentation](http://cocoapods.org/).  The short version is this:

#### The native part:
* Terminal: `gem install cocoapods`
* Terminal: `pod setup`
* Create an iOS project through Xcode
* Navigate to the location of the `.xcodeproj` folder Xcode created in the Terminal
* Create a file called `Podfile` with the following:
~~~
platform :ios, '7.0'
pod 'MobileNode', :git => 'git://github.com/kwhinnery/MobileNodeiOS'
~~~
* Run `pod install`
* Open the Cocoapods-enabled Xcode __Workspace__ (use this from now on): `open *xcworkspace`

#### The node part
* Install [node.js](http://nodejs.org/)
* Run `npm install -g mobilenode`
* create a file `app.js` with the following: `alert('hello mobile node!');`
* Run `mnode serve app.js`

#### The native part (again)
* In your Xcode Workspace, open your iOS app's app delegate (it will be `XXXAppDelegate.m`)
* At the top, add `#import "MobileNode.h"`
* In `application:didFinishLaunchingWithOptions:`, add the following: `[MobileNode developOnHost:@"localhost" port:8080];`
* Run your app in the iOS simulator
* High five your co-worker

Now, whenever you change your node.js code, changes will be streamed immediately to the simulator and run in a new JS context - a bit like hitting refresh in the browser.

## TODO

Lots.  Still super crude by any reasonable estimation.  Still need:

* Native implementations of core node.js modules
* Define how best for native modules to hook into MobileNode
* Explore options for debugging the JSCore environment
* Create Xcode project templates preconfigured with Podfile and some app types (SpriteKit)
* API docs and guides

