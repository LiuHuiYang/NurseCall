//
//  SHUrgentViewController.swift
//  NurseCall
//
//  Created by Apple on 2019/3/15.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

/// cell重用标示符
private let urgentCellReuseIdentifier =
    "SHUrgentCollectionCell"

class SHUrgentViewController: SHViewController {
    
    /// 列表
    @IBOutlet weak var listView: UICollectionView!
    
}

// MARK: - UICollectionViewDataSource
extension SHUrgentViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return SHServiceTools.shared.services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: urgentCellReuseIdentifier,
                for: indexPath
            ) as! SHUrgentCollectionCell
        
        cell.service = SHServiceTools.shared.services[indexPath.item];
        
        return cell
    }
}


// MARK: - UI初始化
extension SHUrgentViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        listView.register(UINib(nibName:
            urgentCellReuseIdentifier,
                                bundle: nil),
                          forCellWithReuseIdentifier: urgentCellReuseIdentifier
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let itemMarign: CGFloat = statusBarHeight
        let totalCols = 1
        
        let itemWidth =
            (listView.bounds.width - CGFloat(totalCols) * itemMarign) / CGFloat(totalCols
        )
        
        let itemHeight =
            SHUrgentCollectionCell.itemHeight
        
        let flowLayout =
            listView.collectionViewLayout as!
        UICollectionViewFlowLayout
        
        flowLayout.minimumLineSpacing = itemMarign
        flowLayout.minimumInteritemSpacing = itemMarign
        
        flowLayout.itemSize =
            CGSize(width: itemWidth,
                   height: itemHeight
        )
        
    }
}
