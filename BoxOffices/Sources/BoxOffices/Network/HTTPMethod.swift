//
//  HTTPMethod.swift
//  BoxOffices
//
//  Created by 소은 on 3/3/26.
//

import Foundation

enum HTTPMethod: String {
    case get //post, delete, put

    var capitalizedValue: String {
        self.rawValue.capitalized /// get -> GET 이렇게 리턴
    }
}
