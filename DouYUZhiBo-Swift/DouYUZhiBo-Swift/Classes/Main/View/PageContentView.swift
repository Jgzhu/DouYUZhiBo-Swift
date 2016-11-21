//
//  PageContentView.swift
//  DouYUZhiBo-Swift
//
//  Created by 江贵铸 on 2016/11/21.
//  Copyright © 2016年 江贵铸. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
    // var targetIndex : Int = 0
    //var souceIndex : Int = 0
   // var progress : CGFloat = 0
    func PageContentScroll(souceIndex:Int,targetIndex:Int,progress:CGFloat)
}

private let ContentCellID = "ContentCellID"
class PageContentView: UIView{
    weak var delegate: PageContentViewDelegate?
    fileprivate var isForbidScrollDelegate : Bool = false
    fileprivate var currentOffsetX: CGFloat = 0.0
    fileprivate var targetIndex : Int = 0
    fileprivate var souceIndex : Int = 0
    fileprivate var progress : CGFloat = 0
    fileprivate var ContentVC: [UIViewController] = [UIViewController]()
    fileprivate lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    init(frame: CGRect,ContentVC: [UIViewController]) {
        self.ContentVC = ContentVC
        super.init(frame: frame)
        self.backgroundColor = UIColor.brown
        SetUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//设置UI
extension PageContentView{
    fileprivate func SetUI(){
    addSubview(collectionView)
    collectionView.frame = bounds
    }
}
//UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ContentVC.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = ContentVC[indexPath.item]
        childVC.view.frame = cell.contentView.frame
        cell.contentView.addSubview(childVC.view)
        return cell
    }
    
}
extension PageContentView: UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        currentOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate == true {
            return
        }
        let currentIndex = scrollView.contentOffset.x/scrollView.frame.size.width
        
       
        if currentOffsetX > scrollView.contentOffset.x {
            //向右滑动
            
            if currentOffsetX-scrollView.contentOffset.x == scrollView.frame.size.width {
              progress = CGFloat(1)
            }else{
                targetIndex = Int(currentIndex)
                souceIndex = Int(currentIndex + CGFloat(1.0))
                progress = CGFloat(souceIndex)-currentIndex
            }
            
        }else{
        //向左滑动
           
            if scrollView.contentOffset.x-currentOffsetX == scrollView.frame.size.width {
                progress = CGFloat(1)
            }else{
                souceIndex = Int(currentIndex)
                if souceIndex<ContentVC.count-1 {
                 targetIndex = Int(currentIndex + CGFloat(1.0))
                }
                progress = currentIndex-CGFloat(souceIndex)
            }

        }
//        print("原始\(souceIndex)----目标\(targetIndex)---比例\(progress)")
        delegate?.PageContentScroll(souceIndex: souceIndex, targetIndex: targetIndex, progress: progress)
    }

}

extension PageContentView{
    func ScrollToPageContent(selectindex: Int) {
        isForbidScrollDelegate = true
        let offset = CGFloat(selectindex) * collectionView.frame.size.width
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
    }
}
