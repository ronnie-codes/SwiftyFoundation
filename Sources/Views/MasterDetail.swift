//
//  MasterDetailView.swift
//  NiceTube
//

import SwiftUI
import SwiftfulRouting

public struct MasterDetail: View {
    @State private var selection: UUID?

    let destinations: [Destination]

    public var body: some View {
        NavigationSplitView(
            sidebar: {
                Master(destinations: destinations, selection: $selection)
            },
            detail: {
                if let selection, let destination = destinations.first(where: { $0.id == selection }) {
                    Detail(destination: destination)
                } else {
                    // TODO: inject
//                    Text(R.string.localizable.sharedGreeting())
                }
            }
        )
        .background(.thinMaterial)
    }
}

private struct Master: View {
    let destinations: [Destination]

    @Binding var selection: UUID?

    var body: some View {
        List(destinations, id: \.id, selection: $selection) { item in
            SwiftUI.Label(item.title, systemImage: item.systemImage)
        }
    }
}

private struct Detail: View {
    let destination: Destination

    var body: some View {
        destination.view
    }
}
