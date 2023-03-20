//
//  ScreenShotCollectionViewCell.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/19.
//

import UIKit

class ScreenShotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout() {
        
        mainImageView.clipsToBounds = true
        mainImageView.layer.cornerRadius = 20
        mainImageView.layer.borderWidth = 1
        mainImageView.layer.borderColor = RowColorAsset.defaultImageColor.load()?.cgColor
    }
}
