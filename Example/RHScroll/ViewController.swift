//
//  ViewController.swift
//  RHScroll
//
//  Created by rashwanlazkani on 11/17/2018.
//  Copyright (c) 2018 rashwanlazkani. All rights reserved.
//

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
        
        let frame = CGRect(x: 16, y: 400, width: self.view.frame.maxX - 32, height: 80)
        let size = CGSize(width: 80, height: 80)
        
        let scrollView = rhScrollView.createFor(views, frame: frame, itemSize: size, isRound: true)
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
