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
                    .padding(.bottom, 40)
                
            }
        }
        .padding(20)
    }
}

struct searchResultListItem: View {
    let item: AppListItem
    
    var body: some View {
        VStack {
            HStack {
                getImage(url: item.iconUrl)
                    .frame(width: 60, height: 60)
                
                Text(item.name)
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
            }
            getStar(rating: item.averageUserRating, count: item.userRatingCount)
            getScreenShot(urls: item.screenshotUrls)
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
    
    func getStar(rating: Float, count: Int) -> some View {
        HStack {
            ForEach(0..<5) { index in
                let currentValue = rating - Float(index)
                if currentValue >= 1 {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                } else if currentValue > 0 {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 12, height: 12)
                } else {
                    EmptyView()
                }
            }
            Text("\(count)")
                .font(.system(size: 12))
            Spacer()
        }
    }
    
    func getScreenShot (urls: [String]) -> some View {
        let prefix = urls.prefix(3)
        return HStack {
            ForEach(prefix, id: \.self) { url in
                getImage(url: url)
                    .frame(height: 200)
                
            }
        }
    }
}
