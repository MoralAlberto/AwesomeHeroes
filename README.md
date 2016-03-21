#AwesomeHeroes


##DEMO
![DemoVideo](https://raw.githubusercontent.com/MoralAlberto/AwesomeHeroes/develop/demoImages/demoVideo.gif)

##Installation

Run the following command in the root directory of your project

```bash
$ carthage update
```

##Introduction
The app uses:<br><br>
 · **MVVM** pattern<br>
 · **Functional Reactive Programming** (RAC4)<br>
 · **Autolayout** <br>
 · **Manual layout** (with NSLayoutAnchor and NSLayoutConstraints)<br>
 · Custom **UICollectionViewLayout**<br>
 · **Tests** (with XCTest, [Quick](https://github.com/Quick/Quick) and [Nimble](https://github.com/Quick/Nimble))<br>
 · **IBDesignable** and **IBInspectionable**<br>
 · **Carthage** and **Cocoapods**<br>
 · **Dynamic cells**<br>
 · Localization<br>
 · Separate code in different layers<br>
 · **Code coverage**<br>

##RAC
Used Reactive Cocoa, useful in method like:
![rac](https://raw.githubusercontent.com/MoralAlberto/AwesomeHeroes/develop/demoImages/rac.png)

##REST API Architecture
AwesomeHeroes has an API module that works with [Reactive Cocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) and [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper). The API repository architecture is split in different logic parts: the managers, the network stuff, and the parser model.

This is a way to create a REST API with one goal: **Easy to maintain**. You can add more targets, managers or models in an easy way.

The demo get heroes from **Marvel API** subscribing to a **cold signal** (SignalProducer) and parsing the JSON to the correct model ready to be displayed/used in your controller/view.

Managers 	 | 			Models | 	Utils
------------ | ------------- | ------------
Character Manager | Model Character  | Contants
Comics Manager 	| Model Comics  	| 
Stories Manager | Model Stories |

###Parser Manager
The best part of this method are Generics. We can parse any class with this method, reusable code! 

```swift
    static func parse<T: Mappable>(data: NSData, toClass: T.Type) -> T? {
        let parsedObject: AnyObject?
        do {
            parsedObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            let result = Mapper<T>().map(parsedObject)
            return result
        } catch {
            return nil
        }
    }
```
###Utils
Created a enum to store the publicKey and privateKey. In production is mandatory to protect this information with pods like [Cocoapods-Keys](https://github.com/orta/cocoapods-keys)

Also, created an .plist to save all the API end points, with a quick look you can see all the end points used within AwesomeHeroes.

![plist](https://raw.githubusercontent.com/MoralAlberto/AwesomeHeroes/develop/demoImages/plist.png)

##Performance
I used Profiler to observe [performance](https://yalantis.com/blog/mastering-uikit-performance/) in AwesomeHeroes, the app is close to 60fps like you can observe in the next image. But, I notice a issue to be fixed, if I tap multiple times on the segmented controller (stories or comics) and the hero doesn't have any result. I add multiple times a label to the table view background, it's a bug easy to fix.

![performance](https://raw.githubusercontent.com/MoralAlberto/AwesomeHeroes/develop/demoImages/performance.png)
 
##Code Coverage
![codeCoverage](https://raw.githubusercontent.com/MoralAlberto/AwesomeHeroes/develop/demoImages/codeCoverage.png)

##Requirements
- iOS 8.0+
- Xcode 7.2

##License
This app project is for demonstration purposes only. Use of this source code in any form without express authorization is strictly forbidden.