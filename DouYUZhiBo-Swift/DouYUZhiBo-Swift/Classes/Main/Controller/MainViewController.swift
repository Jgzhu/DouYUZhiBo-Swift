//
//  MainViewController.swift
//  DouYuZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/17.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVcWithStoryboardName(name: "Home");
        addChildVcWithStoryboardName(name: "Live");
        addChildVcWithStoryboardName(name: "Follow");
        addChildVcWithStoryboardName(name: "Profile");
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension MainViewController{
    //添加子控制器到TabbarController上面去
    fileprivate func addChildVcWithStoryboardName(name:String){
        let childVC = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!;
        addChildViewController(childVC);
        
    }
}
