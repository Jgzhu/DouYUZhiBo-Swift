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
        let titles = ["推荐","游戏","娱乐","趣玩","测试"]
    let pageTitleview = PageTitleView(frame: TitleviewFrame, titles: titles)
       pageTitleview.delegate = self
    return pageTitleview
    }()
    
    fileprivate lazy var pageContentView: PageContentView = {
        let PCViewFrame = CGRect(x: 0, y: 64+44, width: UIScreen.main.bounds.width, height: self.view.frame.size.height-64-44-(self.tabBarController?.tabBar.frame.size.height)!)
        let RecommendVC = RecommendViewController()
        //RecommendVC.view.backgroundColor = UIColor.yellow
        
        let VC2 = UIViewController()
        VC2.view.backgroundColor = UIColor.blue
        
        let VC3 = UIViewController()
        VC3.view.backgroundColor = UIColor.cyan
        
        let VC4 = UIViewController()
        VC4.view.backgroundColor = UIColor.magenta
        
        let VC5 = UIViewController()
        VC5.view.backgroundColor = UIColor.purple
        
        let ContentVC: [UIViewController] = [RecommendVC,VC2,VC3,VC4,VC5]
        
       let PCView = PageContentView(frame: PCViewFrame, ContentVC: ContentVC)
        PCView.delegate = self
    return PCView
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
    //设置ContentView
    view.addSubview(pageContentView)
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

extension HomeViewController:PageTitleViewDelegate{
    func pageTitleViewClick(titleView: PageTitleView, selectIndex: Int) {
        print("\(selectIndex)")
        pageContentView.ScrollToPageContent(selectindex: selectIndex)
    }

}

extension HomeViewController:PageContentViewDelegate{
    func PageContentScroll(souceIndex: Int, targetIndex: Int, progress: CGFloat) {
        pageTitleview.ScrollTitle(souceIndex: souceIndex, targetIndex: targetIndex, progress: progress)
      // print("原始\(souceIndex)----目标\(targetIndex)---比例\(progress)")
    }

}

