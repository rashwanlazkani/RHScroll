# RHScroll

[![CI Status](https://img.shields.io/travis/rashwanlazkani/RHScroll.svg?style=flat)](https://travis-ci.org/rashwanlazkani/RHScroll)
[![Version](https://img.shields.io/cocoapods/v/RHScroll.svg?style=flat)](https://cocoapods.org/pods/RHScroll)
[![License](https://img.shields.io/cocoapods/l/RHScroll.svg?style=flat)](https://cocoapods.org/pods/RHScroll)
[![Platform](https://img.shields.io/cocoapods/p/RHScroll.svg?style=flat)](https://cocoapods.org/pods/RHScroll)

## About
`RHScroll`  is a `ScrollView` similar to several famous apps out on the App Store. It creates in a simple way a horizontal `ScrollView` which can be used for several different purposes. You´re able to choose the size of the `ScrollView`, size of the items, the data and the positioning of everything. It has built in animations and notifications for tap and longPress gestures. You can add views, labels and images (see examples below).

### Here is how it looks:
#### Regular:
![](https://media.giphy.com/media/2fLiopQntLyKJE8yAS/giphy.gif)

#### Circles:
<img src="https://github.com/rashwanlazkani/RHScroll/blob/master/Screenshots/1.jpeg" alt="drawing" style="width:200px;"/>


## Functions
`RHScrollView` have two functions that can be called:

1. `func createFor(_ views: [RHView], frame: CGRect, itemSize: CGSize) -> RHScrollView { ... }` which returns a `RHScrollView` - with the choosen views and on the selected frame.

2. `func createFor(_ labels: [RHLabel], frame: CGRect, itemSize: CGSize) -> RHScrollView { ... }` which returns a `RHScrollView` - with the choosen labels and on the selected frame.

## Implementation
To implement `RHScrollView` in your view do the following:

### Step 1 - subscribe to clicks
In your `viewDidLoad` subscribe to the following `Notification`:

`NotificationCenter.default.addObserver(self, selector: #selector(rhScrollViewDidSelect), name: Notification.Name(RHConst.didSelect), object: nil)`

This is used for notification whenever an item is selected in the `ScrollView`. Then declare the function for the `Notification`:

```
@objc private func rhScrollViewDidSelect(notification: Notification) {
  if let object = notification.object as? [String: Any], let scrollViewTag = object[RHConst.scrollViewTag] as? Int, let itemTag = object[RHConst.itemTag] as? Int, let longPressGestureMax = object[RHConst.longPressGestureMax] as? Bool {
    if longPressGestureMax {
      // Here you can for instance show an actionSheet
    }   
  }
}
```

In this function there are three variables:
`scrollViewTag` - this is used if you have more than one `ScrollView`, so that you know which  `ScrollView` that is active
`itemTag` - which item that has been selected in the `ScrollView`
`longPressGestureMax` - if the user has selected the item with a long press which is called after 0.5 seconds, then this is true

### Step 2 - Create the `ScrollView` for the different kind of data

#### Views and images
```
let views = [RHView(backgroundColor: .green), RHView(backgroundColor: .gray), RHView(backgroundColor: .orange), RHView(backgroundColor: .black), RHView(backgroundColor: .magenta)]

let frame = CGRect(x: 16, y: 200, width: self.view.frame.maxX - 32, height: 75)
let size = CGSize(width: 100, height: 65)

let scrollView = rhScrollView.createFor(images, frame: frame, itemSize: size)
self.view.addSubview(scrollView)
```

#### Labels
```
let labels = [RHLabel(text: "First"), RHLabel(text: "Second"), RHLabel(text: "Third"), RHLabel(text: "Fourth")]

let frame = CGRect(x: 16, y: 300, width: self.view.frame.maxX - 32, height: 75)
let size = CGSize(width: 100, height: 65)

let scrollView = rhScrollView.createFor(labels, frame: frame, itemSize: size) // if you want it round you can also pass the following parameter: isRound: true at the end.
self.view.addSubview(scrollView)
```

That is all that is needed to create the `ScrollView`.

## Full example with a `RHScroll` containing views
```
import RHScroll
import UIKit

class ViewController: UIViewController {
  let rhScrollView = RHScrollView()

override func viewDidLoad() {
  super.viewDidLoad()

  NotificationCenter.default.addObserver(self, selector: #selector(rhScrollDidSelect), name: Notification.Name(RHConst.didSelect), object: nil)

    create()
  }

  func create() {
        let views = [RHView(backgroundColor: .green), RHView(backgroundColor: .black), RHView(backgroundColor: .blue), RHView(backgroundColor: .yellow)]
        
        let frame = CGRect(x: 16, y: 400, width: self.view.frame.maxX - 32, height: 75)
        let size = CGSize(width: 100, height: 65)
        
        let scrollView = rhScrollView.createFor(views, frame: frame, itemSize: size) // if you want it round you can also pass the following parameter: isRound: true at the end.
        self.view.addSubview(scrollView)
    }
    
    @objc private func rhScrollDidSelect(notification: Notification) {
        if let object = notification.object as? [String: Any], let scrollViewTag = object[RHConst.scrollViewTag] as? Int, let itemTag = object[RHConst.itemTag] as? Int, let longPressGestureMax = object[RHConst.longPressGestureMax] as? Bool {
            if longPressGestureMax {
                // Here you can for instance show an actionSheet
                print("long press on \(scrollViewTag) and item \(itemTag)")
            } else {
                print("tap on \(scrollViewTag) and item \(itemTag)")
            }
        }
    }
}
```

## Requirements

## Installation

RHScrollView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RHScroll'
```

## Author

rashwanlazkani, rashwan87@gmail.com

## License

RHScrollView is available under the MIT license. See the LICENSE file for more info.
