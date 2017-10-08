//
//  APIClient.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/20/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa
import SwiftyJSON

class ApiClient: ApiClientType {
    
    var accessToken: String?
    
    let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func requestJSON(_ method: HTTPMethod, path: String, parameters: [String : Any]?, headers: [String : String]?) -> Observable<JSON> {
        return handleRequestJSON(method, requestUrl(path), parameters: parameters, headers: headers)
    }
    
    private var additionalHeaders: [String: String] {
        var headers: [String: String] = [:]
        if let token = accessToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    private func requestUrl(_ relativePath: String) -> URL {
        var url = URL(string: baseURL)!
        url.appendPathComponent(relativePath)
        return url
    }
    
    private func handleRequestJSON(_ method: Alamofire.HTTPMethod,
                               _ url: URLConvertible,
                               parameters: [String: Any]?,
                               headers: [String: String]?)
        -> Observable<JSON>
    {
        var requestHeaders = additionalHeaders
        headers?.forEach({ (item) in
            requestHeaders[item.key] = item.value
        })
        let callId = UUID().uuidString
        let result = request(method, url, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeaders)
            .flatMap({ req in
                return req
                    .logDebugRequest(callId: callId)
                    .validate().rx
                    .responseJSON()
            })
            
            
            .flatMap({ (response) -> Observable<JSON> in
                logDebug("Response \(callId): \(String(describing: response))")
                
                guard response.result.error == nil else {
                    logError("\(response.result.error!)")
                    if response.response?.statusCode == 401 {
                        throw BusinessError.unauthorized
                    } else if let data = response.data, let message = JSON(data: data)["message"].string {
                        throw BusinessError.apiError(message: message)
                    } else {
                        throw BusinessError.unknown(response.result.error)
                    }
                }
                
                if let value = response.result.value {
                    return Observable.just(JSON(value))
                } else {
                    return Observable.just(JSON([String: Any]()))
                }
                
                
            })
        
        return result
    }
}

extension Reactive where Base: DataRequest {
    func responseJSON() -> Observable<DataResponse<Any>> {
        return Observable.create({ (observer) -> Disposable in
            let request = self.base.responseJSON(completionHandler: { (response) in
                observer.onNextAndCompleted(response)
            })
            
            return Disposables.create {
                request.cancel()
            }
        })
    }
}

extension DataRequest {
    @discardableResult
    func logDebugRequest(callId: String) -> DataRequest {
        #if DEBUG
            logDebug("Request \(callId): \(self.debugDescription)")
        #endif
        return self
    }
}
