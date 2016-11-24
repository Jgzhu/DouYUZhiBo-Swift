//
//  RecommendViewModel.swift
//  DouYUZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/22.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit

class RecommendViewModel{
//请求数据
    func requestData(finishCallback : @escaping ()->()) {
        //let param = ["limit" : "4", "offset" : "0", "time" : Date.GetCurrentTime()]
        
        //请求第一部分数据
        
        NetworkTools.requestData(type: MethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.GetCurrentTime()]) { (result) in
            print(result)
            finishCallback()
        }
    }
}
