//
//  SearchService.swift
//  Bukku
//
//  Created by 김응철 on 2022/05/31.
//

import Foundation
import Alamofire

struct SearchService {
    static func fetchBooks(_ query: String, page: Int, completion: @escaping (BookResponseModel, Int) -> Void) {
        let url = URL(string: "https://dapi.kakao.com/v3/search/book")!
        let parameters: [String: Any] = [
            "target": "[title, person]",
            "size": 27,
            "query": query,
            "page": page
        ]
        let headers: HTTPHeaders = [ "Authorization": APIKEY ]
        
        AF
            .request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: BookResponseModel.self) { response in
                switch response.result {
                case .failure(let error):
                    print("RESPONSE ERROR!: \(error.localizedDescription)"); return
                case .success(let response):
                    DispatchQueue.main.async {
                        completion(response, page + 1)
                    }
                }
            }
    }
}

