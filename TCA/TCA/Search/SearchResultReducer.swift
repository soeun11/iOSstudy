//
//  SearchResultReducer.swift
//  TCA
//
//  Created by 소은 on 2/13/26.
//

import ComposableArchitecture
import SwiftUI
import Dependencies

@Reducer
struct SearchResultReducer {
    @Dependency(\.appRepository) var repository: AppRepository
    @ObservableState
    struct State {
        
    }
    
    enum Action {
        
    }
    
    func fetchList(keyword: String) async {
        //TODO: Fetch List
      let result = await repository.fetchAppList(term: keyword, limit: 20)
    }
}


