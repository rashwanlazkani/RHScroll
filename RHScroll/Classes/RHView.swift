//
//  RHView.swift
//  RHScrollView
//
//  Created by Rashwan Lazkani on 2018-11-14.
//  Copyright © 2018 Rashwan Lazkani. All rights reserved.
//

import UIKit

public class RHView: UIView {
    override public var backgroundColor: UIColor? {
        didSet {
            super.backgroundColor = backgroundColor
        }
    }
    var image: UIImage? = UIImage()
    
    init() {
        super.init(frame: .zero)
    }
    
    public init(backgroundColor: UIColor?) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
    
    public init(image: UIImage?) {
        super.init(frame: .zero)
        self.image = image
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
