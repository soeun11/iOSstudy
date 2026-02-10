//
//  MypageReducer.swift
//  TCA
//
//  Created by 소은 on 2/6/26.
//

//action과 state는 reducer안에 위치하면된다

import ComposableArchitecture

@Reducer
struct MypageStackReducer {
    @ObservableState
    enum State {
        case name(EditNameReducer.State)
        case email (EditEmailReducer.State)
        case image (EditImageReducer.State)
    }
    
    enum Action {
        case name(EditNameReducer.Action)
        case email (EditEmailReducer.Action)
        case image (EditImageReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.name, action: \.name) {
            EditNameReducer()
        }
        Scope(state: \.email, action: \.email) {
            EditEmailReducer()
        }
        Scope(state: \.image, action: \.image) {
            EditImageReducer()
        }
    }
}

@Reducer
struct MypageReducer {
    
    @ObservableState
    struct State {
        var path: StackState<MypageStackReducer.State> = .init()
        var userName: String = ""
        var userEmail: String = ""
    }
    
    enum Action {
        case onAppear(User)
        case path(StackActionOf<MypageStackReducer>)
        case tapOption(MyPageOption)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .onAppear(user):
                state.userName = user.name
                state.userEmail = user.email
                return Effect.none
                
            case let .tapOption(option):
                switch option {
                case .name:
                    state.path.append(.name(.init(name: state.userName)))
                case .email:
                    state.path.append(.email(.init(email: state.userEmail)))
                case .image:
                    state.path.append(.image(.init()))
                }
                return Effect.none
                
            case let .path(StackAction):
                switch StackAction {
                case let .element(id, action):
                    switch action {
                    case let .name(.onEditSuccess(name)):
                        state.userName = name
                        state.path.pop(from: id)
                    case let .email(.onEditSuccess(email)):
                        state.userEmail = email
                        state.path.pop(from: id)
                    default: return .none
                    }
                default: return .none
                }
                return Effect.none
            }
        }
        .forEach(\.path, action: \.path) {
            MypageStackReducer()
        }
    }
    
}
