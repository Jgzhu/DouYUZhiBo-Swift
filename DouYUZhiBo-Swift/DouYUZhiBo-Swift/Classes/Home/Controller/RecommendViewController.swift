//
//  RecommendViewController.swift
//  DouYUZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/22.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit

private let kitemMargin:CGFloat = 10
private let kitemW = (UIScreen.main.bounds.size.width-3*kitemMargin)/2
private let kNormalItemH = kitemW*3/4
private let kPrettyItemH = kitemW*4/3
private let kHeaderViewH:CGFloat = 50
private let kNormalCellID:String = "RecommentNormalCell"
private let kPrettyCellID:String = "RecommentPrettyCell"
private let kHeaderID:String = "RecommentCollectionHeaderView"
class RecommendViewController: UIViewController {
    fileprivate lazy var RecommentVM = RecommendViewModel()
    fileprivate lazy var collectionview : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kitemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kitemMargin
        layout.sectionInset = UIEdgeInsetsMake(0, kitemMargin, 0, kitemMargin)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: kHeaderViewH)
    let Collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        Collectionview.autoresizingMask = [UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleWidth]
        Collectionview.delegate = self
        Collectionview.dataSource = self
        Collectionview.register(UINib(nibName: "RecommentNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
         Collectionview.register(UINib(nibName: "RecommentPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        Collectionview.register( UINib(nibName: "RecommentCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderID)

        return Collectionview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

//设置UI
extension RecommendViewController{
    fileprivate func SetUI(){
    view.backgroundColor = UIColor.white
    view.addSubview(collectionview)
    collectionview.backgroundColor = UIColor.white
      RecommentVM.requestData { 
        print("---")
        }
    }
}
//UICollectionViewDataSource数据源
extension RecommendViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section==0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if indexPath.section==1 {
            cell = (collectionview.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as? RecommentPrettyCell)!
            cell.backgroundColor = UIColor.white
    
        }else{
        cell = (collectionview.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as?RecommentNormalCell)!
        cell.backgroundColor = UIColor.white
        
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerview = collectionview.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath)
        return headerview
    }
}
//UICollectionViewDelegate代理
extension RecommendViewController:UICollectionViewDelegate{
   

}
//UICollectionViewDelegateFlowLayout代理
extension RecommendViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section==1 {
           return CGSize(width: kitemW, height: kPrettyItemH)
        }else{
        return CGSize(width: kitemW, height: kNormalItemH)
        }
    }
}
