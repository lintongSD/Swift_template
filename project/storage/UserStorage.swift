//
//  UserStorage.swift
//  project
//
//  Created by 林_同 on 2020/2/26.
//  Copyright © 2020 lintong. All rights reserved.
//

import UIKit

class UserStorage: NSObject {
//    class var userModel: UserModel {
//        get {
//            var model = UserModel()
//            if let dic = UserDefaults.standard.object(forKey: "userModel") {
//                model = UserModel.deserialize(from: dic) ?? UserModel()
//            }
//            return model
//        }
//        set {
//            UserDefaults.standard.set(newValue., forKey: "userModel")
//        }
//    }
}

struct UserModel: HandyJSON {
    var nickName = ""
    var phoneNumber = ""
}
