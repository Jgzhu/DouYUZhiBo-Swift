//
//  RecommendViewModel.swift
//  DouYUZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/22.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit

class RecommendViewModel{

    fileprivate lazy var bigDataGroup:RecommendGroupModel = RecommendGroupModel()
    fileprivate lazy var prettyGroup:RecommendGroupModel = RecommendGroupModel()
    lazy var RecommendGroup : [RecommendGroupModel] = [RecommendGroupModel]()
}

extension RecommendViewModel{
    //请求数据
    func  requestData(finishCallback : @escaping ()->()) {
        let param = ["limit" : "4", "offset" : "0", "time" : Date.GetCurrentTime()]
        
        let dGroup = DispatchGroup()
        
        //请求第一部分数据
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1480567645
        dGroup.enter()
        NetworkTools.requestData(type: MethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.GetCurrentTime()]) { (result) in
            guard let resultDict = result as? [String:Any] else{return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{return}
            self.bigDataGroup.name_icon = "home_header_hot"
            self.bigDataGroup.tag_name = "热门"
            for dict in dataArray{
            
            self.bigDataGroup.RecomModel.append(RecommendModel(dict: dict))
            }
            print(self.bigDataGroup)
            dGroup.leave()
        }
        
        // 请求第二部分颜值数据
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1480567645
        dGroup.enter()
        NetworkTools.requestData(type: MethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: param) { (result) in
            guard let resultDict = result as? [String:Any] else{return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{return}
            self.prettyGroup.name_icon = "home_header_phone"
            self.prettyGroup.tag_name = "颜值"
            for dict in dataArray{
                
                self.prettyGroup.RecomModel.append(RecommendModel(dict: dict))
            }
            print(self.prettyGroup)
            dGroup.leave()
        }
        
        //请求游戏数据
        //"http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1480567645"

        dGroup.enter()
        NetworkTools.requestData(type: MethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: param) { (result) in
            guard let resultDict = result as? [String:Any] else{return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{return}
            //self.bigDataGroup.name_icon = "home_header_phone"
            //self.bigDataGroup.tag_name = "颜值"
            for dict in dataArray{
            self.RecommendGroup.append(RecommendGroupModel(dict: dict))
            }
            dGroup.leave()
        }
       dGroup.notify(queue: DispatchQueue.main) {
        self.RecommendGroup.insert(self.prettyGroup, at: 0)
        self.RecommendGroup.insert(self.bigDataGroup, at: 0)
        finishCallback()
        }
    }
}
