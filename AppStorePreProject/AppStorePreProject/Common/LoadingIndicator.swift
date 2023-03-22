//
//  LoadingIndicator.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/22.
//

import UIKit

public class LoadingIndicator {

    public static let shared = LoadingIndicator()
    private var blurImageView = UIImageView()
    private var indicator = UIActivityIndicatorView()

    private init() {
        blurImageView.frame = UIScreen.main.bounds
        blurImageView.backgroundColor = UIColor.black
        blurImageView.isUserInteractionEnabled = true
        blurImageView.alpha = 0.5
        indicator.style = .large
        indicator.center = blurImageView.center
        indicator.startAnimating()
        indicator.color = RowColorAsset.subBackgroundColor.load()
    }

    func showIndicator() {
        DispatchQueue.main.async( execute: {
            UIApplication.shared.keyWindow?.addSubview(self.blurImageView)
            UIApplication.shared.keyWindow?.addSubview(self.indicator)
        })
    }
    func hideIndicator() {

        DispatchQueue.main.async( execute:
            {
                self.blurImageView.removeFromSuperview()
                self.indicator.removeFromSuperview()
        })
    }
}
