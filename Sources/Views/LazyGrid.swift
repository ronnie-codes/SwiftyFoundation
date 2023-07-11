//
//  LazyGrid.swift
//  NiceTube
//

import SwiftUI

public struct LazyGrid<Content: View>: View {
    let columns: [GridItem]
    @ViewBuilder let content: () -> Content

    public init(columns: [GridItem], content: @escaping () -> Content) {
        self.columns = columns
        self.content = content
    }

    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                content()
            }
            .padding()
        }
    }
}
