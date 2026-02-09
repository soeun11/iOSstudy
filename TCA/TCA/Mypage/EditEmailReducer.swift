//
//  EditEmailReducer.swift
//  TCA
//
//  Created by 소은 on 2/6/26.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct EditEmailReducer {
    struct State {
        var email: String
    }
    
    enum Action {
        
    }
}

struct EditEmailView: View {
    @Bindable var store: StoreOf<EditEmailReducer>
    
    var body: some View {
        Text("Edit Email")
    }
}
