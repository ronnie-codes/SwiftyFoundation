//
//  CardView.swift
//  NiceTube
//

import CachedAsyncImage
import SwiftUI

public struct CardView<ViewModel: CardViewModel>: View {
    private let viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            thumbnail
            headline
            subheadlines
            Spacer()
        }
    }

    private var thumbnail: some View {
        ZStack(alignment: .bottomTrailing) {
            CachedAsyncImage(url: viewModel.image) { image in
                image.resizable()
            } placeholder: {
                ActivityIndicator()
            }
            .cornerRadius(12)

            caption
        }
        .aspectRatio(16 / 9, contentMode: .fit)
        .padding(.bottom, 4)
    }

    private var caption: some View {
        Text(viewModel.caption)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 4)
            .background(Color.black)
            .padding(4)
            .cornerRadius(4)
    }

    private var headline: some View {
        Text(viewModel.title)
            .font(.headline)
            .foregroundColor(.primary)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .padding(.vertical, 4)
    }

    private var subheadlines: some View {
        VStack(alignment: .leading) {
            if let subtitle = viewModel.subtitle {
                Text(subtitle)
            }
            Text(viewModel.footer)
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(viewModel: CardViewModelMock())
                .frame(width: 336)
            CardView(viewModel: CardViewModelMock(subtitle: nil))
                .frame(width: 336)
        }
    }
}
