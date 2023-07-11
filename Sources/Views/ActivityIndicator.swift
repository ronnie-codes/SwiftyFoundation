//
//  ActivityIndicator.swift
//  SwiftySeatGeek
//

import SwiftUI

public struct ActivityIndicator: View {
    private let onAppear: (() -> Void)?

    public var body: some View {
        VStack(alignment: .center) {
            Spacer(minLength: 15)
            HStack(alignment: .center) {
                Spacer()
                ProgressView()
                Spacer()
            }
            Spacer(minLength: 15)
        }
        .onAppear {
            onAppear?()
        }
    }

    public init(onAppear: (() -> Void)? = nil) {
        self.onAppear = onAppear
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
