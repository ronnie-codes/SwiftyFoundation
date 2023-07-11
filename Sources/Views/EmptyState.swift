//
//  EmptyState.swift
//  SwiftySeatGeek
//

import SwiftUI

public struct EmptyState: View {
    public init() {}
    public var body: some View {
        GeometryReader { view in
            Text("Nothing to see here.")
                .font(.title)
                .position(x: view.frame(in: .local).midX, y: view.frame(in: .local).midY)
        }
    }
}

struct EmptyState_Previews: PreviewProvider {
    static var previews: some View {
        EmptyState()
    }
}
