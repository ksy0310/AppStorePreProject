//
//  AppSearchCollectionViewCell.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/19.
//

import UIKit

class AppSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var appIconImageView: UIImageView!
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var appDescriptionLabel: UILabel!
    
    @IBOutlet var userRatingCountLabel: UILabel!
    
    @IBOutlet var starOneImageView: UIImageView!
    @IBOutlet var starTwoImageView: UIImageView!
    @IBOutlet var starThreeImageView: UIImageView!
    @IBOutlet var starFourImageView: UIImageView!
    @IBOutlet var starFiveImageView: UIImageView!
    
    @IBOutlet var downloadButton: UIButton!
    
    @IBOutlet var screenShotFirstImageView: UIImageView!
    @IBOutlet var screenShotSecondImageView: UIImageView!
    @IBOutlet var screenShotThirdImageView: UIImageView!
    
    var isDownload = false
    var countString = "0.0"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    // collectionView cell layout 구성
    private func setupLayout() {
        
        appIconImageView.clipsToBounds = true
        appIconImageView.layer.cornerRadius = 20
        
        downloadButton.clipsToBounds = true
        downloadButton.layer.cornerRadius = 15
        
        screenShotFirstImageView.clipsToBounds = true
        screenShotFirstImageView.layer.cornerRadius = 20
        screenShotSecondImageView.clipsToBounds = true
        screenShotSecondImageView.layer.cornerRadius = 20
        screenShotThirdImageView.clipsToBounds = true
        screenShotThirdImageView.layer.cornerRadius = 20
        
        isDownload = false
        setRatingGraph()
    }
    
    public func setRatingGraph() {
        switch countString {
            case "5.0":
                starOneImageView.image = UIImage(named: "star")
                starTwoImageView.image = UIImage(named: "star")
                starThreeImageView.image = UIImage(named: "star")
                starFourImageView.image = UIImage(named: "star")
                starFiveImageView.image = UIImage(named: "star")
            
            case "4.0":
                starOneImageView.image = UIImage(named: "star")
                starTwoImageView.image = UIImage(named: "star")
                starThreeImageView.image = UIImage(named: "star")
                starFourImageView.image = UIImage(named: "star")
                starFiveImageView.image = UIImage(named: "star_empty")
            
            case "3.0":
                starOneImageView.image = UIImage(named: "star")
                starTwoImageView.image = UIImage(named: "star")
                starThreeImageView.image = UIImage(named: "star")
                starFourImageView.image = UIImage(named: "star_empty")
                starFiveImageView.image = UIImage(named: "star_empty")
            
            case "2.0":
                starOneImageView.image = UIImage(named: "star")
                starTwoImageView.image = UIImage(named: "star")
                starThreeImageView.image = UIImage(named: "star_empty")
                starFourImageView.image = UIImage(named: "star_empty")
                starFiveImageView.image = UIImage(named: "star_empty")
            
            case "1.0":
                starOneImageView.image = UIImage(named: "star")
                starTwoImageView.image = UIImage(named: "star_empty")
                starThreeImageView.image = UIImage(named: "star_empty")
                starFourImageView.image = UIImage(named: "star_empty")
                starFiveImageView.image = UIImage(named: "star_empty")
                   
            default:
                starOneImageView.image = UIImage(named: "star_empty")
                starTwoImageView.image = UIImage(named: "star_empty")
                starThreeImageView.image = UIImage(named: "star_empty")
                starFourImageView.image = UIImage(named: "star_empty")
                starFiveImageView.image = UIImage(named: "star_empty")
        }
    }
    
    
    @IBAction func downloadButtonAction(_ sender: UIButton) {
        
        if isDownload {
            downloadButton.setTitle("열기", for: .normal)
            downloadButton.setTitleColor(RowColorAsset.subBackgroundColor.load(), for: .normal)
            
            downloadButton.backgroundColor = RowColorAsset.pointBlueColor.load()
            isDownload = false
            
        } else {
            downloadButton.setTitle("받기", for: .normal)
            downloadButton.setTitleColor(RowColorAsset.pointBlueColor.load(), for: .normal)
            
            downloadButton.backgroundColor = RowColorAsset.subBackgroundColor.load()
            isDownload = true
        }
        
    }
    
}
