//
//  SearchView.swift
//  TCA
//
//  Created by 소은 on 2/12/26.
//

import SwiftUI
import ComposableArchitecture
import SwiftData



struct SearchView: View {
    @Environment(\.modelContext) private var context
    @Query private var keyword: [Keyword]
    var body: some View {
        TextField("키워드를 검색해보세요", text: <#T##Binding<String>#>)
    }
}
