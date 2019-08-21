//
//  AppInfo.swift
//  project
//
//  Created by EBIZM2 on 2019/8/21.
//  Copyright © 2019 EBIZM2. All rights reserved.
//

import UIKit

//MARK: App信息

// app名
let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String

// bundleId
let bundleId = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String

// app版本
let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
