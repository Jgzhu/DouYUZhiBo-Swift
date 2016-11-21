//
//  HomeViewController.swift
//  DouYuZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/18.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    fileprivate lazy var pageTitleview: PageTitleView = {
        let TitleviewFrame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 44)
        let titles = ["推荐","游戏","娱乐","趣玩"]
    let pageTitleview = PageTitleView(frame: TitleviewFrame, titles: titles)
       // pageTitleview.backgroundColor = UIColor.gray
    return pageTitleview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //更新UI
        SetUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension HomeViewController{
    //更新UI
    fileprivate func SetUI(){
        automaticallyAdjustsScrollViewInsets = false
    //设置导航栏
        SetNavItem()
    //设置titleView
     view.addSubview(pageTitleview)
    
    }
    
    private func SetNavItem(){
    //设置左侧Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imagename: "logo", hightImagename: "", size: CGSize.zero)
    //设置右侧Item

        let btnsize = CGSize(width: 40, height: 40)

        let historyItem = UIBarButtonItem(imagename: "image_my_history", hightImagename: "Image_my_history_click", size: btnsize)
        
        let searchItem = UIBarButtonItem(imagename: "btn_search", hightImagename: "btn_search_clicked", size: btnsize)
        
        let qrcodeItem = UIBarButtonItem(imagename: "Image_scan", hightImagename: "Image_scan_click", size: btnsize)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
    
}




