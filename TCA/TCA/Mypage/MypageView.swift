//
//  MypageView.swift
//  TCA
//
//  Created by 소은 on 2/5/26.
//

import SwiftUI
import SwiftData
import Alamofire
import ComposableArchitecture

// 이름변경, 이메일 변경, 이미지변경
enum MyPageOption: CaseIterable {
    case name
    case email
    case image
    
    var title: String {
        switch self {
        case .name: return "이름"
        case .email: return "이메일"
        case .image: return "프로필 이미지"
        }
    }
}


struct MypageView: View {
    
    @Bindable var store: StoreOf<MypageReducer>
    @Query(sort: \User.name) var users: [User]
    
    var firstUser: User? {
        users.first
    }
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: \.path)) {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    ForEach(MyPageOption.allCases, id: \.self ) { option in
                        listItem(option: option)
                    }
                }
            }
            .onAppear {
                guard let firstUser else { return }
                store.send(.onAppear(firstUser))
            }
        } destination: { store in
            switch store.state {
            case .name:
                if let store = store.scope(state: \.name, action: \.name) {
                    EditNameView(store: store)
                }
            case .email:
                if let store = store.scope(state: \.email, action: \.email) {
                    EditEmailView(store: store)
                }
            case .image:
                if let store = store.scope(state: \.image, action: \.image) {
                    EditImagelView(store: store)
                }
            }
        }
        
    }
    
    func listItem(option: MyPageOption) -> some View {
        Button {
            store.send(.tapOption(option))
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(option.title)
                        .foregroundStyle(.white)
                        .font(.system(size: 18,weight: .bold))
                    Text(firstUser?.name ?? "")
                        .foregroundStyle(Color(uiColor: .lightGray))
                        .font(.system(size: 16, weight: .regular))
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .background(Color(UIColor.darkGray))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
