//
//  ColorAssets.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/19.
//

import UIKit

enum RowColorAsset: String, CaseIterable {
    case defaultImageColor
    case mainTextColor
    case pointBlueColor
    case subBackgroundColor
    case subTextColor
    
    func load() -> UIColor? {
        return UIColor(named: self.rawValue)
    }
}
