//
//  SearchResultView.swift
//  TCA
//
//  Created by 소은 on 2/13/26.
//

import SwiftUI
import ComposableArchitecture

struct SearchResultView: View {
    @Bindable var store: StoreOf<SearchResultReducer>
    
    var body: some View {
        LazyVStack {
            ForEach(store.list) { item in
                searchResultListItem(item: item)
                
            }
        }
    }
}

struct searchResultListItem: View {
    let item: AppListItem
    
    var body: some View {
        VStack {
            HStack {
                getImage(url: item.iconUrl)
                
            }
        }
    }
    
    func getImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            Color.gray
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
