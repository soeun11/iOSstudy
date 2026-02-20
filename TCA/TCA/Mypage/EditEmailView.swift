//
//  EditEmailView.swift
//  TCA
//
//  Created by 소은 on 2/20/26.
//
import SwiftUI
import SwiftData

import ComposableArchitecture

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
    
