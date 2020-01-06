//
//  UIView_Extension.swift
//  project
//
//  Created by lintong on 2020/1/6.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit

extension UIView {
    
    var lt_height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var lt_width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var lt_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var lt_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    
}
