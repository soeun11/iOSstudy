//
//  EditImageReducer.swift
//  TCA
//
//  Created by 소은 on 2/6/26.
//

import ComposableArchitecture
import SwiftUI
import Photos
import SwiftData

@Reducer
struct EditImageReducer {
    @ObservableState
    struct State {
        var userImage: Image?
        var assest: [PHAsset] = []
        var selectedPhoto: (id: String, data: Data)?
        @Presents var alert: AlertState<Action>?
    }
    
    enum Action {
        case onAppear(image: Data?)
        case setUserImageData(Data?)
        case setUserImage(Image)
        case authResult(Bool)
        case onSelectPhoto(id: String, data: Data)
        case onEditSuccess(Data)
        case onEditFail(String)
        case alert(PresentationAction<Action>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .onAppear(imageData):
                return Effect.run { send in
                    let isAuth = await PhotoManager.requestAuthorization()
                    await send(.authResult(isAuth))
                    await send(.setUserImageData(imageData))
                }
            case let .authResult(isAuth):
                if isAuth {
                    let assets = PhotoManager.getAssets()
                    state.assest = assets
                } else {
                    state.alert = AlertState.createAlert(type: .error(message: "권한이 없습니다."))
                }
                return .none
                
            case let .setUserImageData(data):
                guard let data, let uiImage = UIImage(data: data) else { return .none }
                return .send(.setUserImage(Image(uiImage: uiImage)))
                
            case let .setUserImage(image):
                state.userImage = image
                
            case let .onSelectPhoto(id, data):
                state.selectedPhoto = (id: id, data: data)
                
            case let .onEditSuccess(data):
                return .send(.setUserImageData(data))
                
            case let .onEditFail(error):
                state.alert = AlertState.createAlert(type: .error(message: error))
            case .alert:
                return .none
            }
            return .none
        }
    }
}

struct EditImagelView: View {
    @Bindable var store: StoreOf<EditImageReducer>
    
    let columns: [GridItem] = .init(repeating: .init(.flexible()), count: 3)
    
    @Query private var users: [User]
    @Environment(\.modelContext) var context
    private var user: User? {
        users.first
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("선택된 이미지")
                Group {
                    if let image = store.userImage {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        Color.gray.opacity(0.2)
                    }
                }
                .frame(width: 100, height: 100)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(store.assest, id: \.localIdentifier) { assest in
                    let isSelectedImgae = store.selectedPhoto?.id == assest.localIdentifier
                    AssestImageView(assest: assest, isSelected: isSelectedImgae) { data in
                        store.send(.onSelectPhoto(id: assest.localIdentifier, data: data))
                    }
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(8)
        }
        .toolbar(content: {
            ToolbarItem {
                Button(action: {
                    editImage(data: store.selectedPhoto?.data)
                }) {
                    Text("저장")
                }
            }
        })
        .alert(store: store.scope(state: \.$alert, action: \.alert))
        .onAppear {
            store.send(.onAppear(image: user?.imageData))
        }
    }
    
    func editImage(data: Data?) {
        guard let data else { return }
        user?.imageData = data
        do {
            try context.save()
            store.send(.onEditSuccess(data))
        } catch let error {
            store.send(.onEditFail(error.localizedDescription))
        }
    }
}
