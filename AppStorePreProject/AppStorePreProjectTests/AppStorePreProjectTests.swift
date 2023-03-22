//
//  AppStorePreProjectTests.swift
//  AppStorePreProjectTests
//
//  Created by 김소영 on 2023/03/19.
//

import XCTest
@testable import AppStorePreProject

final class AppStorePreProjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 네트워크 연결 Test/ JSONDecoder Test
    var appInfo = [AppInfoResult]()
    func testNetwork() throws {
        if let url = URL(string: "https://itunes.apple.com/search?term=카카오뱅크&country=kr&entity=software") {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        do {
                            XCTAssertNotNil(response,"통신 성공")
                            
                            let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                            self.appInfo = response.results
                            XCTAssertNotNil(self.appInfo)
//                            XCTAssertEqual(self.appInfo.count, 31, "JSONDecoder 성공! 총 31개의 item이 있다.")
                        } catch {
                            print(error)
                        }
                    }
                }.resume()
            }
    }
    
    // averageUserRating
    // 4.262499999999998 -> 소수점 첫째자리까지만 출력 (반올림)
    func testRound() throws {
        let averageUserRating = 4.222499999999998
        var roundData = 0.0
        
        roundData = round(averageUserRating * 10) / 10
        
        print(roundData)
        XCTAssertEqual(roundData, 4.2, "소수점 첫째 자리까지 출력 완료.")
    }
    
    // 천 단위마다 ,찍기
    func testDecimal() throws {
        var count = 11260
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        let result = numberFormatter.string(from: NSNumber(value: count))
        print(result)
        XCTAssertEqual(result, "11,260", "천 단위마다 ,찍기 완료.")
    }

    // 바이트 -> MB로 단위 변경
    func testBytes() throws {
        var bytes = Double(307005440)
        var conversion = 0.0

        bytes = bytes / (1024 * 1024)
        conversion = round(bytes * 10) / 10
            
        XCTAssertEqual(conversion, 292.8, "MB 변환 완료")
    
    }
}
