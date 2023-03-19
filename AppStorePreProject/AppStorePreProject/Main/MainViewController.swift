//
//  MainViewController.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/19.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var profileButton: UIButton!
    @IBOutlet var searchTitleView: UIView!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchTilteViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var deleteButtonConstraintWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configuereSearch()
    }

    // 검색 화면 구성
    private func setupLayout() {
        self.searchTilteViewConstraintHeight.constant = 100
        self.deleteButtonConstraintWidth.constant = 0
        
        
        // profileImageView 클릭시 팝업 -> 내 소개
        profileButton.addTarget(self, action: #selector(profileImageViewAction), for: .touchUpInside)
        
        // 검색어 입력시 -> 검색 리스트
        
        // 키보드 리턴 키 변경
        searchTextField.returnKeyType = .search
        searchView.clipsToBounds = true
        searchView.layer.cornerRadius = 10
    }
    
    // action - 취소 버튼
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        // 취소버튼 클릭 -> searchTitleview height 100 (anim)
        //           -> textField ""
        //           -> 취소버튼 사라지기 (anim)
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        UIView.animate(withDuration: 0.5, animations: {
            self.searchTilteViewConstraintHeight.constant = 100
            self.deleteButtonConstraintWidth.constant = 0
            
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self.searchTitleView.isHidden = false
        })
    }
    
    // action - 검색 필드
    @IBAction func searchTextFieldAction(_ sender: UITextField) {
        // 검색 필드 포커스시 -> searchTitleview height 0 (anim)
        //               -> 취소버튼 보이기
        //               -> 키보드 올라오기
        
        searchTextField.becomeFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {
            self.searchTilteViewConstraintHeight.constant = 0
            self.deleteButtonConstraintWidth.constant = 55
            self.searchTitleView.isHidden = true
            self.view.layoutIfNeeded()
        })
    }
    
    // action - 프로필 버튼
    @objc func profileImageViewAction(sender: UIButton!) {
        // 이전 페이지가 없다 - 알럿
        let alert = UIAlertController(title: "개발자", message: "Name : 김소영 \n E-mail : ksy0310007@naver.com", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
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
