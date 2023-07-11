//
//  LazyList.swift
//  NiceTube
//

import SwiftUI

public struct LazyList<Content: View>: View {
    @ViewBuilder let content: () -> Content

    public init(content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ScrollView {
            LazyVStack {
                content()
            }
            .padding()
        }
    }
}

struct LazyList_Previews: PreviewProvider {
    static var previews: some View {
        LazyList {
            EmptyState()
        }
    }
}
