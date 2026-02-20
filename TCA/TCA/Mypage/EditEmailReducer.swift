//
//  EditEmailReducer.swift
//  TCA
//
//  Created by 소은 on 2/6/26.
//

import ComposableArchitecture
import SwiftUI
import SwiftData

@Reducer
struct EditEmailReducer {
    @ObservableState
    struct State: Equatable {
        var email: String = ""
        
        @Presents var alert: AlertState<Action>?
    }
    
    enum Action: Equatable {
        case inputEmail(String)
        case clearText
        case showAlert(String)
        case alert(PresentationAction<Action>)
        case onEditFail(String)
        case onEditSuccess(String)
        
    }
    
    var body: some Reducer<State, Action>  {
        
        Reduce { state, action in
            switch action {
            case .inputEmail(let email):
                state.email = email
                return .none
                
            case .clearText:
                state.email = ""
                return .none
                
            case .onEditFail(let message):
                return .send(.showAlert(message))
            case .onEditSuccess(let email):
                state.email = email
                return .none
            case .showAlert(let message):
                state.alert = .init(title: {
                    TextState("에러")
                }, actions: {
                    ButtonState {
                        TextState("확인")
                    }
                }, message: {
                    TextState("에러가 발생했습니다. \(message)")
                })
                return .none
            case .alert(let presentationAction):
                switch presentationAction {
                case .dismiss:
                    state.alert = nil
                    return .none
                case .presented:
                    return .none
                }
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
    
