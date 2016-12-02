//
//  RecommendGroupModel.swift
//  DouYUZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/24.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit

class RecommendGroupModel: NSObject {
    var room_list:[[String:Any]]? {
        didSet{
            guard let room_list = room_list  else {
                return
            }
            for dict in room_list {
               RecomModel.append(RecommendModel(dict: dict))
            }
        }
    }
//每一组显示的图标
    var name_icon:String = "home_header_normal"
    var tag_name : String = ""
    var icon_url : String = ""
//每一组里面对应的模型数组
    lazy var RecomModel:[RecommendModel] = [RecommendModel]()
    override init() {
        super.init()
    }
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
