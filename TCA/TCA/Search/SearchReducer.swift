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
        
        @Presents var mypage: MypageReducer.State?
    }
    
    enum Action {
        case inputText(String)
        case clearText
        case onTapMyPage
        case mypage(PresentationAction<MypageReducer.Action>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .inputText(text):
                state.keyword = text
                return .none
            case .clearText:
                state.keyword = ""
                return .none
                
            case .onTapMyPage:
                state.mypage = .init()
                return .none
                
            case .mypage:
                return .none
            }
        }
        .ifLet(\.$mypage, action: \.mypage) {
            MypageReducer()
        }
    }
}
