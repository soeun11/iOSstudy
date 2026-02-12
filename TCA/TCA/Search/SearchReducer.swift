//
//  SearchReducer.swift
//  TCA
//
//  Created by 소은 on 2/12/26.
//

import ComposableArchitecture

@Reducer
struct SearchReducer {
    @ObservableState
    struct State {
        var keyword: String = ""
    }
    
    enum Action {
        case inputText(String)
        case clearText
    }
    
    var body: some Reducer<State, Action> {
      Reduce { state, action in
        switch action {
        case let .inputText(text):
          state.keyword = text
        case .clearText:
            state.keyword = ""
        }
          return .none
      }
    }
}
