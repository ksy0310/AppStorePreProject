//
//  DetailViewController.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/19.
//


import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var mainScrollView: UIScrollView!
    
    var isDownload = false
    @IBOutlet var appIconImageView: UIImageView!
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var appDescriptionLabel: UILabel!
    @IBOutlet var downloadButton: UIButton!
    
    @IBOutlet var miniAppIconImageView: UIImageView!
    @IBOutlet var miniDownloadButton: UIButton!
    
    @IBOutlet var screenShotCollectionView: UICollectionView!
    
    @IBOutlet var navigationView: UIView!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var appTitleView: UIView!
    
    @IBOutlet var appSummaryView: UIView!
    @IBOutlet var summaryUserRatingCountView: UIView!
    @IBOutlet var summaryContentAdvisoryRatingView: UIView!
    @IBOutlet var summaryGenresView: UIView!
    @IBOutlet var summarySellerNameView: UIView!
    @IBOutlet var summaryLanguageCodesView: UIView!
    
    @IBOutlet var appScreenShotView: UIView!
    
    @IBOutlet var appInfoDescriptionViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var appInfoDescriptionView: UIView!
    @IBOutlet var appInfoDescriptionLabel: UILabel!
    @IBOutlet var appInfoDescriptionButton: UIButton!
    var isDescriptionOpenView = false
    
    @IBOutlet var appSellerInfoView: UIView!
    
    @IBOutlet var appRatingCountView: AppUserRatingCountView!
    
    @IBOutlet var appInfoTitleView: UIView!
    @IBOutlet var appInfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configureCollectionView()
        configureTableView()
        setData()
    }

    // 디테일 화면 구성
    private func setupLayout() {
        
        mainScrollView.delegate = self
        miniAppIconImageView.isHidden = true
        miniDownloadButton.isHidden = true
        
        isDownload = false
        appIconImageView.clipsToBounds = true
        appIconImageView.layer.cornerRadius = 20
        miniAppIconImageView.clipsToBounds = true
        miniAppIconImageView.layer.cornerRadius = 20
        downloadButton.clipsToBounds = true
        downloadButton.layer.cornerRadius = 15
        miniDownloadButton.clipsToBounds = true
        miniDownloadButton.layer.cornerRadius = 15
        
        isDescriptionOpenView = false
        appInfoDescriptionViewConstraintHeight.constant = 130

    }
    
    private func setData() {
        
        appInfoDescriptionLabel.frame.size = appInfoDescriptionLabel.intrinsicContentSize
        appInfoDescriptionLabel.sizeToFit()
        appInfoDescriptionLabel.text = "앱설명"
        if appInfoDescriptionLabel.frame.height < 130 {
            appInfoDescriptionButton.isHidden = true
        }
        
        // userRatingCountView
        appRatingCountView.detailButton.addTarget(self, action: #selector(detailButtonAction), for: .touchUpInside)
        appRatingCountView.setDataRatingGraphView(reviewCountString: "11,260", ratingCountString: "5.0")

    }
    
    
    // action - backButton
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismissDetail()
    }
    
    // action - share Button
    @IBAction func shareButtonAction(_ sender: UIButton) {
        let shareLink: String = "www.naver.com"
        var shareObject = [Any]()

        shareObject.append(shareLink)

        let activityViewController = UIActivityViewController(activityItems: shareObject, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // action - download Button
    @IBAction func downloadButtonAction(_ sender: UIButton) {
        
        if isDownload {
            downloadButton.setTitle("열기", for: .normal)
            downloadButton.setTitleColor(RowColorAsset.pointBlueColor.load(), for: .normal)
            
            downloadButton.backgroundColor = RowColorAsset.subBackgroundColor.load()
            
            miniDownloadButton.setTitle("열기", for: .normal)
            miniDownloadButton.setTitleColor(RowColorAsset.pointBlueColor.load(), for: .normal)
            
            miniDownloadButton.backgroundColor = RowColorAsset.subBackgroundColor.load()
            
            
            isDownload = false
            
        } else {
            downloadButton.setTitle("받기", for: .normal)
            downloadButton.setTitleColor(RowColorAsset.subBackgroundColor.load(), for: .normal)
            
            downloadButton.backgroundColor = RowColorAsset.pointBlueColor.load()
            
            miniDownloadButton.setTitle("받기", for: .normal)
            miniDownloadButton.setTitleColor(RowColorAsset.subBackgroundColor.load(), for: .normal)
            
            miniDownloadButton.backgroundColor = RowColorAsset.pointBlueColor.load()
            
            
            isDownload = true
        }
        
    }
    
    // action - detail Button
    @objc func detailButtonAction(sender: UIButton!) {
        let infoView = storyboard!.instantiateViewController(withIdentifier: "InfoViewController")
        infoView.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        
        self.presentDetail(infoView)
    }
    
    // 앱 설명 더보기/ 접기
    @IBAction func appInfoDescriptionButtonAction(_ sender: UIButton) {
        
        if isDescriptionOpenView {
            appInfoDescriptionViewConstraintHeight.constant = 130
            appInfoDescriptionButton.setTitle("더보기", for: .normal)
            isDescriptionOpenView = false
        } else {
            appInfoDescriptionViewConstraintHeight.constant = appInfoDescriptionLabel.frame.height
            appInfoDescriptionButton.setTitle("접기", for: .normal)
            isDescriptionOpenView = true
        }
        
    }
    
    
    
    
    // 메인 스크롤 위치에 따른 mini view
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == mainScrollView) {
            if (scrollView.contentOffset.y > 150.0) {
                self.miniAppIconImageView.isHidden = false
                self.miniDownloadButton.isHidden = false
            }else {
                self.miniAppIconImageView.isHidden = true
                self.miniDownloadButton.isHidden = true
            }
        }
    }
   
}

// collectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureCollectionView() {
        screenShotCollectionView.dataSource = self
        screenShotCollectionView.delegate = self
        
        screenShotCollectionView.register(UINib(nibName: "ScreenShotCollectionViewCell", bundle: nil)
        , forCellWithReuseIdentifier: "screenShotCollectionViewCell")
        
    }
    
    // collectionView cell count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenShotCollectionViewCell", for: indexPath) as! ScreenShotCollectionViewCell
        
         return cell
    }
    
    // collectionView cell size
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.bounds.width / 2
        return CGSize(width: width, height: 430)

    }
}

// tableView
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        appInfoTableView.delegate = self
        appInfoTableView.dataSource = self
        
        appInfoTableView.estimatedRowHeight = 50
        appInfoTableView.rowHeight = UITableView.automaticDimension
        
        appInfoTableView.register(UINib(nibName: "AppInfoBasicTableViewCell", bundle: nil), forCellReuseIdentifier: "AppInfoBasicTableViewCell")
        appInfoTableView.register(UINib(nibName: "AppInfoLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "AppInfoLinkTableViewCell")
        appInfoTableView.register(UINib(nibName: "AppInfoDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "AppInfoDetailTableViewCell")
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppInfoDetailTableViewCell",for: indexPath) as! AppInfoDetailTableViewCell
        
        return cell
    }
    
    
}
