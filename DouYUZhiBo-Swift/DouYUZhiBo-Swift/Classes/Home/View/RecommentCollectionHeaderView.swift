//
//  RecommentCollectionHeaderView.swift
//  DouYUZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/22.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit

class RecommentCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var headimageview: UIImageView!
    @IBOutlet weak var headtitleLbel: UILabel!
    var HeaderRecomGroupModel:RecommendGroupModel?{
        didSet{
        headtitleLbel.text = HeaderRecomGroupModel?.tag_name
        headimageview.image = UIImage(named: (HeaderRecomGroupModel?.name_icon)!)
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
