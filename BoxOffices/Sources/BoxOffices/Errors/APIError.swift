//
//  APIError.swift
//  BoxOffices
//
//  Created by 소은 on 3/3/26.
//

import Foundation

enum APIError: Error {
    case urlIsInvalid
    case responseIsNotExpected
    case requsetIsInvalid(_ statusCode: Int)
    case serverIsNotResponse(_ statusCode: Int)
    case responseIsUnsuccessful(_ statusCode: Int)
    
}

extension APIError {
    init?(httpResponse: HTTPURLResponse?) {
        guard let httpResponse else {
            self = APIError.responseIsNotExpected
            return
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
           return nil
        case 400..<500:
            self = APIError.requsetIsInvalid(httpResponse.statusCode)
        case 500..<600:
            self = APIError.serverIsNotResponse(httpResponse.statusCode)
        default:
            self = APIError.serverIsNotResponse(httpResponse.statusCode)
        }
        
    }
}
