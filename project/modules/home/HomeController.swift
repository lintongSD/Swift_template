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
        let web = EWebController()
        //测试ajax注入
        //web.url = "http://dat-m.lxebao.com/h5/product/productDetail_agent_vue.html?pro_item_code=LXB_608&source=hrej&curVersion=10003&platType=ios&token=ecf2cad3b1e9407d865da0810b3e0397&type=hrgxapp&timestamp=1578570650"
        //测试注入时机
        Storage.token = "8ed7833f72a448a1a515ee194896a0e5"
        web.url = "http://139.9.31.175:18025/#/product/homeProduct?workinapp=1"
        
        self.navigationController?.pushViewController(web, animated: true)
    }

}
