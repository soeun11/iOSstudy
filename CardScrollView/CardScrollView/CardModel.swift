//
//  CardModel.swift
//  CardScrollView
//
//  Created by 소은 on 2/27/26.
//

import Foundation

struct Card: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let sizeText: String
    let typeText: String
    let dateText: String
    let thumbnailSymbol: String
}

extension Card {
    static let samples: [Card] = [
            .init(
                title: "3D House",
                description: "Data technology futuristic illustration. A wave of bright particles...",
                sizeText: "816x1456",
                typeText: "Upscale",
                dateText: "Today 5:19",
                thumbnailSymbol: "shippingbox.fill"
            ),
            .init(
                title: "Sunset",
                description: "A vibrant sunset cityscape with neon reflections and soft haze...",
                sizeText: "816x1456",
                typeText: "Upscale",
                dateText: "Today 5:19",
                thumbnailSymbol: "sun.max.fill"
            ),
            .init(
                title: "Night Street",
                description: "Cinematic night street scene with depth, bokeh lights, and rain...",
                sizeText: "816x1456",
                typeText: "Upscale",
                dateText: "Yesterday 11:40",
                thumbnailSymbol: "moon.stars.fill"
            ),
            .init(
                title: "Ocean Mood",
                description: "Soft gradients over ocean surface, minimal composition, calm tone...",
                sizeText: "816x1456",
                typeText: "Upscale",
                dateText: "Yesterday 09:12",
                thumbnailSymbol: "drop.fill"
            ),
            .init(
                title: "Neon City",
                description: "Cyberpunk inspired skyline with glowing neon signs and rainy reflections...",
                sizeText: "816x1456",
                typeText: "Upscale",
                dateText: "Today 8:42",
                thumbnailSymbol: "building.2.fill"
            ),
            .init(
                title: "Abstract Flow",
                description: "Dynamic abstract shapes flowing with vibrant gradients and motion blur...",
                sizeText: "816x1456",
                typeText: "Upscale",
                dateText: "Today 7:15",
                thumbnailSymbol: "waveform.path.ecg"
            ),
            .init(
                title: "Mountain Dawn",
                description: "Soft sunrise over layered mountains with atmospheric depth and mist...",
                sizeText: "816x1456",
                typeText: "Upscale",
                dateText: "Yesterday 6:30",
                thumbnailSymbol: "mountain.2.fill"
            ),
            .init(
                title: "Digital Grid",
                description: "Futuristic glowing grid system with perspective depth and particle light...",
                sizeText: "816x1456",
                typeText: "Upscale",
                dateText: "Yesterday 5:12",
                thumbnailSymbol: "square.grid.3x3.fill"
            ),
            .init(
                title: "Cosmic Dust",
                description: "Deep space nebula with vibrant cosmic dust and radiant star clusters...",
                sizeText: "816x1456",
                typeText: "Upscale",
                dateText: "Yesterday 3:47",
                thumbnailSymbol: "sparkles"
            ),
            .init(
                title: "Minimal Interior",
                description: "Modern minimal interior scene with soft lighting and natural textures...",
                sizeText: "816x1456",
                typeText: "Upscale",
                dateText: "2 days ago",
                thumbnailSymbol: "sofa.fill"
            )
        ]
}
