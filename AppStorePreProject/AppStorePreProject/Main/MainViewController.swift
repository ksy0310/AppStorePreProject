//
// AppStore search 화면.
//
//  MainViewController.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/19.
//

import UIKit
import Kingfisher
import CoreData

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
    
    // recentSearchView
    @IBOutlet var recentSearchTitleViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var recentSearchTitleView: UIView!
    @IBOutlet var tableView: UITableView!
    
    // coreData
    var recentSearchString:[NSManagedObject] = []
    var matchSearchString:[NSManagedObject] = []
    
    var isBeginEditing = false
    let popupView = PopupView()
    // 데이터
    var appData = [AppInfoResult]()
    let placeholderImage = UIImage(named: "noimage")
    
    //로딩
    let loading = LoadingIndicator.shared
    
    // context
    var context: NSManagedObjectContext! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configuereSearch()
        configureCollectionView()
        configureTableView()
    }
    
    // coredata load
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RecentSearch")
        do {
            recentSearchString = try context.fetch(fetchRequest)
        }  catch let error as NSError {
            print("\(error) : Could not fetch \(error.userInfo)")
        }
    }
    
    // 최근검색어 일치 항목
    func filter(text:String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RecentSearch")
        fetchRequest.predicate = NSPredicate(format: "searchString CONTAINS %@", text)
        do{
            matchSearchString = try context.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch let error{
            print("\(error) : Could not search")
        }
    }

    // 검색 화면 구성
    private func setupLayout() {
        popupView.delegate = self
        self.searchTilteViewConstraintHeight.constant = 100
        self.deleteButtonConstraintWidth.constant = 0
        
        // profileImageView 클릭시 팝업 -> 내 소개
        profileButton.addTarget(self, action: #selector(profileImageViewAction), for: .touchUpInside)
        
        // 키보드 리턴 키 변경
        searchTextField.returnKeyType = .search
        searchView.clipsToBounds = true
        searchView.layer.cornerRadius = 10
        
        // 최근 검색어 화면
        recentSearchView.isHidden = false
        appSearchResultView.isHidden = true
    }
    
    // action - deleteButton
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.searchTilteViewConstraintHeight.constant = 100
            self.deleteButtonConstraintWidth.constant = 0
            
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.searchTitleView.isHidden = false
        })
        
        // textField 초기화
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        
        recentSearchView.isHidden = false
        appSearchResultView.isHidden = true
        isBeginEditing = false
        matchSearchString.removeAll()
        
        self.tableView.reloadData()
    }
    
    // action - searchTextField
    @IBAction func searchTextFieldAction(_ sender: UITextField) {
        searchBeginAnimation()
    }
    
    // 검색 필드 포커스 시
    func searchBeginAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.searchTilteViewConstraintHeight.constant = 0
            self.deleteButtonConstraintWidth.constant = 55
            self.searchTitleView.isHidden = true
            self.view.layoutIfNeeded()
        })
        // 키보드
        searchTextField.becomeFirstResponder()
    }
    
    // action - profileImageView
    @objc func profileImageViewAction(sender: UIButton!) {
        popupView.showAlert(message: "안녕하세요!\nName : 김소영\nE-mail : ksy0310007@naver.com\nblog : https://dev-sso.tistory.com/", alertType: .profileAlert)
    }
    
    // 최근 검색어 저장
    func saveSearchString(searchString:String) {
        let entity = NSEntityDescription.entity(forEntityName: "RecentSearch", in: context)!
        let recentSearch = NSManagedObject(entity: entity, insertInto: context)
        recentSearch.setValue(searchString, forKey: "searchString")
        do {
            try context.save()
            self.recentSearchString.append(recentSearch)
        } catch let error as NSError {
            print("\(error) : Could not save \(error.userInfo)")
        }
    }
}

// textField -> 검색
extension MainViewController: UITextFieldDelegate {
    
    // textField 화면 구성
    func configuereSearch() {
        searchTextField.delegate = self
        self.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // 입력값이 변경 될 때마다 호출
    @objc func textFieldDidChange(_ sender: Any?) {
        isBeginEditing = true
        recentSearchTitleView.isHidden = true
        recentSearchTitleViewConstraintHeight.constant = 0
        
        let searchText = self.searchTextField?.text
        if searchText != nil && searchText != "" {
            filter(text: (self.searchTextField?.text)!)
        }
    }

    // 키보드 검색 버튼
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isBeginEditing = false
        recentSearchTitleView.isHidden = false
        recentSearchTitleViewConstraintHeight.constant = 56
        
        textField.resignFirstResponder()
        self.loading.showIndicator()
        
        if textField.text != nil {
            saveSearchString(searchString: textField.text!)
            self.tableView.reloadData()
            
            // 앱 검색
            searchData(searcText: textField.text!)
            
        }else{
            // 검색어가 없을때 알럿
            self.loading.hideIndicator()
            
            let alert = UIAlertController(title: "알림", message: "검색어를 입력하세요.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
        }
        return true
    }
    
    // 앱 검색 통신
    func searchData(searcText:String) {
        recentSearchView.isHidden = true
        appSearchResultView.isHidden = false
        
        self.appData.removeAll()
        AppStoreNetworkManager.shared.getAppData(searchText: searcText) { data in
            // 통신 완료
            self.appData = data
            DispatchQueue.main.async {
                // collectionview 제일 위로 이동
                self.collectionView.scrollToItem(at: IndexPath(row: -1, section: 0), at: .top, animated: true)
                self.collectionView.reloadData()
                        
                self.loading.hideIndicator()
            }
        }
    }
}

// collectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // collectionview 화면 구성
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
    
    // collectionView cell UI
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appSearchCollectionViewCell", for: indexPath) as! AppSearchCollectionViewCell
        
        cell.appNameLabel.text = self.appData[indexPath.row].trackName
        
        let iconUrl = URL(string: self.appData[indexPath.row].artworkUrl60!)
        cell.appIconImageView.kf.setImage(with: iconUrl,placeholder: placeholderImage)
        
        cell.appDescriptionLabel.text = self.appData[indexPath.row].description
        
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
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        detailViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        detailViewController.appInfo = self.appData[indexPath.row]
        self.presentDetail(detailViewController)
    }
}

// popupView
extension MainViewController: PopupViewDelegate {
    func onOkButtonAction() {
        return
    }
}

// RecentSearch
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    // RecentSearch tableView 화면 구성
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "RecentSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentSearchTableViewCell")
        tableView.register(UINib(nibName: "MatchSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchSearchTableViewCell")
    }
    
    // tableView cell count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isBeginEditing {
            return matchSearchString.count
        } else {
            return recentSearchString.count
        }
    }
    
    // tableView cell UI
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isBeginEditing {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MatchSearchTableViewCell", for: indexPath) as! MatchSearchTableViewCell
            cell.selectionStyle = .none
            cell.titleLabel.text = matchSearchString[indexPath.row].value(forKey: "searchString") as? String
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchTableViewCell", for: indexPath) as! RecentSearchTableViewCell
            cell.selectionStyle = .none
            cell.titleLabel.text = recentSearchString[indexPath.row].value(forKey: "searchString") as? String
            return cell
        }
    }
    
    // select cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isBeginEditing {
            let data = matchSearchString[indexPath.row].value(forKey: "searchString") as? String
            searchBeginAnimation()
            searchTextField.text = data!
            searchData(searcText: data!)
        } else {
            let data = recentSearchString[indexPath.row].value(forKey: "searchString") as? String
            searchBeginAnimation()
            searchTextField.text = data!
            searchData(searcText: data!)
        }
        searchTextField.resignFirstResponder()
    }
}
