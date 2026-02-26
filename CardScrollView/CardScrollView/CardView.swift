//
//  CardView.swift
//  CardScrollView
//
//  Created by 소은 on 2/27/26.
//
import SwiftUI

// MARK: - CardView
struct CardView: View {
    let card: Card

    var body: some View {
        VStack(spacing: 14) {
            thumbnail

            VStack(alignment: .leading, spacing: 8) {
                Text(card.title)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(card.description)
                    .font(.subheadline)
                    .foregroundStyle(Color.white.opacity(0.7))
                    .lineLimit(2)

                metaRow
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(cardBackground)
        .overlay(cardBorder)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(radius: 14)
    }

    private var thumbnail: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.20),
                            Color.white.opacity(0.06),
                            Color.white.opacity(0.10)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(spacing: 10) {
                Image(systemName: card.thumbnailSymbol)
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundStyle(.white)

                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(Color.white.opacity(0.75))
            }
        }
        .frame(height: 160)
    }

    private var metaRow: some View {
        HStack(spacing: 14) {
            metaItem(title: "Size", value: card.sizeText)
            metaItem(title: "Type", value: card.typeText)
            metaItem(title: "Date", value: card.dateText)
            Spacer(minLength: 0)

            HStack(spacing: 12) {
                Image(systemName: "arrow.down.to.line")
                Image(systemName: "square.and.arrow.up")
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(Color.white.opacity(0.8))
        }
        .padding(.top, 6)
    }

    private func metaItem(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption2)
                .foregroundStyle(Color.white.opacity(0.55))
            Text(value)
                .font(.caption)
                .foregroundStyle(Color.white.opacity(0.85))
        }
    }

    private var cardBackground: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.ultraThinMaterial)

            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.10),
                            Color.white.opacity(0.04),
                            Color.white.opacity(0.08)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
    }

    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .stroke(Color.white.opacity(0.18), lineWidth: 1)
    }
}
