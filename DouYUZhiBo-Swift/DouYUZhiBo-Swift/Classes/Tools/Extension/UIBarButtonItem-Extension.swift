//
//  UIBarButtonItem-Extension.swift
//  DouYuZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/18.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    convenience init(imagename: String,hightImagename: String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imagename), for: .normal)
        if hightImagename != "" {
            
            btn.setImage(UIImage(named: hightImagename), for: .highlighted)

        }
        if size == CGSize.zero {
          btn .sizeToFit()
        }else{
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }

}
