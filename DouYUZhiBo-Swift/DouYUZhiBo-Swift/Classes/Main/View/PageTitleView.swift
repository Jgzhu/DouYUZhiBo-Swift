//
//  PageTitleView.swift
//  DouYuZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/18.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    fileprivate var titles : [String]
    fileprivate lazy var ScrollView : UIScrollView = {
    let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.scrollsToTop = false
        scrollview.bounces = false
    return scrollview
    }()
    fileprivate lazy var titleLables: [UILabel] = [UILabel]()
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        //更新UI
        SetUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView{
    fileprivate func SetUI(){
    //添加ScrollView
      addSubview(ScrollView)
        ScrollView.frame = bounds
        //设置TitleLable
      SetTitleToTitleView()
    
    }
    
    fileprivate func SetTitleToTitleView(){
        
        var LableX: CGFloat = 0
        let LableY: CGFloat = 0
        let titlesCount: CGFloat = CGFloat(titles.count)
        
        let LableW: CGFloat = UIScreen.main.bounds.width/titlesCount
        for (index, titlestring) in titles.enumerated() {
            //创建label
            let titlelabel  = UILabel()
            titlelabel.text = titlestring
            titlelabel.tag = index
            titlelabel.font = UIFont.systemFont(ofSize: 16)
            titlelabel.textColor = UIColor.gray
            titlelabel.textAlignment = .center
            //titlelabel.backgroundColor = UIColor.black
            //titlelabel .sizeToFit()
            //设置label的Frame
            var frame = titlelabel.frame
            frame.origin.x = LableX
            frame.origin.y = LableY
            frame.size.height = self.frame.size.height-1
            frame.size.width = LableW
            titlelabel.frame = frame

            LableX += titlelabel.bounds.size.width
            //添加到scrollview
            ScrollView.addSubview(titlelabel)
            
        }
        //添加长下划线
        let longline = UIView()
        longline.backgroundColor = UIColor.lightGray
        longline.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.size.width, height: 1)
        self.addSubview(longline)
        
        //添加短下划线
        let shortline = UIView()
        shortline.backgroundColor = UIColor.orange
        shortline.frame = CGRect(x: 0, y: self.frame.size.height-2, width: LableW, height: 1)
        ScrollView.addSubview(shortline)
    
    
    }
}
