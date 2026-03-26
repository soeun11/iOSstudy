//
//  URLRequest.BoxOffices.swift
//  BoxOffices
//
//  Created by 소은 on 3/3/26.
//

import Foundation

extension URLRequest {
    init(
        urlString: String,
        httpMethod: HTTPMethod,
        key: String,
        queryItems: [URLQueryItem]?
    
    ) throws {
        //URL Components
        guard var components = URLComponents(string: urlString) else {
            throw APIError.urlIsInvalid
        }
        
        //QueryItem
        components.queryItems = [URLQueryItem(name: "key", value: key)]
        if let queryItems {
            components.queryItems?.append(contentsOf: queryItems)
        }
        
        //URL Request
        guard let url = components.url else {
            throw APIError.urlIsInvalid
        }
        self.init(url: url)
        
        //HTTP Method
        self.httpMethod = httpMethod.capitalizedValue
    }
}
