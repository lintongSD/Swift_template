//
//  AppInfo.swift
//  project
//
//  Created by lintong on 2019/8/21.
//  Copyright © 2019 lintong. All rights reserved.
//

import UIKit

//MARK: App信息

// app名
let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String

// bundleId
let bundleId = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String

// app版本
let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String


let jpushId = "aaaa"

// appName要保证和bugly一致
let buglyId = ""
