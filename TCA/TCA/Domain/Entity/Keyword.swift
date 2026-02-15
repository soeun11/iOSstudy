//
//  Keyword.swift
//  TCA
//
//  Created by 소은 on 2/12/26.
//

import SwiftData
import Foundation

@Model
final class Keyword: Identifiable {
    var title: String
    var date: Date
    
    init(title: String, date: Date) {
        self.title = title
        self.date = date
    }
}
