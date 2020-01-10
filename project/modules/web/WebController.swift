//
//  WebController.swift
//  project
//
//  Created by ebiz on 2020/1/10.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit

class WebController: EWebController {
    var webModel = WebModel([:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}

class WebModel: RouteExtraModel {
    var jumpUrl = ""
}
