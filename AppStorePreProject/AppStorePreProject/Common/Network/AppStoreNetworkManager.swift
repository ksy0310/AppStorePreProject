//
// iTunes Search API 연결 매니저.
//
//  AppStoreNetworkManager.swift
//  AppStorePreProject
//
//  Created by 김소영 on 2023/03/21.
//

import Foundation
import Alamofire

struct AppStoreNetworkManager {
    
    static let shared = AppStoreNetworkManager()
    
    let baseUrl = "https://itunes.apple.com/search?term="
    let languageString = "&country=kr"
    let entityString = "&entity=software"
    
    func getAppData(searchText: String,completion: @escaping (_ data: [AppInfoResult]) -> Void) {
        
        // 입력 텍스트가 공백이 있으면 +로 대체
        let searchString = searchText.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let urlString = baseUrl + searchString + languageString + entityString
        // 한글 가능
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        AF.request(encodedString,method: .get,parameters: nil,encoding: JSONEncoding.default,headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .responseJSON { response in
                switch response.result{
                    case .success:
                        guard let result = response.data else {return}
                                
                        do {
                            let decoder = JSONDecoder()
                            let json = try decoder.decode(ApiResponse.self, from: result)
                                
                            completion(json.results)
                                    
                        } catch {
                            print("error! : \(error.localizedDescription)")
                        }
                    default:
                        return
                }
            }
    }
}
