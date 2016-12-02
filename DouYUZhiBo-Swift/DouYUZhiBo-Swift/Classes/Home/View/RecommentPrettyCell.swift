//
//  RecommentPrettyCell.swift
//  DouYUZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/22.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit
import Kingfisher
class RecommentPrettyCell: UICollectionViewCell {
    @IBOutlet weak var citylabel: UIButton!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    var PreCellRecomModel:RecommendModel?{
        didSet{
        self.citylabel.setTitle(PreCellRecomModel?.anchor_city, for: .normal)
        self.namelabel.text = PreCellRecomModel?.room_name
            var onlineStr:String = ""
            onlineStr = "\((PreCellRecomModel?.online)!)"
        self.onlineBtn.setTitle(onlineStr , for: .normal)
            guard let iconURL = URL(string:(PreCellRecomModel?.vertical_src)!) else {
                return
            }
            self.iconImageView.kf.setImage(with: iconURL)
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
