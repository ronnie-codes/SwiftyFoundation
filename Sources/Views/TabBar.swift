//
//  TabBar.swift
//  NiceTube
//

import SwiftUI

// TODO: Fix
public struct TabBar: View {
    @State private var selection: UUID?

    let destinations: [Destination]

    public var body: some View {
        TabView(selection: $selection) {
            TabList(destinations: destinations, selection: $selection)
        }
    }
}

private struct TabList: View {
    let destinations: [Destination]

    @Binding var selection: UUID?

    var body: some View {
        ForEach(destinations, id: \.id) { module in
            TabItem(destination: module)
        }
    }
}

private struct TabItem: View {
    let destination: Destination

    var body: some View {
        destination.view.tabItem {
            SwiftUI.Label(destination.title, systemImage: destination.systemImage)
        }
    }
}
