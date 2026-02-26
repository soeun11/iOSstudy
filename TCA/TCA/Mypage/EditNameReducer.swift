//
//  EditNameReducer.swift
//  TCA
//
//  Created by 소은 on 2/6/26.
//

import ComposableArchitecture
import SwiftUI
import SwiftData

@Reducer
struct EditNameReducer {
    @ObservableState
    struct State {
        var name: String = ""
        
        @Presents var alert: AlertState<Action.AlertAction>? ///nil이면 사라지고, nil아니면 뜨도록
    }
    
    enum Action {
        case inputName(String)
        case clearText
        case onEditFail(String)
        case onEditSuccess(String)
        case alert(PresentationAction<AlertAction>)
        case showAlert(String)
        
        enum AlertAction {
            case confirmTapped
        }
    }
    
    var body: some Reducer<State, Action>  {
        Reduce { state, action in
            switch action {
            case let .inputName(name):
                state.name = name
                return .none
                
            case .clearText:
                state.name = ""
                return .none
                
            case let .onEditFail(message):
                print("Error: \(message)")
                return .send(.showAlert(message))
                
            case let .showAlert(message):
                state.alert = .init(
                    title: {
                        TextState("에러")
                    },
                    actions: {
                        ButtonState(action: .confirmTapped) {
                            TextState("확인")
                        }
                    },
                    message: {
                        TextState("에러가 발생했습니다. \(message)")
                    }
                )
                return .none
                
            case .onEditSuccess:
                return .none
                
            case let .alert(presentationAction):
                switch presentationAction {
                case let .presented(alertAction):
                    switch alertAction {
                    case .confirmTapped:
                        state.alert = nil
                        return .none
                    }
                case .dismiss:
                    state.alert = nil
                    return .none
                }
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}


