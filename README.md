#AwesomeHeroes


##DEMO
![DemoVideo](https://raw.githubusercontent.com/MoralAlberto/AwesomeHeroes/develop/demo/demoVideo.gif)

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

##Code Coverage
![codeCoverage](https://raw.githubusercontent.com/MoralAlberto/AwesomeHeroes/develop/demoImage/codeCoverage.png)

##Requirements
- iOS 8.0+
- Xcode 7.2

##License
This app project is for demonstration purposes only. Use of this source code in any form without express authorization is strictly forbidden.