//
//  FirstAppearViewModifier.swift
//  SwiftyFoundation
//
//  Created by Ronny Vega on 10/22/25.
//

import SwiftUI

private struct FirstAppearViewModifier: ViewModifier {
    @State private var isFirstAppear: Bool = true
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                guard isFirstAppear else {
                    return
                }
                isFirstAppear = false
                action()
            }
    }
}

extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(FirstAppearViewModifier(action: action))
    }
}
