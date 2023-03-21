//
//  InfoViewController.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/20.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet var userRatingCountView: AppUserRatingCountView!
    
    @IBOutlet var starFirstButton: UIButton!
    @IBOutlet var starTwoButton: UIButton!
    @IBOutlet var starThreeButton: UIButton!
    @IBOutlet var starFourButton: UIButton!
    @IBOutlet var starFiveButton: UIButton!
    
    var selectRatingCount = 0
    let popupView = PopupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
    }
    
    // 정보 화면 구성
    private func setupLayout() {
        userRatingCountView.detailButton.isHidden = true
        userRatingCountView.setDataRatingGraphView(reviewCountString: "11,260", ratingCountString: "5.0")
        
        popupView.delegate = self
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismissDetail()
    }
    
    @IBAction func starButtonActions(_ sender: UIButton) {
        
        switch sender.tag {
            case 1:
            // 1점
                selectRatingCount = 1
                starFirstButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starTwoButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
                starThreeButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
                starFourButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
                starFiveButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
            
            case 2:
            // 2점
                selectRatingCount = 2
                starFirstButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starTwoButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starThreeButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
                starFourButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
                starFiveButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
            case 3:
            // 3점
                selectRatingCount = 3
                starFirstButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starTwoButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starThreeButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starFourButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
                starFiveButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
            case 4:
            // 4점
                selectRatingCount = 4
                starFirstButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starTwoButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starThreeButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starFourButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starFiveButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
            case 5:
            // 5점
                selectRatingCount = 5
                starFirstButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starTwoButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starThreeButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starFourButton.setImage(UIImage(named: "bluestar"), for: .normal)
                starFiveButton.setImage(UIImage(named: "bluestar"), for: .normal)
            default:
            // 0점
                selectRatingCount = 0
                starFirstButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
                starTwoButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
                starThreeButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
                starFourButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
                starFiveButton.setImage(UIImage(named: "bluestar_empty"), for: .normal)
        }
//        writeReview(score: selectRatingCount)
        popupView.showAlert(message: "피드백을 보내주셔서 감사합니다.", alertType: .notiAlert)
    }
    
    private func writeReview(score:Int) {
        var itunesItemId = 1258016944
        if let appstoreURL = URL(string: "https://apps.apple.com/kr/app/id\(itunesItemId)") {
            var components = URLComponents(url: appstoreURL, resolvingAgainstBaseURL: false)
            components?.queryItems = [
              URLQueryItem(name: "action", value: "write-review"),
              URLQueryItem(name: "see-all", value: "reviews")
            ]
            guard let writeReviewURL = components?.url else {
                return
            }
            print(writeReviewURL)
            UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
        }
    }
}
// popupView
extension InfoViewController: PopupViewDelegate {
    func onOkButtonAction() {
        return
    }
}
