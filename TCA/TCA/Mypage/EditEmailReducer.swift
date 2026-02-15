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
        var email: String
        
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
    
struct EditEmailView: View {
    @Bindable var store: StoreOf<EditEmailReducer>
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    private var user: User? {
        users.first
    }
    
    var body: some View {
        VStack {
            Text(" Email을 입력해주세요")
            TextField("이메일을 입력해주세요", text: $store.email.sending(\.inputEmail))
                .padding(.trailing, 32)
                .overlay(alignment: .topTrailing) {
                    if !store.email.isEmpty {
                        Button {
                            store.send(.clearText)
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color(.systemGray))
                        }
                    }
                }
                .submitLabel(.done)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(20)
        .alert($store.scope(state: \.alert, action: \.alert))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    editEmail(email: store.email)
                } label: {
                    Text("저장")
                }
            }
        }
    }
    
    func editEmail(email: String) {
        guard !email.isEmpty else {
            store.send(.onEditFail("이메일을 입력해주세요."))
            return
        }
        
        user?.email = email
        do {
            try context.save()
            store.send(.onEditSuccess(email))
        } catch let error {
            store.send(.onEditFail("에러가 발생했습니다.\(error)"))
        }
    }
}
    
