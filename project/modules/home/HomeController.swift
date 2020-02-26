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

    var requestUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //测试ajax注入
        //let url = "http://dat-m.lxebao.com/h5/product/productDetail_agent_vue.html?pro_item_code=LXB_608&source=hrej&curVersion=10003&platType=ios&token=ecf2cad3b1e9407d865da0810b3e0397&type=hrgxapp&timestamp=1578570650"
        //测试注入时机
        Storage.token = "765acf2f511d440090a671d3be3b9446"
        let url = "http://139.9.31.175:18025/#/product/homeProduct?workinapp=1"
        
        
        let dict = ["flag":"h5",
                    "extra":["url":url]] as [String : Any]
        let model = RouteModel(dict)
        
        ELog(model.modelToDict())
        RouteTool.bridgeWith(model)
        
    }

}
