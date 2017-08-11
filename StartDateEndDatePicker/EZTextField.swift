//
//  EZTextField.swift
//  EyaalZayeed
//
//  Created by apple on 14/06/17.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable
class EZTextField: UITextField, UITextFieldDelegate {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        makeRoundedEdge(boarderWidth: 1.0, borderColour: .lightGray, cornerRadius: 10.0)
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        makeRoundedEdge(boarderWidth: 1.0, borderColour: .lightGray, cornerRadius: 10.0)
        
    }
    
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftImagePadding
        return textRect
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += rightImagePadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftImagePadding: CGFloat = 10
    @IBInspectable var rightImagePadding: CGFloat = -10
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextFieldViewMode.never
            leftView = nil
        }
        
        if let image = rightImage {
            rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSForegroundColorAttributeName: color])
    }
    
    //Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        endEditing(true)
        textField.resignFirstResponder()
        return true;
    }
}
