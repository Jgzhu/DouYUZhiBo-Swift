//
//  RecommentNormalCell.swift
//  DouYUZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/22.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit
import Kingfisher
class RecommentNormalCell: UICollectionViewCell {
    @IBOutlet weak var headimageview: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    var NormCellRecomModel:RecommendModel?{
        didSet{
        //self.headimageview
        self.roomNameLabel.text = NormCellRecomModel?.room_name
        self.nickNameLabel.text = NormCellRecomModel?.nickname
        self.onlineBtn.setTitle("\((NormCellRecomModel?.online)!)", for: UIControlState.normal)
            
            guard let iconURL = URL(string: (NormCellRecomModel?.vertical_src)!) else {
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
