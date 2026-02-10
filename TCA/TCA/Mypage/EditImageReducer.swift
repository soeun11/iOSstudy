//
//  EditImageReducer.swift
//  TCA
//
//  Created by 소은 on 2/6/26.
//

import ComposableArchitecture
import SwiftUI
import Photos

@Reducer
struct EditImageReducer {
    @ObservableState
    struct State {
        @Presents var alert: AlertState<Action>?
    }
    
    enum Action {
        case onAppear
        case authResult(Bool)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return Effect.run { send in
                    let isAuth = await PhotoManager.requestAuthorization()
                    await send(.authResult(isAuth))
                }
            case let .authResult(isAuth):
                if isAuth {
                    let assets = PhotoManager.getAssets()
                } else {
                    state.alert = AlertState.createAlert(type: .error(message: "권한이 없습니다."))
                }
                return .none
            }
            return .none
        }
    }
}

struct EditImagelView: View {
    @Bindable var store: StoreOf<EditImageReducer>
    
    var body: some View {
        Text("Edit Image")
            .onAppear {
                store.send(.onAppear)
            }
    }
}
