//
//  SearchService.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/31.
//

import Foundation
import Alamofire

struct SearchService {
    static func fetchBooks(_ query: String, completion: @escaping ([Book]) -> Void) {
        let url = URL(string: "https://dapi.kakao.com/v3/search/book")!
        let parameters: [String: String] = [
            "target": "title",
            "query": query
            // TODO: [] page, size 파라미터 추가
        ]
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 1a60cb934a4cd40e13a8c21222ab5397" ]
        
        AF
            .request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: BookResponseModel.self) { response in
                switch response.result {
                case .failure(let error):
                    print("RESPONSE ERROR!: \(error.localizedDescription)"); return
                case .success(let response):
                    print(response.documents)
                    completion(response.documents)
                }
            }
    }
}
