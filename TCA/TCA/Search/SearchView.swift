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
                        //MYpage진입
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }

                }
            }
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
                //키워드 저장
                saveKeyword(keyword: store.keyword)
                print("keyword\(keyword.first?.title)")
                //검색
            }
            .padding(.horizontal, 20)
    }
    
    private var contentView: some View {
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
                    //TODO: 검색
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
        //TODO: 밑에 코드 이해하기 - 키워드 탐색을 위해 존재
//        let descriptor =  FetchDescriptor<Keyword>(predicate: #Predicate{$0.title == keyword})
//        if let model = try? context.fetch(descriptor).first {
//            context.delete(model)
//        }
        context.delete(keyword)
        try? context.save()
    }
}
