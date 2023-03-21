//
//  ScreenShotCollectionViewCell.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/19.
//

import UIKit

class ScreenShotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout() {
        
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 20
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = RowColorAsset.defaultImageColor.load()?.cgColor
    }
}
