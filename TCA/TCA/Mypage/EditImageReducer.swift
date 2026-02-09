//
//  EditImageReducer.swift
//  TCA
//
//  Created by 소은 on 2/6/26.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct EditImageReducer {
    struct State {
    }
    
    enum Action {
        
    }
}

struct EditImagelView: View {
    @Bindable var store: StoreOf<EditImageReducer>
    
    var body: some View {
        Text("Edit Image")
    }
}
