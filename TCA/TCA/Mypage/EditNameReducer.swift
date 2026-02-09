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
            //alert action
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
                
            case .onEditSuccess:
                return .none
                
            case let .alert(presentationAction):
                switch presentationAction {
                case let .presented(action):
                    //TODO: 액션 처리
                    return .none
                case .dismiss:
                    state.alert = nil
                    return .none
                }
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}



struct EditNameView : View {
    @Bindable var store: StoreOf<EditNameReducer>
    
    @Query private var users: [User]
    @Environment(\.modelContext) private var context
    
    private var user: User? {
        users.first
    }
    
    var body: some View {
        VStack {
            Text("이름을 입력해주세요")
            TextField("이름을 입력해주세요", text: $store.name.sending(\.inputName))

            //        TextField("이름을 입력해주세요", text: Binding(get: {
            //            store.name
            //        }, set: { name in
            //            store.send(.inputName(name))
            //        }))
            /// 두 코드 주석처리한 것과 동일 $store처리로 밑에 함수와 동일한 기능을 하도록 함 (바인딩 대신에)
                .padding(.trailing, 32)
                .overlay(alignment: .topTrailing) {
                    if !store.name.isEmpty {
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
                .onSubmit {
                    editName(name: store.name)
                }
        }
        .padding(20)
        .alert($store.scope(state: \.alert, action: \.alert))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    editName(name: store.name)
                } label: {
                    Text("저장")
                }
            }
        }
    }
    
    func editName(name: String) {
        guard !name.isEmpty else {
            store.send(.onEditFail("이름을 입력해주세요."))
            return
        }
        
        user?.name = name
        
        do {
            try context.save()
            store.send(.onEditSuccess(name))
        } catch let error {
            store.send(.onEditFail(error.localizedDescription))
            
        }
    }
}
