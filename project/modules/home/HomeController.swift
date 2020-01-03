//
//  HomeController.swift
//  project
//
//  Created by lintong on 2019/8/20.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit
import Alamofire

class HomeController: EBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationTool.post(.loginSuccess)
    }

}
