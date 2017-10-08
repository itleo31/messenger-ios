//
//  APIClientType.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/20/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

protocol ApiClientType {
    
    var accessToken: String? { get set }
    
    func requestJSON(_ method: Alamofire.HTTPMethod,
        path: String,
        parameters: [String: Any]?,
        headers: [String: String]?) -> Observable<JSON>
}

extension ApiClientType {
    func requestJSON(_ method: Alamofire.HTTPMethod,
                     path: String,
                     parameters: [String: Any]? = nil,
                     headers: [String: String]? = nil) -> Observable<JSON> {
        return requestJSON(method, path: path, parameters: parameters, headers: headers)
    }
    
}
