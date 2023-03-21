//
//  MainViewController.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/19.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    // titleView
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var searchTitleView: UIView!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTilteViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var deleteButtonConstraintWidth: NSLayoutConstraint!
    
    // containerView
    @IBOutlet var recentSearchView: UIView!
    @IBOutlet var appSearchResultView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    let popupView = PopupView()
    var appData = [AppInfoResult]()
    let placeholderImage = UIImage(named: "noimage")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configuereSearch()
        configureCollectionView()
    }

    // 검색 화면 구성
    private func setupLayout() {
        popupView.delegate = self
        self.searchTilteViewConstraintHeight.constant = 100
        self.deleteButtonConstraintWidth.constant = 0
        
        
        // profileImageView 클릭시 팝업 -> 내 소개
        profileButton.addTarget(self, action: #selector(profileImageViewAction), for: .touchUpInside)
        
        // 검색어 입력시 -> 검색 리스트
        
        // 키보드 리턴 키 변경
        searchTextField.returnKeyType = .search
        searchView.clipsToBounds = true
        searchView.layer.cornerRadius = 10
        
        recentSearchView.isHidden = false
        appSearchResultView.isHidden = true
    }
    
    // action - 취소 버튼
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        // 취소버튼 클릭 -> searchTitleview height 100 (anim)
        //           -> textField ""
        //           -> 취소버튼 사라지기 (anim)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchTilteViewConstraintHeight.constant = 100
            self.deleteButtonConstraintWidth.constant = 0
            
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.searchTitleView.isHidden = false
        })
        
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        
        recentSearchView.isHidden = false
        appSearchResultView.isHidden = true
    }
    
    // action - 검색 필드
    @IBAction func searchTextFieldAction(_ sender: UITextField) {
        // 검색 필드 포커스시 -> searchTitleview height 0 (anim)
        //               -> 취소버튼 보이기
        //               -> 키보드 올라오기
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchTilteViewConstraintHeight.constant = 0
            self.deleteButtonConstraintWidth.constant = 55
            self.searchTitleView.isHidden = true
            self.view.layoutIfNeeded()
        })
        
        searchTextField.becomeFirstResponder()
    }
    
    // action - 프로필 버튼
    @objc func profileImageViewAction(sender: UIButton!) {
        popupView.showAlert(message: "안녕하세요!\nName : 김소영\nE-mail : ksy0310007@naver.com\nblog : https://dev-sso.tistory.com/", alertType: .profileAlert)
    }
    
}

// textField -> 검색
extension MainViewController: UITextFieldDelegate {
    
    func configuereSearch() {
        searchTextField.delegate = self
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 검색
        textField.resignFirstResponder()
        
        if textField.text != nil {
            recentSearchView.isHidden = true
            appSearchResultView.isHidden = false
            
            self.appData.removeAll()
            AppStoreNetworkManager.shared.getAppData(searchText: textField.text!) { data in
                
                if data != nil {
                    self.appData = data
                    DispatchQueue.main.async {
                        // collectionview 제일 위로 이동
                        self.collectionView.scrollToItem(at: IndexPath(row: -1, section: 0), at: .top, animated: true)
                        self.collectionView.reloadData()
                    }
                } else {
                    print("Network fail", data)
                }
                
            }
            
            
        }else{
            // 검색어가 없을때 알럿
            let alert = UIAlertController(title: "알림", message: "검색어를 입력하세요.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
        }
        return true
    }
}

// collectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "AppSearchCollectionViewCell", bundle: nil)
        , forCellWithReuseIdentifier: "appSearchCollectionViewCell")
    }
    
    // collectionView cell count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appSearchCollectionViewCell", for: indexPath) as! AppSearchCollectionViewCell
        
        cell.appNameLabel.text = self.appData[indexPath.row].artistName
        
        let iconUrl = URL(string: self.appData[indexPath.row].artworkUrl60!)
        cell.appIconImageView.kf.setImage(with: iconUrl,placeholder: placeholderImage)
        
        cell.appDescriptionLabel.text = self.appData[indexPath.row].kind
        
        let ratingCount = round(self.appData[indexPath.row].averageUserRating ?? 0)
        
        cell.countString = String(ratingCount)
        cell.setRatingGraph()
        
        let count = self.appData[indexPath.row].userRatingCountForCurrentVersion ?? 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        let result = numberFormatter.string(from: NSNumber(value: count))
        cell.userRatingCountLabel.text = result
        
        let screenshotFirstUrl = URL(string: self.appData[indexPath.row].screenshotUrls![0])
        let screenshotSecondUrl = URL(string: self.appData[indexPath.row].screenshotUrls![1])
        let screenshotThirdUrl = URL(string: self.appData[indexPath.row].screenshotUrls![2])
        cell.screenShotFirstImageView.kf.setImage(with: screenshotFirstUrl,placeholder: placeholderImage)
        cell.screenShotSecondImageView.kf.setImage(with: screenshotSecondUrl,placeholder: placeholderImage)
        cell.screenShotThirdImageView.kf.setImage(with: screenshotThirdUrl,placeholder: placeholderImage)
        
         return cell
    }
    
    // collectionView cell size
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.bounds.width
        return CGSize(width: width, height: 400)

    }
    
    // collectionView cell select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailView = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        detailView.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        self.presentDetail(detailView)
    }
}

// popupView
extension MainViewController: PopupViewDelegate {
    func onOkButtonAction() {
        return
    }
}
