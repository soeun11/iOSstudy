//
//  ScrollEffectsView.swift
//  CardScrollView
//
//  Created by 소은 on 2/27/26.
//

import SwiftUI


struct ScrollEffectsView: View {
    
    private let cards = Card.samples

    var body: some View {
        ScrollView {
            VStack(spacing: 60) {
                items
            }
            .padding(30)
        }
        .background {
            LinearGradient(
                colors: [Color.black, Color.black.opacity(0.7), Color.black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
    }

    private var items: some View {
        ForEach(cards) { card in
            CardView(card: card)
                .scrollTransition { content, phase in
            
                    content
                        .rotation3DEffect(
                            .degrees(phase.value * 35),
                            axis: (x: -1, y: 1, z: 0),
                            perspective: 0.75
                        )
                        .rotationEffect(.degrees(phase.value * 18))
                        .offset(x: phase.value * 110)
                        .blur(radius: abs(phase.value) * 5)
                        .scaleEffect(1 - abs(phase.value) * 0.12)
                }
        }
    }
}



#Preview {
    ScrollEffectsView()
        .preferredColorScheme(.dark)
}
