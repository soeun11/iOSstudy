//
//  SearchView.swift
//  TCA
//
//  Created by 소은 on 2/12/26.
//

import SwiftUI
import ComposableArchitecture
import SwiftData
import UIKit

struct SearchView: View {
    @Bindable var store:  StoreOf<SearchReducer>
    @Environment(\.modelContext) private var context
    @Query private var keyword: [Keyword]
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField("키워드를 검색해보세요", text: $store.keyword.sending(\.inputText))
            .frame(height: 40)
            .font(.system(size: 15))
            .padding(.trailing, 32)
            .padding(.leading, 12)
            .padding(.vertical, 6)
            .focused($isFocused)
            .overlay(alignment: .topTrailing) {
                Button {
                    store.send(.clearText)
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.gray)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            }
            .onSubmit {
                //검색
                //키워드 저장
                saveKeyword(keyword: store.keyword)
                print("keyword\(keyword.first?.title)")
            }
    }
    
    func saveKeyword(keyword: String) {
        let data = Keyword(title: keyword, date: Date.now)
        context.insert(data)
        try? context.save()
    }
}
