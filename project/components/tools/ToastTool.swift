//
//  ToastTool.swift
//  project
//
//  Created by ebiz on 2020/1/3.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit
import MBProgressHUD
class ToastTool: NSObject {

    class func toast(_ toastStr: String) {
        let hud = MBProgressHUD.showAdded(to: mainWindow, animated: true)
        hud.mode = .text
        hud.label.text = toastStr
        hud.hide(animated: true, afterDelay: 3.0)
    }
    
    class func toast(in view: UIView, toastStr: String) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = toastStr
    }
    
}
