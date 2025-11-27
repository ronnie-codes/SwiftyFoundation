//
//  DestinationRouter.swift
//  NiceTube
//

import SwiftUI

public struct DestinationRouter: View {
    private let destinations: [Destination]
    private let selection: Binding<UUID?>?

    public init(destinations: [Destination], selection: Binding<UUID?>? = nil) {
        self.destinations = destinations
        self.selection = selection
    }

    public var body: some View {
        #if os(tvOS) || os(iOS)
        if let selection {
            TabBarSelectable(selection: selection, destinations: destinations)
        } else {
            TabBar(destinations: destinations)
        }
        #else
        if let selection {
            MasterDetailSelectable(selection: selection, destinations: destinations)
        } else {
            MasterDetail(destinations: destinations)
        }
        #endif
    }
}
