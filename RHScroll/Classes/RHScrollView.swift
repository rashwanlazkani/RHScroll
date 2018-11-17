//
//  RHScrollView.swift
//  RHScrollView
//
//  Created by Rashwan Lazkani on 2018-11-08.
//  Copyright © 2018 Rashwan Lazkani. All rights reserved.
//

import UIKit

public class RHScrollView: UIScrollView {
    // The entry at position 1,1 in the matrix for the custom view in the ScrollView
    private var m11Long: CGFloat = 0.925
    private var m11Tap: CGFloat = 0.975
    private var longPressGestureMax = false
    private var scrollView: RHScrollView!
    private var numberOfScrollViews = 0
    
    /// Create a RHScrollView for images and views
    ///
    ///
    /// - Parameters:
    ///     - views: a collection of RHView, which may contain UIView or UIImage
    ///     - frame: frame for the RHScrollView in your view
    ///     - itemSize: the size for the items in the RHScrollView
    /// - Returns:
    ///     - RHScrollView with the choosen views and on the selected frame
    public func createFor(_ views: [RHView], frame: CGRect, itemSize: CGSize) -> RHScrollView {
        let data = setData(data: views, frame: frame, size: itemSize)
        setupScrollView(data: data, frame: frame, items: views.count, size: itemSize)
        return scrollView
    }
    
    /// Create a RHScrollView for labels
    ///
    ///
    /// - Parameters:
    ///     - views: a collection of RHLabel, which may contain RHLabel which is a subclass of UILabel
    ///     - frame: frame for the RHScrollView in your view
    ///     - itemSize: the size for the items in the RHScrollView
    /// - Returns:
    ///     - RHScrollView with the choosen labels and on the selected frame
    public func createFor(_ labels: [RHLabel], frame: CGRect, itemSize: CGSize) -> RHScrollView {
        let data = setData(data: labels, frame: frame, size: itemSize)
        setupScrollView(data: data, frame: frame, items: labels.count, size: itemSize)
        return scrollView
    }
    
    private func setupScrollView<T>(data: [T], frame: CGRect, items: Int, size: CGSize) {
        scrollView = RHScrollView(frame: frame)
        scrollView.tag = setScrollViewTag()
        scrollView.contentSize = CGSize(width: CGFloat(items) * size.width + CGFloat(items) * 8 - 8, height: scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        
        
        if T.self == RHLabel.self {
            let labels = data as! [RHLabel]
            labels.forEach { (label) in
                scrollView.addSubview(label)
            }
        } else if T.self == RHView.self || T.self == UIImage.self {
            let views = data as! [RHView]
            views.forEach { (view) in
                scrollView.addSubview(view)
            }
        }
    }
    
    private func setData<T>(data: [T], frame: CGRect, size: CGSize) -> [T] {
        var collection = [T]()
        for i in 0..<data.count {
            let x = i == 0 ? size.width * CGFloat(i) : size.width * CGFloat(i) + CGFloat(i) * 8
            let itemFrame = CGRect(x: x, y: 0, width: size.width, height: size.height)
            
            if T.self == RHLabel.self {
                let label = customLabel(label: data[i] as! RHLabel, frame: itemFrame, index: i) as! T
                collection.append(label)
            } else if T.self == RHView.self {
                let view = customView(view: data[i] as! RHView, frame: itemFrame, index: i) as! T
                collection.append(view)
            }
        }
        return collection
    }
    
    private func customLabel(label: RHLabel, frame: CGRect, index: Int) -> UILabel {
        label.frame = frame
        label.tag = index
        addGestures(view: label)
        return label
    }
    
    private func customView(view: RHView, frame: CGRect, image: UIImage? = nil, index: Int) -> UIView {
        view.frame = frame
        view.tag = index
        view.layer.cornerRadius = 5
        addGestures(view: view)
        
        if let image = view.image {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 65))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 5
            view.addSubview(imageView)
        }
        return view
    }
    
    private func setScrollViewTag() -> Int {
        let tag = numberOfScrollViews
        numberOfScrollViews += 1
        return tag
    }
    
    private func addGestures(view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        view.addGestureRecognizer(tapGesture)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(_:)))
        longGesture.minimumPressDuration = 0.15
        view.addGestureRecognizer(longGesture)
    }
    
    
    @objc private func tapGesture(_ recognizer: UITapGestureRecognizer) {
        let scrollViewTag = (recognizer.view?.superview?.tag)!
        let itemTag = (recognizer.view?.tag)!
        didSelect(scrollViewTag: scrollViewTag, itemTag: itemTag)
        
        UIView.animate(withDuration: 0.4, animations: {
            recognizer.view?.transform = CGAffineTransform(scaleX: self.m11Tap, y: self.m11Tap)
        }) { (_) in
            recognizer.view?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    @objc private func longPressGesture(_ recognizer: UILongPressGestureRecognizer) {
        let scrollViewTag = (recognizer.view?.superview?.tag)!
        let itemTag = (recognizer.view?.tag)!
        
        switch recognizer.state {
        case .began:
            UIView.animate(withDuration: 0.4, animations: {
                recognizer.view?.transform = CGAffineTransform(scaleX: self.m11Long, y: self.m11Long)
            }) { (_) in
                recognizer.view?.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.longPressGestureMax = true
                self.didSelect(scrollViewTag: scrollViewTag, itemTag: itemTag)
            }
        case .ended:
            if recognizer.view?.layer.transform.m11 == m11Long {
                UIView.animate(withDuration: 0.1, animations: {
                    recognizer.view?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.didSelect(scrollViewTag: scrollViewTag, itemTag: itemTag)
                })
            }
        default:
            break
        }
    }
    
    private func didSelect(scrollViewTag: Int, itemTag: Int) {
        let object: [String: Any] = [RHConst.scrollViewTag: scrollViewTag, RHConst.itemTag: itemTag, RHConst.longPressGestureMax: longPressGestureMax]
        NotificationCenter.default.post(name: Notification.Name(RHConst.didSelect), object: object)
        longPressGestureMax = false
    }
}
