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
        var result: SearchResultReducer.State?
    }
    
    enum Action {
        case inputText(String)
        case clearText
        case onTapMyPage
        case onEmptyText
        case onSubmit
        case onTapKeyword(String)
        case mypage(PresentationAction<MypageReducer.Action>)
        case result(SearchResultReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .inputText(text):
                state.keyword = text
                if text.isEmpty {
                    return .send(.onEmptyText)
                }
                return .none
            case .clearText:
                state.keyword = ""
                return .send(.onEmptyText)
            
            case .onEmptyText:
                state.result = nil
                return .none
            
            case .onSubmit:
                state.result =  .init(keyword: state.keyword)
                return .send(.result(.search))
                
            case .onTapKeyword( let keyword):
                state.keyword = keyword
                return .send(.onSubmit)
            
            case .onTapMyPage:
                state.mypage = .init()
                return .none
        
            case .result(let resultAction):
                return .none
            case .mypage:
                return .none
            }
        }
        //TODO: 여기 밑에 두개 $ 이거 위주로 차이점 공부하기
        .ifLet(\.$mypage, action: \.mypage) {
            MypageReducer()
        }
        .ifLet(\.result, action: \.result) {
            SearchResultReducer()
        }
    }
}
