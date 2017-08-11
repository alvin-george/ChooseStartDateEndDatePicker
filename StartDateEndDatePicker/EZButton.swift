//
//  EZButton.swift
//  EyaalZayeed
//
//  Created by apple on 16/06/17.
//  Copyright © 2017 apple. All rights reserved.
//

import Foundation
import UIKit

class EZButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        layer.cornerRadius = 5.0
        clipsToBounds = true
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        changeFontName()
        
        
    }
    func changeFontName()
    {
 
        self.titleLabel!.font = UIFont(name: "Arial", size: (titleLabel?.font.pointSize)!)!
    }
    
}
