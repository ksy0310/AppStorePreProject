//
//  PopupView.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/21.
//

import UIKit

protocol PopupViewDelegate: class {
    func onOkButtonAction()
}

class PopupView: UIView {
    weak var delegate: PopupViewDelegate?
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var popupView: UIView!
    
    @IBOutlet var messageImageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var okButton: UIButton!
    
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
        
        messageImageView.layer.masksToBounds = true
        messageImageView.layer.cornerRadius = 35
    }
    

    func showAlert(message: String, alertType: AlertType) {
        
        self.messageLabel.text = message
        
        switch alertType {
        case .profileAlert:
            messageImageView.isHidden = false
            messageImageView.image = UIImage(named: "account")
        case .notiAlert:
            messageImageView.isHidden = false
            messageImageView.image = UIImage(named: "bluestar")
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
