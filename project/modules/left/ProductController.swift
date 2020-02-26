//
//  ProductController.swift
//  project
//
//  Created by 林_同 on 2020/2/26.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit

class ProductController: WebController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.lt_height = screenHeight - navigationHeight - tabbarHeight
        
    }
}
