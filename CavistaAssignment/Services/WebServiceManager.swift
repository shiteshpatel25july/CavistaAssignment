//
//  WebServiceManager.swift
//  CavistaAssignment
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh Patel. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

class WebServiceManager {
    func loadData<T: Decodable>(endpoint: String, resultType: T.Type, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completionHandler: @escaping (T?) -> Void) {
        
        guard let url = URL(string: endpoint) else {
            completionHandler(nil)
            return
        }

        AF.request(url, method: method, parameters: parameters, headers: headers).validate().responseDecodable(of: T.self) { response in
            
            guard let response = response.value else {
                completionHandler(nil)
                return
            }

            completionHandler(response)
        }
    }
}
