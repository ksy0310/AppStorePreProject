//
// user RatingCount 화면.
//
//  AppUserRatingCountView.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/20.
//

import UIKit

class AppUserRatingCountView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet var totalCountLabel: UILabel!
    
    @IBOutlet var graphFiveRatingView: UIView!
    @IBOutlet var graphFourRatingView: UIView!
    @IBOutlet var graphThreeRatingView: UIView!
    @IBOutlet var graphTwoRatingView: UIView!
    @IBOutlet var graphOneRatingView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadXib()
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    private func loadXib() {
        Bundle.main.loadNibNamed("AppUserRatingCountView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        setupLayout()
    }
    
    // 화면 구성
    private func setupLayout() {
        graphFiveRatingView.clipsToBounds = true
        graphFiveRatingView.layer.cornerRadius = 5

        graphFourRatingView.clipsToBounds = true
        graphFourRatingView.layer.cornerRadius = 5

        graphThreeRatingView.clipsToBounds = true
        graphThreeRatingView.layer.cornerRadius = 5

        graphTwoRatingView.clipsToBounds = true
        graphTwoRatingView.layer.cornerRadius = 5

        graphOneRatingView.clipsToBounds = true
        graphOneRatingView.layer.cornerRadius = 5
    }

    // 별점 데이터-그래프 set
    public func setDataRatingGraphView(reviewCountString: String, ratingCountString: String) {
        ratingCountLabel.text = ratingCountString
        totalCountLabel.text = reviewCountString + "개의 평가"

        let count = ratingCountString
        let countString = count[count.startIndex]

        switch countString {
            case "5":
                //5점
            graphFiveRatingView.backgroundColor = RowColorAsset.mainTextColor.load()
            graphFourRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphThreeRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphTwoRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphOneRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            
            case "4":
                //4점
            graphFiveRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphFourRatingView.backgroundColor = RowColorAsset.mainTextColor.load()
            graphThreeRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphTwoRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphOneRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()

            case "3":
                //3점
            graphFiveRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphFourRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphThreeRatingView.backgroundColor = RowColorAsset.mainTextColor.load()
            graphTwoRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphOneRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
               
            case "2":
                //2점
            graphFiveRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphFourRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphThreeRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphTwoRatingView.backgroundColor = RowColorAsset.mainTextColor.load()
            graphOneRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            
            case "1":
                //1점
            graphFiveRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphFourRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphThreeRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphTwoRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphOneRatingView.backgroundColor = RowColorAsset.mainTextColor.load()
            
            default:
                //0점,점수없음
            graphFiveRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphFourRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphThreeRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphTwoRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
            graphOneRatingView.backgroundColor = RowColorAsset.subBackgroundColor.load()
        }
    }
}
