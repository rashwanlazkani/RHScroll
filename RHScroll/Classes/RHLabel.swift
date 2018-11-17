//
//  RHLabel.swift
//  RHScrollView
//
//  Created by Rashwan Lazkani on 2018-11-14.
//  Copyright © 2018 Rashwan Lazkani. All rights reserved.
//

import UIKit

public class RHLabel: UILabel {
    override public var textColor: UIColor! {
        didSet {
            super.textColor = textColor
        }
    }
    override public var text: String? {
        didSet {
           super.text = text
        }
    }
    override public var textAlignment: NSTextAlignment {
        didSet {
            super.textAlignment = textAlignment
        }
    }
    override public var backgroundColor: UIColor? {
        didSet {
            super.backgroundColor = backgroundColor
        }
    }
    
    public init(text: String) {
        super.init(frame: .zero)
        defaultValues()
        self.text = text
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 14)
    }
    
    public init(text: String, textColor: UIColor, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        defaultValues()
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: 14)
    }
    
    public init(text: String, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment, backgroundColor: UIColor?) {
        super.init(frame: .zero)
        defaultValues()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defaultValues() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.isUserInteractionEnabled = true
        self.layer.masksToBounds = true
    }
}
