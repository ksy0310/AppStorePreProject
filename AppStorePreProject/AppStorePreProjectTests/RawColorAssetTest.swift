//
//  RawColorAssetTest.swift
//  AppStorePreProjectTests
//
//  Created by 김소영 on 2023/03/19.
//

import XCTest
@testable import AppStorePreProject

final class RawColorAssetTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRowColor() {
        // Color Set 값이 모두 있는 지 test.
        RowColorAsset.allCases.forEach { (asset) in
            let color = asset.load()
            XCTAssertNotNil(color,"error - load color : \(asset.rawValue)")
        }
    }

}
