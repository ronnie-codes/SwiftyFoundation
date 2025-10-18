//
//  DestinationRouter.swift
//  NiceTube
//

import SwiftUI

public struct DestinationRouter: View {
    private let destinations: [Destination]

    public init(destinations: [Destination]) {
        self.destinations = destinations
    }

    public var body: some View {
        #if os(tvOS)
        TabBar(destinations: destinations)
        #else
        MasterDetail(destinations: destinations)
        #endif
    }
}
