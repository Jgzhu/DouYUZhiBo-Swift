//
//  NSDate-Extension.swift
//  DouYUZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/22.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import Foundation

extension Date{
   static func GetCurrentTime() -> String {
        let nowdate = Date()
        let interval = Int(nowdate.timeIntervalSince1970)
        
       return "\(interval)"
    }

}
