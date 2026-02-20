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
    @Query(sort: \Keyword.date, order: .reverse) private var keyword: [Keyword]
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    textField
                    contentView
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("검색")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        store.send(.onTapMyPage)
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }
                    
                }
            }
            .sheet(item: $store.scope(state: \.mypage, action: \.mypage)) { store in
                MypageView(store: store)
            }
            ///fullScreenCoverView도 가능
            // .fullScreenCover(item: $store.scope(state: \.mypage, action: \.mypage)) { store in
            //                MypageView(store: store)
            //            }
        }
    }
    
    private var textField: some View {
        TextField("키워드를 검색해보세요", text: $store.keyword.sending(\.inputText))
            .frame(height: 40)
            .font(.system(size: 15))
            .padding(.trailing, 32)
            .padding(.leading, 12)
            .padding(.vertical, 6)
            .focused($isFocused)
            .overlay(alignment: .trailing) {
                Button {
                    store.send(.clearText)
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                }
                .padding(.trailing, 12)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            }
            .onSubmit {
                saveKeyword(keyword: store.keyword)
                store.send(.onSubmit)
            }
            .padding(.horizontal, 20)
    }
    
    private var contentView: some View {
        
        Group {
            if let store = store.scope(state: \.result, action: \.result) {
                SearchResultView(store: store)
            } else {
                keywordList
            }
        }
    }
    
    var keywordList: some View {
        // 1. 키워드 리스트
        ForEach(keyword, id: \.self) {keyword in
            HStack{
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                    Text(keyword.title)
                        .font(.system(size: 16))
                        .padding(.leading, 10)
                        .lineLimit(1)
                    Spacer()
                }
                .onTapGesture {
                    store.send(.onTapKeyword(keyword.title))
                }
                Button {
                    deleteKeyword(keyword: keyword)
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
            .padding(20)
        }
    }
    func saveKeyword(keyword: String) {
        let data = Keyword(title: keyword, date: Date.now)
        context.insert(data)
        try? context.save()
    }
    
    func deleteKeyword(keyword: Keyword) {
        context.delete(keyword)
        try? context.save()
    }
}
