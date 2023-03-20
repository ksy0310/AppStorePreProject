//
//  InfoViewController.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/20.
//

import UIKit

class InfoViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
    }
    
    // 정보 화면 구성
    private func setupLayout() {
        
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismissDetail()
    }
    
}
