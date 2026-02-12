//
//  TCAApp.swift
//  TCA
//
//  Created by 소은 on 2/5/26.
//

import SwiftUI
import SwiftData
import ComposableArchitecture

@main
struct TCAApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView(store: Store(initialState: SearchReducer.State(), reducer: {SearchReducer()}))
            //            MypageView(store: Store(initialState: MypageReducer.State(), reducer: { MypageReducer() }))
        }
        .modelContainer(modelContainer)
    }
}

private var modelContainer: ModelContainer = {
    let schema = Schema([User.self, Keyword.self])
    
    let modelConfiguration = ModelConfiguration(schema: schema)
    
    do {
        let container = try ModelContainer(for: schema, configurations: modelConfiguration)
        Task { @MainActor in
            setInitialData(context: container.mainContext)
        }
        return container
        
    } catch {
        fatalError("ModelContainer 생성 실패")
    }
}()

//초깃값 설정
private func setInitialData(context: ModelContext) {
    let descriptor = FetchDescriptor<User>()

    if let isEmpty = try? context.fetch(descriptor).isEmpty, isEmpty {
        let user = User(name: "기본명", email: "name@gmail.com")
        context.insert(user)
        try? context.save()
    }
}
