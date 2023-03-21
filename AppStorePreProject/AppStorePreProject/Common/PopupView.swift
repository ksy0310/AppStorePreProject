//
//  PopupView.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/21.
//

import UIKit
import Lottie

protocol PopupViewDelegate: AnyObject {
    func onOkButtonAction()
}

class PopupView: UIView {
    weak var delegate: PopupViewDelegate?
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var popupView: UIView!
    
    @IBOutlet var animationView: UIView!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var okButton: UIButton!
    
    @IBOutlet var popupViewConstraintHeight: NSLayoutConstraint!
    
    enum AlertType {
        case profileAlert
        case notiAlert
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("PopupView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        if #available(iOS 13.0, *) {
            parentView.overrideUserInterfaceStyle = .light
        } else {
            
        }
        
        popupView.layer.masksToBounds = true
        popupView.layer.cornerRadius = 10
        
        okButton.layer.masksToBounds = true
        okButton.layer.cornerRadius = 5
        
    }
    

    func showAlert(message: String, alertType: AlertType) {
        
        self.messageLabel.text = message
        
        switch alertType {
        case .profileAlert:
            popupViewConstraintHeight.constant = 330
            
            let lottieView = LottieAnimationView(name: "profile")
            lottieView.frame = CGRect(x: 0, y: 0, width: animationView.frame.width, height: animationView.frame.height)
            lottieView.contentMode = .scaleAspectFill
            lottieView.loopMode = .loop
            animationView.addSubview(lottieView)
            lottieView.play()
            
        case .notiAlert:
            popupViewConstraintHeight.constant = 250
            
            let lottieView = LottieAnimationView(name: "star")
            lottieView.frame = CGRect(x: 0, y: 0, width: animationView.frame.width, height: animationView.frame.height)
            lottieView.contentMode = .scaleAspectFill
            lottieView.loopMode = .loop
            animationView.addSubview(lottieView)
            lottieView.play()
            
        }
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        if let del = delegate {
            del.onOkButtonAction()
        }
        
        parentView.removeFromSuperview()
    }
    
}
