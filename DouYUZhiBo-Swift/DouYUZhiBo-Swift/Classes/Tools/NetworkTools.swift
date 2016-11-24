//
//  NetworkTools.swift
//  DouYUZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/22.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case get,post
}

class NetworkTools{
    class func requestData(type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any)->()) {
        let method = type == MethodType.get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else{
            print("\(response.result.error)")
                return
            }
            finishedCallback(result)
        }
    }
    
}
