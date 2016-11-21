//
//  PageTitleView.swift
//  DouYuZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/18.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit
protocol PageTitleViewDelegate: class {
    func pageTitleViewClick(titleView:PageTitleView,selectIndex:Int)
}
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
class PageTitleView: UIView {
    weak var delegate : PageTitleViewDelegate?
    fileprivate var titles : [String]
    fileprivate var currentIndex: Int = 0
    fileprivate lazy var ScrollView : UIScrollView = {
    let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.scrollsToTop = false
        scrollview.bounces = false
    return scrollview
    }()
    fileprivate lazy var shortline: UIView = {
    let shortline = UIView()
        shortline.backgroundColor = UIColor(red: kSelectColor.0 / 255.0, green: kSelectColor.1 / 255.0, blue: kSelectColor.2 / 255.0, alpha: 1)
        return shortline
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
            titlelabel.textColor = UIColor(red: kNormalColor.0 / 255.0, green: kNormalColor.1 / 255.0, blue: kNormalColor.2 / 255.0, alpha: 1)
            titlelabel.textAlignment = .center
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
            titleLables.append(titlelabel)
         //添加Label点击
            titlelabel.isUserInteractionEnabled = true
            let tap =  UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            titlelabel.addGestureRecognizer(tap)
            
        }
        //添加长下划线
        let longline = UIView()
        longline.backgroundColor = UIColor.lightGray
        longline.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.size.width, height: 1)
        self.addSubview(longline)
        
        //添加短下划线
        let firstLabel = titleLables[0]
        firstLabel.textColor = UIColor(red: kSelectColor.0 / 255.0, green: kSelectColor.1 / 255.0, blue: kSelectColor.2 / 255.0, alpha: 1)
        shortline.frame = CGRect(x: 0, y: self.frame.size.height-3, width: firstLabel.bounds.size.width, height: 2)
        ScrollView.addSubview(shortline)

    }
    //点击title
    @objc private func titleLabelClick(_ tap: UITapGestureRecognizer) {
        print("\(tap.view?.tag)")
        guard let tapview = tap.view else{return}
        let index = tapview.tag
        ScrollTitle(souceIndex: currentIndex, targetIndex: index, progress: 1)
        delegate?.pageTitleViewClick(titleView: self, selectIndex: index)
    }
   
}

extension PageTitleView{
    //滚动title
    func ScrollTitle(souceIndex: Int, targetIndex: Int, progress: CGFloat){
        var tempprogress = progress
        if tempprogress>0.9 {
            tempprogress=CGFloat(1)
        }
        let newLabel = titleLables[targetIndex]
        let oldLabel = titleLables[souceIndex]
        
        currentIndex = targetIndex
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        newLabel.textColor = UIColor(red: (kNormalColor.0+colorDelta.0*tempprogress) / 255.0, green: (kNormalColor.1+colorDelta.1*tempprogress) / 255.0, blue: (kNormalColor.2+colorDelta.2*tempprogress) / 255.0, alpha: 1)
        oldLabel.textColor = UIColor(red: (kSelectColor.0-colorDelta.0*tempprogress) / 255.0, green: (kSelectColor.1-colorDelta.1*tempprogress) / 255.0, blue: (kSelectColor.2-colorDelta.2*tempprogress) / 255.0, alpha: 1)
        var NewX: CGFloat = 0
        if (newLabel.frame.origin.x-oldLabel.frame.origin.x)>0 {
            NewX = oldLabel.frame.origin.x + (newLabel.frame.origin.x-oldLabel.frame.origin.x)*tempprogress
        }else{
            NewX = oldLabel.frame.origin.x - (oldLabel.frame.origin.x-newLabel.frame.origin.x)*tempprogress
        }
        UIView.animate(withDuration: 0.25, animations: {
            
            self.shortline.frame.origin.x = NewX
            self.shortline.frame.size.width = newLabel.frame.size.width
        })
    }

}
